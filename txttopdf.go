package main

import (
	"flag"
	"fmt"
	"os"
	"log"
	"io/ioutil"
	"github.com/jung-kurt/gofpdf"	
)

func main() {
	helpPtr := flag.Bool("help", false, "Print this help and exit")
	inputPtr := flag.String("i", "", "`inputfile` (txt) to convert to pdf. (Required)")
	outputPtr := flag.String("o", "output.pdf", "name of the `outputfile`.")
	formatPtr := flag.String("format", "A4", "supported formats are: A1, A2, A3, A4, A5, A6, letter, legal, tabloid.")
	fontsizePtr := flag.Float64("fontsize", 12.0, "fontsize.")
	flag.Parse()
	
	if *helpPtr {
		fmt.Fprintf(os.Stderr, "Usage of %s:\n", os.Args[0])
		flag.PrintDefaults()
		os.Exit(0)
	}
	if *inputPtr == "" {
		log.Fatalf("Missing input file; use '%s -help' to see options\n", os.Args[0])
	}
	txtfile := *inputPtr

	fmt.Println(txtfile)

	txtStr, err := ioutil.ReadFile(txtfile)
	if err != nil {
		log.Fatal(err)
	}
	
	pdf := gofpdf.New("P", "mm", *formatPtr, "")
	if pdf.Err() {
		log.Fatal(pdf.Error())
	}
	fontSize := *fontsizePtr
	pdf.SetFont("Times", "", fontSize)
	ht := pdf.PointConvert(fontSize)
	tr := pdf.UnicodeTranslatorFromDescriptor("") // "" defaults to "cp1252"
	pdf.SetMargins(20,20,30)
	pdf.SetAutoPageBreak(true, 50)
	write := func(str string) {
		// pdf.CellFormat(190, ht, tr(str), "", 1, "C", false, 0, "")
		pdf.MultiCell(0, ht, tr(str), "", "L", false)
		pdf.Ln(ht)
	}
	titleStr := "test"
	pdf.SetHeaderFunc(func() {
		headerFontSize := 12.0
		pdf.SetFont("Times", "B", headerFontSize)
		// Calculate width of title and position
		wd := pdf.GetStringWidth(titleStr) + 6
		pdf.SetX((210 - wd) / 2)
		// Colors of frame, background and text
		pdf.SetFillColor(230, 230, 0)
		// Thickness of frame (1 mm)
		pdf.SetLineWidth(1)
		// Title
		pdf.CellFormat(wd, pdf.PointConvert(headerFontSize), titleStr, "", 1, "C", true, 0, "")
		// Line break
		pdf.Ln(10)
	        
	})
	pdf.SetFooterFunc(func() {
		// Position at 1.5 cm from bottom
		pdf.SetY(-15)
		// Arial italic 8
		pdf.SetFont("Arial", "I", 8)
		// Text color in gray
		pdf.SetTextColor(128, 128, 128)
		// Page number
		pdf.CellFormat(0, 10, fmt.Sprintf("Page %d/{nb}", pdf.PageNo()),
			"", 0, "C", false, 0, "")
		
	})
	pdf.AliasNbPages("")
	
	pdf.AddPage()
	// pdf.MultiCell(0, ht, tr(string(txtStr)), "", "L", false)
	write(string(txtStr))
	pdf.OutputFileAndClose(*outputPtr)
}

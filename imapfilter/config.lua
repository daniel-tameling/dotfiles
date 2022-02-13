options.timeout = 1200
options.create = true
options.subscribe = true
options.expunge = true

status, password = pipe_from('pass Email/johndoe@gmail.com | head -n 1')
account1 = IMAP {
   server = "imap.gmail.com",
   username = "johndoe@gmail.com",
   password = password,
   ssl = "tls1"
}

-- update, event = account1["INBOX"]:enter_idle()
-- print(update, event)

messages = account1["INBOX"]:contain_field("List-Id", "freebsd.org")
messages:move_messages(account1["FreeBSD"])

messages = account1["INBOX"]:contain_field("List-ID", "tech@openbsd.org")
messages:move_messages(account1["OpenBSD"])

messages = account1["INBOX"]:contain_field("List-Id", "zsh.org")
messages:move_messages(account1["zsh"])

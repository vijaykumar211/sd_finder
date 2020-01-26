import sys

scope = sys.argv[1]
wordlist = open('./commonspeak2.txt').read().split('\n')


f = open("cs_domains_output.txt", "a")
for word in wordlist:
    if not word=="":
        sd = word.strip()+"."+scope
        f.write(sd+"\n")

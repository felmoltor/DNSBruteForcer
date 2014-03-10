DNSBruteForcer
==============

Zone transfer a domain  from its own NS servers and bruteforce subdomains.

Usage
-----

```
Usage: ./dnsbrute.rb [OPTIONS]
    -d, --domain DOMAIN              Domain to explore for robots.txt (This option needs program 'theharvester' in your PATH)
    -D, --dictionary FILE            Dicionary file containing the list of subdomains to check
    -f, --force-dns [DNS]            Force the enumeration against this DNS instead of the authoritative ones
    -o, --output [OFILE]             Save the summary of the execution to this CSV file
    -h, --help                       Help screen
```

Output example
--------------

```
felmoltor@kali:~/Tools/DNSBruteForcer$ ./dnsbrute.rb -d telepizza.es -D dictionaries/subdomains-top1mil-500.txt -o telepizza.es.csv

    ###########################
    #                         #
    #    DNS Brute Forcer     # 
    #      Version: 0.2       #
    #  Author: Felipe Molina  #
    #   Twitter: @felmoltor   #
    #                         #
    ###########################

    The authoritative servers of telepizza.es are: 
    - 217.116.0.176
    The name servers of telepizza.es are:
    - 217.116.0.177
    - 217.116.0.176
    Forcing the enumeration against domain nameservers (217.116.0.177, 217.116.0.176).
    Zone transfer is not allowed in any of it's NS.
    Starting bruteforce scan. Please be patient...
    22 hosts were found with the bruteforce attack!
    - www.telepizza.es - 213.192.247.250
    - ftp.telepizza.es - 217.116.0.173
    - webmail.telepizza.es - 217.116.0.154
    - smtp.telepizza.es - 217.116.0.228
    - test.telepizza.es - 213.192.228.101
    - m.telepizza.es - 213.192.247.250
    - blog.telepizza.es - 92.43.17.215
    - pop3.telepizza.es - 217.116.0.237
    - mx.telepizza.es - 217.116.0.227
    - imap.telepizza.es - 217.116.0.237
    - beta.telepizza.es - 212.80.167.162
    - secure.telepizza.es - secure.telepizza.es.c.footprint.net.
    - static.telepizza.es - downloads.telepizza.es.c.footprint.net.
    - web.telepizza.es - 213.192.228.126
    - crm.telepizza.es - sys.emailmanager.com.
    - cms.telepizza.es - 213.192.228.100
    - app.telepizza.es - app.emailmanager.com.
    - tv.telepizza.es - 213.192.228.101
    - docs.telepizza.es - 213.192.228.103
    - correo.telepizza.es - 213.192.247.252
    - content.telepizza.es - 213.192.228.126
    - lab.telepizza.es - 213.192.228.101
    Output file 'telepizza.es.csv' already exists. What do you want to do? (O)verwrite,(S)kip saving output,(R)ename: O
    Overwriting file...

```

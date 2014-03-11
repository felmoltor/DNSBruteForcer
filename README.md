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
    -g, --geo-info                   Get also the geographic information of the host from freegeoip.net
    -h, --help                       Help screen
```

Output example
--------------

```
felmoltor@kali:~/Tools/DNSBruteForcer$ ./dnsbrute.rb --geo-info -d cocacola.es -D dictionaries/subdomains-top1mil-500.txt -o cocacola.es.csv 

    ###########################
    #                         #
    #    DNS Brute Forcer     # 
    #      Version: 0.3       #
    #  Author: Felipe Molina  #
    #   Twitter: @felmoltor   #
    #                         #
    ###########################

    The authoritative servers of cocacola.es are: 
    - 161.162.84.154
    The name servers of cocacola.es are:
    - 161.162.84.151
    - 161.162.92.151
    - 144.228.255.10
    - 161.162.84.154
    - 206.228.179.10
    - 144.228.254.10
    Forcing the enumeration against domain nameservers (161.162.84.151, 161.162.92.151, 144.228.255.10, 161.162.84.154, 206.228.179.10, 144.228.254.10).
    Zone transfer is not allowed in any of it's NS.
    Starting bruteforce scan. Please be patient...
    12 hosts were found with the bruteforce attack!
    - www.cocacola.es - cocacola.es. (CNAME)
    - www.cocacola.es - 216.35.169.5 (A) - Chesterfield, Missouri, United States 
    - blog.cocacola.es - weblogs.edgesuite.net. (CNAME)
    - secure.cocacola.es - 216.35.169.5 (A) - Chesterfield, Missouri, United States 
    - static.cocacola.es - 216.35.169.5 (A) - Chesterfield, Missouri, United States 
    - api.cocacola.es - 216.35.169.5 (A) - Chesterfield, Missouri, United States 
    - download.cocacola.es - 216.35.169.5 (A) - Chesterfield, Missouri, United States 
    - info.cocacola.es - 82.144.108.216 (A) - Spain 
    - docs.cocacola.es - 82.144.108.202 (A) - Spain 
    - videos.cocacola.es - cocacola-genetsis.kewego.es. (CNAME)
    - auth.cocacola.es - 216.64.209.121 (A) - Chesterfield, Missouri, United States 
    - register.cocacola.es - 216.35.169.4 (A) - Chesterfield, Missouri, United States 
    
    Output file 'cocacola.es.csv' already exists. What do you want to do? (O)verwrite,(S)kip saving output,(R)ename: O
    Overwriting file...

```

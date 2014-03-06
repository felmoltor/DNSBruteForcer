DNSBruteForcer
==============

Zone transfer a domain  from its own NS servers and bruteforce subdomains.

Usage
-----

```
Usage: ./dnsbrute.rb [OPTIONS]
    -d, --domain DOMAIN              Domain to explore for robots.txt (This option needs program 'theharvester' in your PATH)
    -D, --dictionary FILE            Dicionary file containing the list of subdomains to check
    -o, --output [OFILE]             Save the summary of the execution to this CSV file
    -h, --help                       Help screen
```

Output example
--------------

```
felmoltor@kali:~/Tools/DNSBruteForcer$ ./dnsbrute.rb -d facebook.com -D dictionaries/subdomains-top1mil-50.txt 

    ###########################
    #                         #
    #    DNS Brute Forcer     # 
    #      Version: 0.1       #
    #  Author: Felipe Molina  #
    #   Twitter: @felmoltor   #
    #                         #
    ###########################

The authoritative servers of the domain are: 
- 69.171.239.12
Zone transfer is not allowed in any of it's NS.
Starting bruteforce scan...
14 hosts were found with the bruteforce attack!
- www.facebook.com
- ns1.facebook.com
- ns2.facebook.com
- m.facebook.com
- blog.facebook.com
- dev.facebook.com
- www2.facebook.com
- ns3.facebook.com
- new.facebook.com
- beta.facebook.com
- secure.facebook.com
- ns4.facebook.com
- static.facebook.com
- lists.facebook.com
```

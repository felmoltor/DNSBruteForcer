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
	harvester@kali:~/Tools/DNSBruteForcer$ ./dnsbrute.rb -d ujaen.es -D dictionaries/subdomains-top1mil-500.txt --geo-info 
	
	    ###########################
	    #                         #
	    #    DNS Brute Forcer     # 
	    #      Version: 0.3       #
	    #  Author: Felipe Molina  #
	    #   Twitter: @felmoltor   #
	    #                         #
	    ###########################
	
	The authoritative servers of ujaen.es are: 
	- 150.214.170.15
	The name servers of ujaen.es are:
	- 150.214.170.21
	- 150.214.170.22
	- 150.214.5.83
	- 150.214.170.15
	- 130.206.1.2
	- 130.206.1.3
	- 150.214.4.35
	Forcing the enumeration against domain nameservers (150.214.170.21, 150.214.170.22, 150.214.5.83, 150.214.170.15, 130.206.1.2, 130.206.1.3, 150.214.4.35).
	Zone transfer is not allowed in any of it's NS.
	Starting bruteforce scan. Please be patient...
	44 hosts were found with the bruteforce attack!
	- www.ujaen.es - sabiote.ujaen.es. (CNAME)
	- www.ujaen.es - 150.214.170.105 (A) - Jaén, Andalucia, Spain (Lat.: 37.7724, Long.: -3.7901)
	- ftp.ujaen.es - 150.214.170.29 (A) - Jaén, Andalucia, Spain (Lat.: 37.7724, Long.: -3.7901)
	- webmail.ujaen.es - 150.214.170.14 (A) - Jaén, Andalucia, Spain (Lat.: 37.7724, Long.: -3.7901)
	- smtp.ujaen.es - 150.214.170.9 (A) - Jaén, Andalucia, Spain (Lat.: 37.7724, Long.: -3.7901)
	- m.ujaen.es - www10.ujaen.es. (CNAME)
	- m.ujaen.es - 150.214.170.145 (A) - Jaén, Andalucia, Spain (Lat.: 37.7724, Long.: -3.7901)
	- pop3.ujaen.es - 150.214.170.44 (A) - Jaén, Andalucia, Spain (Lat.: 37.7724, Long.: -3.7901)
	- vpn.ujaen.es - 150.214.100.200 (A) - Sevilla, Andalucia, Spain (Lat.: 37.3824, Long.: -5.9761)
	- imap.ujaen.es - 150.214.170.44 (A) - Jaén, Andalucia, Spain (Lat.: 37.7724, Long.: -3.7901)
	- dns2.ujaen.es - 150.214.170.22 (A) - Jaén, Andalucia, Spain (Lat.: 37.7724, Long.: -3.7901)
	- dns1.ujaen.es - 150.214.170.21 (A) - Jaén, Andalucia, Spain (Lat.: 37.7724, Long.: -3.7901)
	- portal.ujaen.es - 150.214.170.176 (A) - Jaén, Andalucia, Spain (Lat.: 37.7724, Long.: -3.7901)
	- video.ujaen.es - 150.214.170.200 (A) - Jaén, Andalucia, Spain (Lat.: 37.7724, Long.: -3.7901)
	- www3.ujaen.es - scint.ujaen.es. (CNAME)
	- www3.ujaen.es - 150.214.170.56 (A) - Jaén, Andalucia, Spain (Lat.: 37.7724, Long.: -3.7901)
	- cms.ujaen.es - www10.ujaen.es. (CNAME)
	- cms.ujaen.es - 150.214.170.145 (A) - Jaén, Andalucia, Spain (Lat.: 37.7724, Long.: -3.7901)
	- proxy.ujaen.es - 150.214.170.14 (A) - Jaén, Andalucia, Spain (Lat.: 37.7724, Long.: -3.7901)
	- ftp2.ujaen.es - fatfile.ujaen.es. (CNAME)
	- ftp2.ujaen.es - 150.214.170.32 (A) - Jaén, Andalucia, Spain (Lat.: 37.7724, Long.: -3.7901)
	- web1.ujaen.es - pcred06-vm.ujaen.es. (CNAME)
	- web1.ujaen.es - 150.214.170.116 (A) - Jaén, Andalucia, Spain (Lat.: 37.7724, Long.: -3.7901)
	- web2.ujaen.es - pcred06-vm.ujaen.es. (CNAME)
	- web2.ujaen.es - 150.214.170.116 (A) - Jaén, Andalucia, Spain (Lat.: 37.7724, Long.: -3.7901)
	- blogs.ujaen.es - 150.214.170.181 (A) - Jaén, Andalucia, Spain (Lat.: 37.7724, Long.: -3.7901)
	- relay.ujaen.es - 150.214.170.33 (A) - Jaén, Andalucia, Spain (Lat.: 37.7724, Long.: -3.7901)
	- relay.ujaen.es - 150.214.170.17 (A) - Jaén, Andalucia, Spain (Lat.: 37.7724, Long.: -3.7901)
	- www4.ujaen.es - 150.214.170.250 (A) - Jaén, Andalucia, Spain (Lat.: 37.7724, Long.: -3.7901)
	- tv.ujaen.es - xserv1.ujaen.es. (CNAME)
	- tv.ujaen.es - 150.214.174.158 (A) - Jaén, Andalucia, Spain (Lat.: 37.7724, Long.: -3.7901)
	- ldap.ujaen.es - 150.214.170.120 (A) - Jaén, Andalucia, Spain (Lat.: 37.7724, Long.: -3.7901)
	- correo.ujaen.es - sabiote.ujaen.es. (CNAME)
	- correo.ujaen.es - 150.214.170.105 (A) - Jaén, Andalucia, Spain (Lat.: 37.7724, Long.: -3.7901)
	- vpn2.ujaen.es - 150.214.100.50 (A) - Sevilla, Andalucia, Spain (Lat.: 37.3824, Long.: -5.9761)
	- www5.ujaen.es - pcredes.ujaen.es. (CNAME)
	- www5.ujaen.es - 150.214.170.5 (A) - Jaén, Andalucia, Spain (Lat.: 37.7724, Long.: -3.7901)
	- www6.ujaen.es - yelmo.ujaen.es. (CNAME)
	- www6.ujaen.es - 150.214.170.36 (A) - Jaén, Andalucia, Spain (Lat.: 37.7724, Long.: -3.7901)
	- orion.ujaen.es - 150.214.170.134 (A) - Jaén, Andalucia, Spain (Lat.: 37.7724, Long.: -3.7901)
	- faq.ujaen.es - blogs.ujaen.es. (CNAME)
	- faq.ujaen.es - 150.214.170.181 (A) - Jaén, Andalucia, Spain (Lat.: 37.7724, Long.: -3.7901)
	- idp.ujaen.es - posada3.ujaen.es. (CNAME)
	- idp.ujaen.es - 150.214.170.193 (A) - Jaén, Andalucia, Spain (Lat.: 37.7724, Long.: -3.7901)
	Results were saved in 'outputs/csv/ujaen.es.csv'.
Maps were saved in 'outputs/maps/ujaen.es.kml'.

```

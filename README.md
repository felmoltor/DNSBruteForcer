DNSBruteForcer
==============

Zone transfer a domain  from its own NS servers and bruteforce subdomains.

Sample usage video: https://www.youtube.com/watch?v=pljrlDSylNM

Usage
-----

```
Usage: ./dnsbrute.rb [OPTIONS]
    -d, --domain DOMAIN              Domain to explore for hosts by bruteforce.
    -D, --dictionary FILE            Dicionary file containing the list of subdomains to check
    -t, --threads [NTHREADS]         Number of threads used to ask DNS servers in bruteforce attack [Default: 5]
    -g, --geo-info                   Get also the geographic information of the host from freegeoip.net
    -w, --whois                      Get also the whois information of every hostname found
    -f, --force-dns [DNS]            Force the enumeration against this DNS instead of the authoritative ones
    -o, --overwrite                  Force overwriting previous output files
    -h, --help                       Help screen
```

Output example
--------------

```
	    ###########################
	    #                         #
	    #    DNS Brute Forcer     # 
	    #      Version: 0.4       #
	    #  Author: Felipe Molina  #
	    #   Twitter: @felmoltor   #
	    #                         #
	    ###########################
	
	The authoritative servers of feedly.com are: 
	- 173.246.97.2
	The name servers of feedly.com are:
	- 217.70.182.20
	- 217.70.184.40
	- 173.246.97.2
	Forcing the enumeration against domain nameservers (217.70.182.20, 217.70.184.40, 173.246.97.2).
	Zone transfer is not allowed in any of it's NS.
	Starting bruteforce scan. Please be patient...
	Retrieving whois information of 'www.feedly.com'
	Retrieving geographic information of '65.19.138.1'
	Retrieving whois information of 'www.feedly.com'
	Retrieving geographic information of '65.19.138.2'
	Retrieving whois information of 'test.feedly.com'
	Retrieving geographic information of '216.218.207.141'
	Retrieving whois information of 'img.feedly.com'
	Retrieving geographic information of 'ghs.google.com.'
	Retrieving whois information of 'www3.feedly.com'
	Retrieving geographic information of 'www2.feedly.com.'
	Retrieving whois information of 'www3.feedly.com'
	Retrieving geographic information of 'ghs.google.com.'
	Retrieving whois information of 'search.feedly.com'
	Retrieving geographic information of 'www.feedly.com.'
	Retrieving whois information of 'search.feedly.com'
	Retrieving geographic information of 'www.feedly.com.'
	Retrieving whois information of 'search.feedly.com'
	Retrieving geographic information of '65.19.138.2'
	Retrieving whois information of 'search.feedly.com'
	Retrieving geographic information of '65.19.138.1'
	Retrieving whois information of 'mail.feedly.com'
	Retrieving geographic information of 'ghs.google.com.'
	Retrieving whois information of 'm.feedly.com'
	Retrieving geographic information of '216.218.207.140'
	Retrieving whois information of 'static.feedly.com'
	Retrieving geographic information of '66.160.192.51'
	Retrieving whois information of 'email.feedly.com'
	Retrieving geographic information of 'sendgrid.net.'
	Retrieving whois information of 'blog.feedly.com'
	Retrieving geographic information of 'devhd.wordpress.com.'
	Retrieving whois information of 'beta.feedly.com'
	Retrieving geographic information of '216.218.207.141'
	Retrieving whois information of 'images.feedly.com'
	Retrieving geographic information of 'ghs.googlehosted.com.'
	Retrieving whois information of 'dev.feedly.com'
	Retrieving geographic information of '10.0.1.8'
	Retrieving whois information of 'proxy.feedly.com'
	Retrieving geographic information of 'ghs.google.com.'
	Retrieving whois information of 'www2.feedly.com'
	Retrieving geographic information of 'ghs.google.com.'
	Retrieving whois information of 'svn.feedly.com'
	Retrieving geographic information of '216.218.207.140'
	21 hosts were found with the bruteforce attack!
	- www.feedly.com - 65.19.138.1 (A) - Fremont, California, United States (Lat.: 37.5155, Long.: -121.8962)
	- www.feedly.com - 65.19.138.2 (A) - Fremont, California, United States (Lat.: 37.5155, Long.: -121.8962)
	- test.feedly.com - 216.218.207.141 (A) - Fremont, California, United States (Lat.: 37.5155, Long.: -121.8962)
	- img.feedly.com - ghs.google.com. (CNAME)
	- www3.feedly.com - www2.feedly.com. (CNAME)
	- www3.feedly.com - ghs.google.com. (CNAME)
	- search.feedly.com - www.feedly.com. (CNAME)
	- search.feedly.com - www.feedly.com. (CNAME)
	- search.feedly.com - 65.19.138.2 (A) - Fremont, California, United States (Lat.: 37.5155, Long.: -121.8962)
	- search.feedly.com - 65.19.138.1 (A) - Fremont, California, United States (Lat.: 37.5155, Long.: -121.8962)
	- mail.feedly.com - ghs.google.com. (CNAME)
	- m.feedly.com - 216.218.207.140 (A) - Fremont, California, United States (Lat.: 37.5155, Long.: -121.8962)
	- static.feedly.com - 66.160.192.51 (A) - Stayton, Oregon, United States (Lat.: 44.8155, Long.: -122.7292)
	- email.feedly.com - sendgrid.net. (CNAME)
	- blog.feedly.com - devhd.wordpress.com. (CNAME)
	- beta.feedly.com - 216.218.207.141 (A) - Fremont, California, United States (Lat.: 37.5155, Long.: -121.8962)
	- images.feedly.com - ghs.googlehosted.com. (CNAME)
	- dev.feedly.com - 10.0.1.8 (A) - Reserved (Lat.: 0, Long.: 0)
	- proxy.feedly.com - ghs.google.com. (CNAME)
	- www2.feedly.com - ghs.google.com. (CNAME)
	- svn.feedly.com - 216.218.207.140 (A) - Fremont, California, United States (Lat.: 37.5155, Long.: -121.8962)
	Output file 'outputs/csv/feedly.com.csv' already exists. What do you want to do? (O)verwrite,(S)kip saving output,(R)ename: o
	Overwriting file...
	Results were saved in 'outputs/csv/feedly.com.csv'.
	Output file 'outputs/maps/feedly.com.kml' already exists. What do you want to do? (O)verwrite,(S)kip saving output,(R)ename: o
	Overwriting file...
	Maps were saved in 'outputs/maps/feedly.com.kml'.

```

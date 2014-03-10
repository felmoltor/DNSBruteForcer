#!/usr/bin/env ruby
# encoding: utf-8

require 'pp'
require 'optparse'
require 'colorize'
require_relative 'DNSBruteForcer'


############

def parseOptions()
  options = {
    :domain => nil,
    :dictionary => nil,
    :dns => nil,
    :geoinfo => nil,
    :outputfile => nil
  }
  optparse = OptionParser.new do |opts|   
    
    opts.banner = "Usage: #{__FILE__} [OPTIONS]"
     
    opts.on( '-d', '--domain DOMAIN', String, "Domain to explore for robots.txt (This option needs program 'theharvester' in your PATH)" ) do |domain|
      options[:domain] = domain
    end
    opts.on( '-D', '--dictionary FILE', String, "Dicionary file containing the list of subdomains to check" ) do |dictionary|
      options[:dictionary] = dictionary
    end
    opts.on( '-f', '--force-dns [DNS]', 'Force the enumeration against this DNS instead of the authoritative ones' ) do |dns|
      options[:dns] = dns
    end
    opts.on( '-g', '--geo-info', 'Get also the geographic information of the host from freegeoip.net' ) do
      options[:geoinfo] = true
    end
    opts.on( '-o', '--output [OFILE]', 'Save the summary of the execution to this CSV file' ) do |ofile|
      options[:outputfile] = ofile
    end
    opts.on( '-h', '--help', 'Help screen' ) do
      puts optparse
      exit
    end
  end
  
  optparse.parse!
  
  if options[:domain].nil? or options[:dictionary].nil?
    puts optparse
    raise OptionParser::MissingArgument
  end
  
  return options
end

##########################

def avoidOverwritingOutput(ofile)
  if File.exists?(ofile)
    while 1 # Only finish when there is a correct choice
      print "Output file '#{ofile}' already exists. What do you want to do? (O)verwrite,(S)kip saving output,(R)ename: "
      c = gets.chomp.upcase
      case c
      when "O"
        puts "Overwriting file..."
        return ofile
      when "S"
        puts "Skipping the save output phase... "
        return nil
      when "R"
        print "Please, provide the new name for the output file: "
        newname = gets.chomp
        return newname
      end
    end    
  else
    return ofile
  end
end


  
###################

def saveOutputCSV(ofile, foundhosts)
  f = File.open(ofile,"w")
  f.puts("hostname;address;type;Geo. Info.")
  foundhosts.each{|h|
    geoinfo = ""
    if !h[:geo].nil?
      geoinfo += "#{h[:geo]["city"]}, " if !h[:geo]["city"].nil? and h[:geo]["city"].size > 0
      geoinfo += "#{h[:geo]["region_name"]}, " if !h[:geo]["city"].nil? and h[:geo]["region_name"].size > 0
      geoinfo += "#{h[:geo]["country_name"]} "  if !h[:geo]["city"].nil? and h[:geo]["country_name"].size > 0
      geoinfo += "(Lat.: #{h[:geo]["latitude"]}, Long.: #{h[:geo]["longitude"]})" if !h[:geo]["latitude"].nil? and h[:geo]["latitude"] > 0 and !h[:geo]["longitude"].nil? and h[:geo]["longitude"] > 0
    end
    f.puts "#{h[:name]};#{h[:ip]};#{h[:type]};#{geoinfo}" 
  }
  f.close
end


############

def printBanner()
    banner = %q{
    ###########################
    #                         #
    #    DNS Brute Forcer     # 
    #      Version: 0.2       #
    #  Author: Felipe Molina  #
    #   Twitter: @felmoltor   #
    #                         #
    ###########################
}
  puts banner.cyan
end

########
# MAIN #
########


printBanner()
op = parseOptions()

dnsb = DNSBruteForcer.new()
dnsb.geodetails = op[:geoinfo]
auths = dnsb.getAuthDNSServers(op[:domain])
puts "The authoritative servers of #{op[:domain]} are: "
auths.each{|s|
  puts "- #{s}"
}
nsservers = dnsb.getAllDNSServer(op[:domain])
puts "The name servers of #{op[:domain]} are:"
nsservers.each{|s|
  puts "- #{s}"
}

if !op[:dns].nil?
  puts "Forcing the enumeration against customiced DNS '#{op[:dns]}'"
  dnsb.setNameServers(op[:dns])
else
  puts "Forcing the enumeration against domain nameservers (#{nsservers.join(', ')})."
  dnsb.setNameServers(nsservers)  
end

zones = dnsb.transferZone(op[:domain])

if !zones.nil?
    puts "Zone transfer is allowed in one or more of it's NS!".green
    pp zones
else
    puts "Zone transfer is not allowed in any of it's NS.".red
    puts "Starting bruteforce scan. Please be patient..."
    if File.exists?(op[:dictionary])
        dnsb.dictionary = op[:dictionary]
        hosts = dnsb.bruteforceSubdomains(op[:domain])
        if !hosts.nil? and hosts.size > 0
          puts "#{hosts.size} hosts were found with the bruteforce attack!".green
          hosts.each {|h|
            print "- #{h[:name]} - #{h[:ip].to_s} (#{h[:type]})"
            if op[:geoinfo] and !h[:geo].nil?
              print " - "
              print "#{h[:geo]["city"]}, " if !h[:geo]["city"].nil? and h[:geo]["city"].size > 0
              print "#{h[:geo]["region_name"]}, " if !h[:geo]["city"].nil? and h[:geo]["region_name"].size > 0
              print "#{h[:geo]["country_name"]} "  if !h[:geo]["city"].nil? and h[:geo]["country_name"].size > 0
              print "(Lat.: #{h[:geo]["latitude"]}, Long.: #{h[:geo]["longitude"]})" if !h[:geo]["latitude"].nil? and h[:geo]["latitude"] > 0 and !h[:geo]["longitude"].nil? and h[:geo]["longitude"] > 0
            end
            puts ""  
          }
        else
          puts "No hosts were found with the bruteforce attack :-(".red
        end
    else
        puts "Dictionary file #{op[:dictionary]} couldn't be found. Skipping bruteforce attack..."
    end
end

# Save results into outfile
if !op[:outputfile].nil?
  of = avoidOverwritingOutput(op[:outputfile])
  saveOutputCSV(of,hosts)
end

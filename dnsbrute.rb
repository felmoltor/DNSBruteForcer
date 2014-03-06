#!/usr/bin/env ruby
# encoding: utf-8

require 'pp'
require 'optparse'
require 'colorize'
require_relative 'DNSBruteForcer'


def parseOptions()
  options = {
    :domain => nil,
    :dictionary => nil,
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

def printBanner()
    banner = %q{
    ###########################
    #                         #
    #    DNS Brute Forcer     # 
    #      Version: 0.1       #
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
auths = dnsb.getAuthDNSServers(op[:domain])
puts "The authoritative servers of the domain are: "
auths.each{|s|
  puts "- #{s}"
}
dnsb.setNameServers(auths)
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
        if hosts.size > 0
          puts "#{hosts.size} hosts were found with the bruteforce attack!".green
          hosts.each {|h|
            puts "- #{h}"  
          }
        else
          puts "No hosts were found with the bruteforce attack :-(".red
        end
    else
        puts "Dictionary file #{op[:dictionary]} couldn't be found. Skipping bruteforce attack..."
    end
end

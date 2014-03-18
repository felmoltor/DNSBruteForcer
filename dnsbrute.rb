#!/usr/bin/env ruby
# encoding: utf-8

require 'pp'
require 'optparse'
require 'colorize'
require 'nokogiri'
require_relative 'DNSBruteForcer'


############

def parseOptions()
  options = {
    :domain => nil,
    :dictionary => nil,
    :dns => nil,
    :geoinfo => false,
    :whois => false,
    :nthreads => 5
  }
  optparse = OptionParser.new do |opts|   
    
    opts.banner = "Usage: #{__FILE__} [OPTIONS]"
     
    opts.on( '-d', '--domain DOMAIN', String, "Domain to explore for hosts by bruteforce." ) do |domain|
      options[:domain] = domain
    end
    opts.on( '-D', '--dictionary FILE', String, "Dicionary file containing the list of subdomains to check" ) do |dictionary|
      options[:dictionary] = dictionary
    end
    opts.on( '-t', '--threads [NTHREADS]', 'Number of threads used to ask DNS servers in bruteforce attack [Default: 5]' ) do |nthreads|
      options[:nthreads] = nthreads
    end
    opts.on( '-g', '--geo-info', 'Get also the geographic information of the host from freegeoip.net' ) do
      options[:geoinfo] = true
    end
    opts.on( '-w', '--whois', 'Get also the whois information of every hostname found' ) do
      options[:whois] = true
    end
    opts.on( '-f', '--force-dns [DNS]', 'Force the enumeration against this DNS instead of the authoritative ones' ) do |dns|
      options[:dns] = dns
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

def saveOutputKML(ofile,foundhosts)
  oxml = File.open(ofile,"w")
  
  builder = Nokogiri::XML::Builder.new {|xml|
    xml.kml('xmlns' => "http://earth.google.com/kml/2.2") {
      xml.Document{
        xml.name "#{ofile}"
        foundhosts.each {|h|
          if !h[:geo].nil?
            xml.Placemark {
              xml.name "#{h[:name]} - #{h[:ip]}"  
              whois = h[:whois].gsub("\n","<br/>")
              xml.description """
                #{h[:name]} - #{h[:ip]}.<br/> 
                Record type: #{h[:type]}<br/>
                Location: #{h[:geo]["city"]}, #{h[:geo]["region_name"]}, #{h[:geo]["country_name"]}<br/> 
                <br/>
                ==================
                <br/>
                #{whois}<br/>
                """
              xml.Point {
                xml.coordinates "#{h[:geo]["longitude"].to_f},#{h[:geo]["latitude"].to_f},0.0"
              }
            }
          end
        }
      }
    }
  }
  oxml.puts builder.to_xml
  oxml.close
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
      geoinfo += "#{h[:geo]["region_name"]}, " if !h[:geo]["region_name"].nil? and h[:geo]["region_name"].size > 0
      geoinfo += "#{h[:geo]["country_name"]} "  if !h[:geo]["country_name"].nil? and h[:geo]["country_name"].size > 0
      geoinfo += "(Lat.: #{h[:geo]["latitude"]}, Long.: #{h[:geo]["longitude"]})" if !h[:geo]["latitude"].nil? and !h[:geo]["longitude"].nil?
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
    #      Version: 0.3       #
    #  Author: Felipe Molina  #
    #   Twitter: @felmoltor   #
    #                         #
    ###########################
}
  puts banner.cyan
end

############

def createFolders()
  if !Dir.exists?("outputs")
    Dir.mkdir("outputs")
  end
  if !Dir.exist?("outputs/csv")
    Dir.mkdir("outputs/csv")
  end
  if !Dir.exist?("outputs/maps")
    Dir.mkdir("outputs/maps")
  end
end

########
# MAIN #
########

createFolders()
printBanner()
op = parseOptions()

dnsb = DNSBruteForcer.new()
dnsb.geodetails = op[:geoinfo]
dnsb.whois = op[:whois]
dnsb.threads = op[:nthreads]
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
              print "(Lat.: #{h[:geo]["latitude"]}, Long.: #{h[:geo]["longitude"]})" if !h[:geo]["latitude"].nil? and !h[:geo]["longitude"].nil?
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
csvname = "outputs/csv/#{op[:domain].gsub("/","_").gsub(":","_")}.csv"
kmlname = "outputs/maps/#{op[:domain].gsub("/","_").gsub(":","_")}.kml"

ofc = avoidOverwritingOutput(csvname)
if !ofc.nil?
  saveOutputCSV(ofc,hosts)
  puts "Results were saved in '#{ofc}'."
end
ofk = avoidOverwritingOutput(kmlname)
if !ofk.nil?
  saveOutputKML(ofk,hosts)
  puts "Maps were saved in '#{ofk}'."
end

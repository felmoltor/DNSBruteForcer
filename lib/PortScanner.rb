require 'nmap/xml'
require 'nmap/program'

class PortScanner
  
  attr_accessor :inputlist,:outputname,:scanrange,:scanip
  
  def initialize()
    @inputlist = nil
    @outputname = nil
    @scanrange = nil
    @scanip = nil    
  end
  
  def pingTarget(addr)
    
  end
  
  
  def scanTargetAddress(addr)
    
  end
end
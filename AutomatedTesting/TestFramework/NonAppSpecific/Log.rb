require 'Logger'

class Log
  #wrapup class for logger class to be used in all modules. Constructor should be
  #added for extension of this class
  
  @@log = Logger.new(STDOUT)
  
  def self.debug(msg)
    @@log.debug(msg)
  end
  
  def self.info(msg)
    @@log.info(msg)
  end
  
  def self.warn(msg)
    @@log.warn(msg)
  end
  
  def self.error(msg)
    @@log.error(msg)
  end
  
  def self.fatal(msg)
    @@log.fatal(msg)
  end
end
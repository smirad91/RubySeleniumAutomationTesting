require 'json'

class Config
  
  def initialize(file="")
    #get configuration from json file from Config folder
    #if file name is forwarded, then <file>.json will be used.
    #If nothing is forwarded, then Default.json file will be used.
    #If file name is forwarded through the argument, that <argument>.json will be used as config
    #Argument in this method have advantage over forwarded argument from ruby executing
    if file!=""
      @file_name=file
    elsif file=="" and ARGV[0]==nil
      @file_name="Default"
    elsif file=="" and ARGV[0]!=nil
      @file_name = ARGV[0]
    end
    file = File.read(File.absolute_path("Config/#{@file_name}.json"))
    @configuration = JSON.parse(file)
  end
  
  def get(key)
    #returns value from config file for <key>
    return @configuration["configuration"][key]
  end
  
end
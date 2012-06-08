# encoding: utf-8

require 'spree_core'
require 'spree_import_osc/engine'

require "nokogiri"
require 'open-uri'
require "logger"
require "mail"
require "csv"

#Dir["tasks/*.rake"].each { |ext| load ext } if defined?(Rake)

REQUIRE_PATH = File.dirname(__FILE__)
Dir[File.dirname(__FILE__)+"/import_osc/*.rb"].sort.each {|file| require file }

module ImportOsc

  self.logger_conf ("STDOUT")
  self.init
  #PROXY = "10.44.33.209:842"

  PROXY = ""
  #PORT = ''


  def self.perform
    #begin
       zip_file = self.last_attachment("0")
       xml_file = self.unzip(zip_file)
       xml_data = self.parse_xml(xml_file)
       xml_data = self.parse_images (xml_data)
       file = self.upload_to_csv(xml_data,"ocs.csv")
       return file
       #puts xml_file
     #rescue Exception => e
     #  @log.error "eeeeh some error - this: #{e.message}"
     #end
  end


end


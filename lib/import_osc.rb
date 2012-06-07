# encoding: utf-8
require "nokogiri"
require 'open-uri'
require "logger"
require "mail"
require "csv"

#require 'socksify'

REQUIRE_PATH = File.dirname(__FILE__)

Dir[File.dirname(__FILE__)+"/import_osc/*.rb"].sort.each {|file| require file }

module ImportOsc
  #require "import_osc/version"
  #require "import_osc/conf"
  #require "import_osc/logger_conf"
  #require "import_osc/save_last_attachmet"
  #require "import_osc/unzip"
  #require "import_osc/open_xml_and_parse"
  #require "import_osc/curs_usd"

#
  #tov = {}
=begin
  tov[:name]=
  tov[:sku]=
  tov[:price]=
  tov[:margin]=
  tov[:image]=
  tov[:desk]=
  tov[:category]=
=end
  self.logger_conf ("STDOUT")
  self.init
  PROXY = "10.44.33.209:842"

  #PROXY = ""
  #PORT = ''


  def self.perform
    #begin
       zip_file = self.last_attachment("0")
       xml_file = self.unzip(zip_file)
       xml_data = self.parse_xml(xml_file)
       xml_data = self.parse_images (xml_data)
       self.upload_to_csv(xml_data,"ocs.csv")

       #puts xml_file
     #rescue Exception => e
     #  @log.error "eeeeh some error - this: #{e.message}"
     #end
  end

  #self.perform
  #puts "perfotm ok"
  #puts self.cursusd

end
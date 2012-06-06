# encoding: utf-8
require "nokogiri"
require 'open-uri'
require "logger"
require "mail"
require "csv"
#require 'socksify'

REQUIRE_PATH = File.dirname(__FILE__)

Dir[File.dirname(__FILE__)+"/importer_spr/*.rb"].sort.each {|file| require file }

module ImporterSpr
  #require "importer_spr/version"
  #require "importer_spr/conf"
  #require "importer_spr/logger_conf"
  #require "importer_spr/save_last_attachmet"
  #require "importer_spr/unzip"
  #require "importer_spr/open_xml_and_parse"
  #require "importer_spr/curs_usd"

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
       xml_data_with_images = self.parse_images (xml_data)
       self.upload_to_spree(xml_data)

       #puts xml_file
     #rescue Exception => e
     #  @log.error "eeeeh some error - this: #{e.message}"
     #end
  end

  self.perform
  #puts "perfotm ok"
  #puts self.cursusd

end

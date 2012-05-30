# encoding: utf-8
require "nokogiri"
require "logger"
require "mail"

module ImporterSpr
  require "importer_spr/version"
  require "importer_spr/conf"
  require "importer_spr/logger_conf"
  require "importer_spr/save_last_attachmet"
  require "importer_spr/unzip"
  require "importer_spr/open_xml_and_parse"


   def self.perform
     #begin
       self.logger_conf ("STDOUT")
       self.init
       zip_file = self.last_attachment("0")
       xml_file = self.unzip(zip_file)
       xml_data = self.parse_xml(xml_file)
       xml_data_with_images = self.parse_images (xml_data)
       ImporterSpree.upload_to_spree(xml_data)

       #puts xml_file
     #rescue Exception => e
     #  @log.error "eeeeh some error - this: #{e.message}"
     #end
   end


end

# encoding: utf-8
module ImporterSpr
  require "nokogiri"
  require "logger"
  require "mail"

  require "importer_spr/version"
  require "importer_spr/save_last_attachmet"
  require "importer_spr/open_xml_and_parse"
  require "importer_spr/logger_conf"

   def self.perform
     self.logger_conf ("STDOUT")
     @log.error "yes yes"
     puts "run task"
   end


end

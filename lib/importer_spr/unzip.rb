# encoding: utf-8
module ImporterSpr
  def self.unzip(filename)
    begin
    system "unzip -d #{SAVE_PATH} #{SAVE_PATH + filename}"
    #File.delete(SAVE_PATH + filename) if File.exist?(SAVE_PATH + filename)
    xmlFile =  File.basename(filename, ".xml")
    rescue Exception => e
      @log.error "Unable to unzip data for #{SAVE_PATH + filename} because #{e.message}"
      abort
    end
  end
end
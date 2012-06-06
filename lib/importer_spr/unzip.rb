# encoding: utf-8
module ImporterSpr
  def self.unzip(filename)
    begin
      xmlFile =  File.basename(filename, ".zip")+".xml"
      File.delete(ROOT_PATH + xmlFile) if File.exist?(ROOT_PATH + xmlFile)
      system "unzip -d #{ROOT_PATH} #{ROOT_PATH + filename}"
      xmlFile
      #File.delete(SAVE_PATH + filename) if File.exist?(SAVE_PATH + filename)
    rescue Exception => e
      @log.error "Unable to unzip data for #{ROOT_PATH + filename} because #{e.message}"
      abort
    end
  end
end
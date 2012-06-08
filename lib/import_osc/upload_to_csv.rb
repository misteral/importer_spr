require 'csv'

# encoding: utf-8
module ImportOsc
  def self.upload_to_csv (arr,file)
    begin
      file = ROOT_PATH + file
      #fr = File.new(file, "w+")
      File.delete(file) if File.exist? file
      File.open(file,'w'){ |f| f << arr.map{ |row| row.join("\t") }.join("\n") }
      return file
    rescue Exception => e
      @log.error "Unable to save_csv data to  #{file} because #{e.message}"
    end
  end
end
require 'csv'

# encoding: utf-8
module ImportOsc
  def self.upload_to_csv (arr,file)
    def upload_to_csv (arr,file)
      file = ROOT_PATH + file
      #fr = File.new(file, "w+")
      File.delete(file) if File.exist? file
      File.open(file,'w'){ |f| f << arr.map{ |row| row.join("\t") }.join("\n") }
    end
  end
end
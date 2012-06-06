require 'csv'

# encoding: utf-8
module ImporterSpr
  def self.upload_to_csv (arr,file)
    file = ROOT_PATH + file
    #fr = File.new(file, "w+")
    File.open(file,'w'){ |f| f << arr.map{ |row| row.join("\t") }.join("\n") }
  end
end
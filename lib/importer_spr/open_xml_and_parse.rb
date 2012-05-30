# encoding: utf-8
module ImporterSpr
  def self.parse_xml(filename)
    begin
      xml=Nokogiri::XML File.open (SAVE_PATH + filename)
      xml.xpath('//Товар[@Вид="Принтеры лазерные"]')


    rescue Exception => e
                  @log.error "Unable to parse data for #{SAVE_PATH + filename} because #{e.message}"
                  abort

    end
  end
end
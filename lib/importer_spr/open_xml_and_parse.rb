# encoding: utf-8
module ImporterSpr
  def self.parse_xml(filename)
    begin
      tov = {}
      xml=Nokogiri::XML File.open (SAVE_PATH + filename)
      xml.xpath('//Товар[@Вид="Принтеры лазерные"]').each do |node|
        tov[:name]= node['Название']
        tov[:sku]= node['НН']
        tov[:price]= node['Цена']
        tov[:margin]= 1.2
        tov[:image]= ""
        tov[:desk]= ""
        tov[:category]= "Принтеры>Принтеры лазерыне"

      end

      puts "re"

    rescue Exception => e
                  @log.error "Unable to parse data for #{SAVE_PATH + filename} because #{e.message}"
                  abort

    end
  end
end
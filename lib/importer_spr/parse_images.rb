module ImporterSpr
  def self.parse_images(xml)
    begin
      xml.each do |row|
        pn = row[8]
        url_m = 'http://market.yandex.ru/search.xml?text={'+pn+'}'
        doc = Nokogiri::XML(open(url_m))
        p1 = div[@class='b-offers b-offers_type_guru b-offers_type_guru_mix']
      end

    rescue Exception => e
      @log.error "Unable to parse_images data from xml_data because #{e.message}"
       abort
    end
  end
end
# encoding: utf-8
module ImporterSpr
  def self.cursusd
    begin

      xml_url =  "http://www.cbr.ru/scripts/XML_daily.asp"
      doc = Nokogiri::XML(open(xml_url))
      doc.xpath('//Valute[@ID="R01235"]/Value').text
    rescue Exception => e
      @log.error "Unable to fetch data from #{xml_url} because #{e.message}"
       false
    end
  end
end
# encoding: utf-8
module ImporterSpr
  def self.parse_images(xml)
    begin
      count = 0
      product_name = ""

      xml.each do |row|
        skip = false
        pn = row[7]
        product_name  = row[3]
        url_m = 'http://market.yandex.ru/search.xml?text='+pn+''
        if !PROXY == ""
          html = open(url_m,:proxy=>"http://#{PROXY}:#{PORT}")
        else
          html =  open(url_m)
        end
        doc = Nokogiri::HTML(html)
        p1 = doc.xpath("//div[@class='b-offers b-offers_type_guru b-offers_type_guru_mix']")
        #p1.length
        if p1
        if p1.length == 0
          skip = true
        end

        if p1.length == 1
          tov_cat = doc.xpath("//div[@class='b-offers__pict b-offers__pict_img']/a")[0]['href']
        end

        if p1.length > 1
         # elements =
        end
        else
          skip = true
        end #если p1 т.е. что то парстанулось

        count = count + 1

      end

    rescue Exception => e
      @log.error "Unable to parse_images data #{product_name} from xml_data because #{e.message}"
       abort
    end
  end
end
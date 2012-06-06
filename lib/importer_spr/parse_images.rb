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

        html = open_or_download(url_m,pn+"_search",FILES_PATH,PROXY)
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
          results_mass  = []
          tex_cart = p1.xpath("//div[@class='b-offers__desc']/h3[@class='b-offers__title']/a[@class='b-offers__name']")
          tex_cart.each do |node|
            #puts node
            nash_mass = product_name.downcase.gsub(/_/," ").split(" ")
            yand_mass = node.text.downcase.gsub(/_/," ").split(" ")
            r_mass = nash_mass&yand_mass
            results_mass << [r_mass.length, node['href']]

            #if product_name.length > node.text.length
            #  str_length = node.text.length
            #  nash_mass =
            #else
            #  str_length = product_name.length
            #end
          end
          a_max = 0

          results_mass.each do |e|
            if e[0] > a_max
              a_max = e[0]
              tov_cat = e[1]
            end
          end


          #elements =
        end
        else
          skip = true
        end #если p1 т.е. что то парстанулось
        doc = nil
        tex_cart = nil
        p1 = nil
        html = nil
        if !skip
        url_market = "http://market.yandex.ru" + tov_cat
        url_market_name = pn +"_index"
        html = open_or_download(url_market,url_market_name,FILES_PATH,PROXY)
        doc = Nokogiri::HTML(html)
        img_node = doc.xpath("//span[@class='b-model-pictures__big']/a")
        img_url = img_node.first.values[1] if img_node

        count = count + 1
        end
      end

    rescue Exception => e
      @log.error "Unable to parse_images data #{product_name} from xml_data because #{e.message}"
       abort
    end
  end
end
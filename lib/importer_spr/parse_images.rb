# encoding: utf-8
module ImporterSpr
  def self.parse_images(xml)
    #begin
      count = 0
      product_name = ""

      xml.each do |row|
        skip = false
        pn = row[7].gsub(/\A#/,"").gsub(/(,|#|\s)(.*)/,"").gsub(/\//, "_")
        sku = row[0]
        product_name  = row[3]
        url_m = 'http://market.yandex.ru/search.xml?text='+pn
        html = open_or_download(url_m,pn+"_search",FILES_PATH,PROXY)
        doc = Nokogiri::HTML(html)
        p1 = doc.xpath("//div[@class='b-offers b-offers_type_guru b-offers_type_guru_mix']")
        #p1.length
        if p1
        if p1.length == 0
          skip = true
          @log.debug "не найдено ничего по ссылке #{url_m}, ПН #{row[7]}"
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
          img_node = doc.xpath("//span[@class='b-model-pictures__big']/a/@href")
          if img_node.text.empty?
            img_node=doc.xpath("//span[@class='b-model-pictures__big']/img/@src")
          end
          if !img_node.text.empty?
            img_url = img_node.text
            image = download_image_add_logo(img_url,sku)
            count = count + 1
            xml[xml.index(row)][2] = image
          else
            @log.error "Not found image in yandex card"
          end
        end
      end
      @log.info "Скачано картинок: #{count}, всего товаров: #{xml.length}"
    #rescue Exception => e
    #  @log.error "Unable to parse_images data #{product_name} from xml_data because #{e.message}"
    #  @log.error "Market url is #{url_market}"
    #end
      #puts "нормальный выход из парсера"
      return xml
  end
end
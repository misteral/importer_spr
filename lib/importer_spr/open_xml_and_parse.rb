# encoding: utf-8
module ImporterSpr
  def self.parse_xml(filename)
    #begin
      #rows = CSV.read('/tmp/spree_export.csv', {:col_sep=>"\t",:quote_char=>"\t"})
      pn = ""
      nn = ""
      kurs_usd = self.cursusd
      if kurs_usd == "" or !kurs_usd or kurs_usd == 0
      kurs_usd = 33
      end
      #puts "kurs -" + kurs_usd.to_s
      vid_arr = ["Принтеры лазерные",
                "Принтеры струйные",
                "Многофункциональные устройства лазерные",
                "Широкоформатные плоттеры струйные",
                "Широкоформатные сканеры",
                "Ноутбуки эконом класса",
                "Ноутбуки мультимедиа класса"
      ]

      arr_tov=[]
      xml=Nokogiri::XML File.open (SAVE_PATH + filename)
      vid_arr.each do |vid|

      my_xpath = '//Товар[@Вид="'+vid+'"]'
      xml.xpath(my_xpath).each do |node|
        tov = []
        tov << node['НН']            # артикул [0]
        nn =  node['НН']
        tov << node['НазваниеРус']   # deskcription [1]
        tov << ""                     # image[2]
        tov << node['Название'] # название [3]
        if node['Валюта'] = "USD"        # цена [4]
          #puts node['Цена']
          tov << node['Цена'].to_f*kurs_usd.to_f
        else
          #puts node['Цена']
          tov << node['Цена'].to_f
        end
        tov <<  1.2             # margin [5]
        tov << "Принтеры > Принтеры лазерыне" #категория [6]
        #-- доп параметры всякие
        tov << node['Партномер'] #[7]
        pn = node['Партномер']
        tov << node['Валюта']    #[8]
        tov << node['Цена']      #[9]

        arr_tov << tov
        end
      end
      xml = nil
      #puts arr_tov.size
      arr_tov
    #rescue Exception => e
     #             @log.error "Unable to parse data from xml sku num tov=#{nn} for #{SAVE_PATH + filename} because #{e.message}"
     #             abort

    #end
  end
end
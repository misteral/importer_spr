# encoding: utf-8
module ImporterSpr
  def self.parse_xml(filename)
    begin
      #rows = CSV.read('/tmp/spree_export.csv', {:col_sep=>"\t",:quote_char=>"\t"})
      kurs_usd = self.cursusd
      kurs_usd ||= 32
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
        tov << node['НН']            # артикул [1]
        tov << node['НазваниеРус']   # deskcription [2]
        tov << ""                     # image[3]
        tov << node['Название'] # название [4]
        if node['Валюта'] = "USD"        # цена [5]
          tov << node['Цена'].to_f*kurs_usd
        else
          tov << node['Цена'].to_f
        end
        tov <<  1.2             # margin [6]
        tov << "Принтеры > Принтеры лазерыне" #категория [7]
        #-- доп параметры всякие
        tov << node['Партномер'] #[8]
        #tov << node['Валюта']    #[9]
        #tov << node['Цена']      #[10]

        arr_tov << tov
        end
      end
      xml = nil
      #puts arr_tov.size
      arr_tov
    rescue Exception => e
                  @log.error "Unable to parse data from xml for #{SAVE_PATH + filename} because #{e.message}"
                  abort

    end
  end
end
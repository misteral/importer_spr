module ImporterSpr
  def self.parse_images(xml)
    begin
      xml.each do |row|
        pn = row[]
      end

    rescue Exception => e
      @log.error "Unable to parse_images data from xml_data because #{e.message}"
       abort
    end
  end
end
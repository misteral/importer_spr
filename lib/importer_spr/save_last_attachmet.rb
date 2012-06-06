# encoding: utf-8
module ImporterSpr

  def self.last_attachment (dw = "1")
    begin
      if dw == "1"
        email = Mail.find(:what => :first, :count => 1, :order => :asc)
        #puts email.
        email.attachments.each do | attachment |
          # Attachments is an AttachmentsList object containing a
          # number of Part objects
          if (attachment.content_type.include? ('zip'))
            # extracting images for example...
            filename = attachment.filename
            begin
              File.delete(ROOT_PATH + filename) if File.exist?(ROOT_PATH + filename)
              File.open(ROOT_PATH + filename, "w+b", 0644) {|f| f.write attachment.body.decoded}
              return filename
            rescue Exception => e
              @log.error "Unable to save data for #{ROOT_PATH + filename} because #{e.message}"
              abort
            end
          else
            @log.error "Attachment extension not zip"
            abort
          end

        end
      else
        "StockAndPrice.zip"
      end
    rescue Exception => e
      @log.error "Unable to get mail for conf addres because #{e.message}"
      abort

    end

  end
end
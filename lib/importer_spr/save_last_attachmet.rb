module ImporterSpr
  def self.last_attachment
    email = Mail.find(:what => :first, :count => 1, :order => :asc)
    puts email.length.to_s
    mail.attachments.each do | attachment |
      # Attachments is an AttachmentsList object containing a
      # number of Part objects
      if (attachment.content_type.start_with?('zip/'))
        # extracting images for example...
        filename = attachment.filename
        begin
          File.delete(save_path + filename) if File.exist?(save_path + filename)
          File.open(save_path + filename, "w+b", 0644) {|f| f.write attachment.body.decoded}
        rescue Exception => e
          puts "Unable to save data for #{save_path + filename} because #{e.message}"
        end
      end
    end
  end
end
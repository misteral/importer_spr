# encoding: utf-8

require "RMagick"

module ImportOsc
  #url - хеш значений :name - имя :url - откуда качать
  # proxy - прокси
  # path - добавочный path/для уровней
  def self.open_or_download(url,url_name,path="",proxy="")
    path_for = path
    Dir.mkdir(path_for) unless File.exists?(path_for)
    #url_name = url.gsub("/(?<=http:\/\/www.sima-land.ru\/)(.+)/").gsub(/\//, "_").gsub(/\.html/,"")
    file_name = path_for+url_name+".html"
    if File.exists?(file_name) and !File.zero?(file_name)
      text = open(file_name) { |f| f.read }
    else
      fr = File.new(file_name, "w+")
      begin
      if proxy.empty?
        content = open(url)
        else
        content = open(url, :proxy=>"http://#{PROXY}")
      end
      #the_status = content.status[0]
      rescue Exception => the_error
      # some clean up work goes here and then..
      #the_status = the_error.io.status[0] # => 3xx, 4xx, or 5xx
      # the_error.message is the numeric code and text in a string
      @log.error "Whoops got a bad status code #{the_error.message} file download fail"
      #@log.error ("File #{url} download fail")
      return "none"
      end
      #do_something_with_status(the_status)

      text = content.read
      File.open(file_name, 'w') {|f| f.write(text) }
    end

    text
  end


  def self.multy_get_from_hash(urls,path = "",proxy="")
    path_for = ROOT_PATH+"/dw-sima/"+path
    Dir.mkdir(path_for) unless File.exists?(path_for) #создание директории когда ее нет

    urls.each do |key, value|
      #puts "ds"
      url_name = value[/(?<=http:\/\/www.sima-land.ru\/)(.+)/].gsub(/\//, "_").gsub(/\.html/,"")
      file_name = path_for+url_name+".html"
      #file_name = path_for+key+".html"
      if File.exists?(file_name) and !File.zero?(file_name)
        urls.delete(key)
      end
    end
    all_useragents = [
   	"Opera/9.23 (Windows NT 5.1; U; ru)",
   	"Mozilla/5.0 (Windows; U; Windows NT 5.1; ru; rv:1.8.1.8) Gecko/20071008 Firefox/2.0.0.4;MEGAUPLOAD 1.0",
   	"Mozilla/5.0 (Windows; U; Windows NT 5.1; Alexa Toolbar; MEGAUPLOAD 2.0; rv:1.8.1.7) Gecko/20070914 Firefox/2.0.0.7;MEGAUPLOAD 1.0",
   	"Mozilla/4.0 (compatible; MSIE 6.0; Windows NT 5.0; MyIE2; Maxthon)",
   	"Mozilla/4.0 (compatible; MSIE 6.0; Windows NT 5.0; MyIE2; Maxthon)",
   	"Mozilla/4.0 (compatible; MSIE 6.0; Windows NT 5.0; MyIE2; Maxthon)",
   	"Mozilla/4.0 (compatible; MSIE 7.0; Windows NT 6.0; WOW64; Maxthon; SLCC1; .NET CLR 2.0.50727; .NET CLR 3.0.04506; Media Center PC 5.0; InfoPath.1)",
   	"Mozilla/4.0 (compatible; MSIE 6.0; Windows NT 5.0; MyIE2; Maxthon)",
   	"Opera/9.10 (Windows NT 5.1; U; ru)",
   	"Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1; aggregator:Tailrank; http://tailrank.com/robot) Gecko/20021130",
   	"Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.1.8) Gecko/20071008 Firefox/2.0.0.8",
   	"Mozilla/4.0 (compatible; MSIE 6.0; Windows NT 5.0; MyIE2; Maxthon)",
   	"Mozilla/5.0 (Windows; U; Windows NT 5.1; ru; rv:1.8.1.8) Gecko/20071008 Firefox/2.0.0.8",
   	"Opera/9.22 (Windows NT 6.0; U; ru)",
   	"Opera/9.22 (Windows NT 6.0; U; ru)",
   	"Mozilla/5.0 (Windows; U; Windows NT 5.1; ru; rv:1.8.1.8) Gecko/20071008 Firefox/2.0.0.8",
   	"Mozilla/4.0 (compatible; MSIE 7.0; Windows NT 5.1; .NET CLR 1.1.4322; .NET CLR 2.0.50727; .NET CLR 3.0.04506.30)",
   	"Mozilla/4.0 (compatible; MSIE 6.0; Windows NT 5.1; SV1; MRSPUTNIK 1, 8, 0, 17 HW; MRA 4.10 (build 01952); .NET CLR 1.1.4322; .NET CLR 2.0.50727)",
   	"Mozilla/4.0 (compatible; MSIE 6.0; Windows NT 5.1; SV1)",
   	"Mozilla/5.0 (Windows; U; Windows NT 5.1; ru; rv:1.8.1.9) Gecko/20071025 Firefox/2.0.0.9"
   	];
    if !urls.empty?
    m = Curl::Multi.new
    m.pipeline = true
    #pbar = ProgressBar.new("Download urls", urls.size)

    m.max_connects = 100
    #responses = {}
    urls.each_pair do |key, value|
#      responses[value] = ""
      c = Curl::Easy.new(value) do|curl|
        curl.follow_location = true
        curl.proxy_url = proxy if !proxy.empty?
        curl.connect_timeout = 100
        curl.headers["Referer"]= "http://www.yandex.ru"
        curl.useragent = all_useragents.sample
        curl.on_body {|d| File.open(path_for+value[/(?<=http:\/\/www.sima-land.ru\/)(.+)/].gsub(/\//, "_").gsub(/\.html/,"")+'.html', 'a') {|f| f.write d} }
        curl.on_failure {|response, err| $log.error "Erroor download #{key}. We have failure.  The response code is #{response.response_code}. Error is: #{err.inspect}"}
        #curl.on_progress {|dl_total, dl_now, ul_total, ul_now| puts "dl_total-#{dl_total} --- dl_now-#{dl_now}";sleep 3; puts}
      end
      m.add(c)
    end
    m.perform

    #urls.each do|url|
    #   puts responses[url]
    # end

    true
    else
      false #файлы все существуют ничего качать не нужно
    end
  end

  def self.swap_sku(sku)
      sku = "1"+sku.to_s.reverse
  end

  def self.re_swap_sku(sku)
    sku = sku[1..sku.size-1].reverse
  end

  def self.create_folder(provider,path)
    if provider == "file"
      Dir.mkdir(path) unless File.exists?(path)
    end
  end

  def self.download_image_add_logo(url,sku)
    #url = sima_image_url + sku +".jpg"
    file_name = IMAGE_PATH_ORIGINAL + sku +".jpg"
    if !File.exists?(file_name) or File.zero?(file_name)
      begin
        open(file_name, 'wb') do |file|
          if PROXY.empty?
            file << open(url).read
            else
            file << open(url, :proxy=>"http://#{PROXY}").read
          end
        end
      rescue Exception => e

        #the_status = the_error.io.status[0] # => 3xx, 4xx, or 5xx
        # the_error.message is the numeric code and text in a string
        @log.error "Whoops got #{url} ,a bad status code #{e.message} image file download fail"
        #abort("image #{url} download fail")
      end
    end
    add_logo_and_copy_to_with_logo_folder(sku)
  end

  def self.add_logo_and_copy_to_with_logo_folder(sku)
    begin
      original_file = IMAGE_PATH_ORIGINAL + sku +".jpg"
      save_filename = IMAGE_PATH_WITH_LOGO + sku +".jpg"
      if !File.exists?(save_filename) or File.zero?(save_filename)
        white_bg = Magick::Image.new(600, 600)
        clown = Magick::Image.read(original_file).first
        logo = Magick::Image.read(LOGO_IMAGE).first
        clown = clown.composite(logo, 0, 0, Magick::OverCompositeOp)
        #clown.resize(600,600)
        clown.change_geometry!('600x600') { |cols, rows, img|
        img.resize!(cols, rows)
        }
        clown = white_bg.composite(clown, Magick::CenterGravity, Magick::OverCompositeOp)
        clown.write(save_filename)
        #system("convert #{save_filename} -resize 600x600 -size 600x600 xc:#fff +swap -gravity center -composite #{save_filename}")
      end
      return save_filename
    rescue Exception => e
      @log.error "Unable to save_images data #{save_filename} because #{e.message}"
    end
  end
end


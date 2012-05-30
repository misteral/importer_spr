# encoding: utf-8
module ImporterSpr
  SAVE_PATH = ENV['HOME']+"/import_spree/"

  def self.init
  Mail.defaults do
    retriever_method :pop3, :address    => "pop.yandex.com",
                            :port       => 995,
                            :user_name  => 'mister-al@ya.ru',
                            :password   => 'nhfnhfd',
                            :enable_ssl => true


  end

  Dir.mkdir(SAVE_PATH) unless File.exists?(SAVE_PATH)

  end

end
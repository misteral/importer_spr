# encoding: utf-8

module ImportOsc
  ROOT_PATH = ENV['HOME']+"/import_spree/"
  FILES_PATH = ROOT_PATH+"files_ocs/"
  IMAGE_PATH = ROOT_PATH+"images_ocs/"
  IMAGE_PATH_ORIGINAL = IMAGE_PATH+'original/'
  IMAGE_PATH_WITH_LOGO = IMAGE_PATH+'with_logo/'
  LOGO_IMAGE = ROOT_PATH+"/logo/chaiknet_logo.psd"

  require REQUIRE_PATH + "/a_common_functions.rb"

  def self.init
  Mail.defaults do
    retriever_method :pop3, :address    => "pop.yandex.com",
                            :port       => 995,
                            :user_name  => 'mister-al@ya.ru',
                            :password   => 'vxcvzv',
                            :enable_ssl => true


  end

  provider = 'file' #file or S3

  create_folder(provider,ROOT_PATH)
  create_folder(provider,FILES_PATH)
  create_folder(provider,IMAGE_PATH)
  create_folder(provider,IMAGE_PATH_ORIGINAL)
  create_folder(provider,IMAGE_PATH_WITH_LOGO)
  end

end


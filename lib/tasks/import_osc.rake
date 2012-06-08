namespace :spree do
  desc "Load a xml and parse yandex for our electronics."
  task :import_osc  => :environment do
    #require 'my_import_products'
    ImportOsc.perform
  end
end
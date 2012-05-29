# encoding: utf-8
module ImporterSpr
  def logger_conf(type = "STDOUT", file = "importer_spr.log")
    if type =="STDOUT"
      @log = Logger.new(STDOUT)
    else
      @log = Logger.new(file)
    end
  end
end

# encoding: utf-8
module ImportOsc
  def self.logger_conf(type = "STDOUT", file = "import_osc.log")
    if type =="STDOUT"
      @log = Logger.new(STDOUT)
    else
      @log = Logger.new(ROOT_PATH+file)
    end
  end
end

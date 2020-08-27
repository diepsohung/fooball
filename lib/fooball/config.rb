module Fooball
  class Config
    def initialize
      config_path = File.expand_path(DEFAULT_CONFIG_FILE_PATH)
      @config = JSON.load(File.read(config_path))
      raise MissingTimeZoneError if @config["timezone"].nil?
      raise MissingTokenError if @config["token"].nil?
    end

    def self.fetch(key)
      self.new.config[key.to_s]
    end

    attr_reader :config
  end
end

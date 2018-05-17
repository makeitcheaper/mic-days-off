require 'open-uri'
require 'yaml'

module Mic
  module Daysoff
    @arr_days_off = []
    @file_url = ENV['MIC_DAYS_OFF_YML_URL_FILE'].freeze

    # call th on app startup
    def self.initialize_dates_on_boot
      @arr_days_off = get_dates
    end

    #TODO code + tests
    def self.is_today_day_off?
      false
    end


    #TODO next gem version
    #TODO code + Test
    # def self.reload_static_days_off
    #   @arr_days_off = get_dates
    # end

    def self.get_array_dates_debugg
      @arr_days_off
    end

    def self.get_dates
      dates = get_dates_from_web

      (dates != []) ? dates : get_dates_from_config
    end

    def self.get_dates_from_web
      file = YAML.load(open(@file_url))
      array = []
      file['day-off'].each do |line|
        array << line.to_s
      end

      array

    rescue
      []
    end

    def self.get_dates_from_config
      root_dir = File.dirname(__FILE__).gsub('lib/mic/daysoff', '')
      file_location = root_dir + 'config/days-off.yml'
      file = YAML.load_file(file_location)

      array_backup = []
      file['day-off'].each do |line|
        array_backup << line.to_s
      end

      array_backup

    rescue
      []
    end

  end
end

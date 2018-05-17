require 'open-uri'
require 'yaml'
# require 'awesome_print' #TODO remove before build gem

module Mic
  module Daysoff
    @arr_days_off = []

    def initialize
      @arr_days_off = get_dates
    end

    def self.is_today_day_off?
      @arr_days_off.include?(Date.today.strftime("%Y-%m-%d"))
    end

    #TODO Test
    def self.reload_static_days_off
      @arr_days_off = get_dates
    end

    def self.get_array_dates_debugg
      @arr_days_off
    end

    #TODO Test
    def self.get_dates
      dates = get_dates_from_web

      (dates != []) ? dates : get_dates_from_config
    end

    #TODO Fix one test (code work, test no)
    def self.get_dates_from_web
      file = YAML.load(open(ENV['MIC_DAYS_OFF_YML_URL_FILE']))
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

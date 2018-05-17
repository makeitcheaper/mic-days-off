module Mic
  class Daysoff
    @arr_days_off = []

    class << self
      #TODO code + tests
      def is_today_day_off?
        false
      end

      #TODO Test
      def reload_static_days_off
        @arr_days_off = get_dates
      end

      def get_array_dates_debugg
        @arr_days_off
      end

      private

      #TODO code + tests
      def get_dates
        dates = get_dates_from_web
        return dates unless []
        dates = get_dates_from_config
        return dates unless []

        []
      end

      #TODO code + tests
      def get_dates_from_web
        #TODO
      end

      #TODO code + tests
      def get_dates_from_config
        #TODO
      end
    end
  end
end

# mic-days-off

## Online yml file
to run you must setup env variable
`MIC_DAYS_OFF_YML_URL_FILE`


## Install
Gemfile add 'mic-daysoff'
    gem 'mic-daysoff', git: 'https://github.com/makeitcheaper/mic-days-off'

Setup ENV variable `MIC_DAYS_OFF_YML_URL_FILE` with to your yml file url

Rails: `/config/application.rb` add `require 'daysoff'` then call `Mic::Daysoff.reload_static_days_off` on the same file

    module AppTest
      class Application < Rails::Application
        config.load_defaults = 42.3
        config.zyx = zzzz

        Mic::Daysoff.reload_static_days_off
      end
    end


## Usage
`Mic::Daysoff.is_today_day_off?` return `true` or `false`

`Mic::Daysoff.get_array_dates_debugg` dubugg usage only to check the statis array of date

Beta: `Mic::Daysoff.reload_static_days_off` reload static array be carefull

## TODO
- make more method in private
- fix on existing test
- Write more test
- refactor
- Audit if we need timeout to open online file
- make controller, route to refresh static array from url GET


run tests

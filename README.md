# mic-days-off

## Online yml file
to run you must setup env variable
`MIC_DAYS_OFF_YML_URL_FILE`


## Install
Gemfile add 'mic-daysoff'
    gem 'mic-daysoff', git: 'https://github.com/makeitcheaper/mic-days-off'

- Setup ENV variable `MIC_DAYS_OFF_YML_URL_FILE` with to your yml file url
- Rails: `./config/application.rb` add `require 'daysoff'`
- To load yml on startup, create for example './config/initializers/mic-daysoff.rb' and put followwing inside`Mic::Daysoff.reload_static_days_off`



## Usage
`Mic::Daysoff.is_today_day_off?` return `true` or `false`

`Mic::Daysoff.get_array_dates_debugg` dubugg usage only to check the statis array of date

Beta: `Mic::Daysoff.reload_static_days_off` reload static array be carefull

## TODO
- Fix load local ./config/days-off.yml from Rails point of vue (work for local code on gem, not on rails app. see: ROOT_PATH on Rails)
- make more method in private
- fix on existing test
- Write more test
- refactor
- Audit if we need timeout to open online file
- make controller, route to refresh static array from url GET


run tests

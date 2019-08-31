# BrilliantWebScraper [![Build Status](https://api.travis-ci.com/bkotu6717/brilliant_web_scraper.svg)](https://travis-ci.com/bkotu6717/brilliant_web_scraper)[![Maintainability](https://api.codeclimate.com/v1/badges/15a8a6e117f11bd94376/maintainability)](https://codeclimate.com/github/bkotu6717/brilliant_web_scraper/maintainability)

A decent web scraping gem. Scrapes website title, description, social profiles such as linkedin, facebook, twitter, instgram, vimeo, pinterest, youtube channel and contact details such as emails, phone numbers.


## See it in action!

You can try BrillaintWebScraper live at this little demo: [https://brilliant-web-scraper-demo.herokuapp.com](https://brilliant-web-scraper-demo.herokuapp.com)

## Installation


If you're using it on a Rails application, just add it to your Gemfile and run `bundle install`

```ruby
gem 'brilliant_web_scraper'
```

## Usage

Initialize a BrilliantWebScraper instance for an URL, like this with optional timeouts, default connection_timeout and read_timeouts are 10s, 10s respectively:

```ruby
require 'brilliant_web_scraper'
results = BrilliantWebScraper.new('http://pwc.com', 5, 5)

results = BrilliantWebScraper.new('http://pwc.com')
```

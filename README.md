# WebScraper [![Build Status](https://api.travis-ci.com/bkotu6717/brilliant_web_scraper.svg)](https://travis-ci.com/bkotu6717/brilliant_web_scraper)

A decent web scraping gem. Scrapes website description, social profiles, contact details, youtube channels.


It accepts a URL or Domain as input and gets it's title, descrptios, social profiles, YouTube channels and it's current URL if got redirected.


## See it in action!

You can try WebScraper live at this little demo: [https://brilliantweb-scraper-demo.herokuapp.com](https://brilliant-web-scraper-demo.herokuapp.com)

## Installation


If you're using it on a Rails application, just add it to your Gemfile and run `bundle install`

```ruby
gem 'brilliant_web_scraper'
```

## Usage

Initialize a BrilliantWebScraper instance for an URL, like this:

```ruby
require 'brilliant_web_scraper'
results = BrilliantWebScraper.new('http://pwc.com')
```

If you don't include the scheme on the URL, it is fine:

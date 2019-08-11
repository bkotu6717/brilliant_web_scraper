# WebScraper [![Build Status](https://api.travis-ci.com/bkotu6717/web_scraper.svg)](https://travis-ci.com/bkotu6717/web_scraper)

A decent web scraping gem. Scrapes website description, social profiles, contact details, youtube channels.


It accepts a URL or Domain as input and gets it's title, descrptios, social profiles, YouTube channels and it's current URL if got redirected.


## See it in action!

You can try WebScraper live at this little demo: [https://web-scraper-demo.herokuapp.com](https://web-scraper-demo.herokuapp.com)

## Installation


If you're using it on a Rails application, just add it to your Gemfile and run `bundle install`

```ruby
gem 'web_scraper', git: 'https://github.com/bkotu6717/web_scraper.git'
```

## Usage

Initialize a WebScrape instance for an URL, like this:

```ruby
results = WebScrape.new('http://pwc.com')
```

If you don't include the scheme on the URL, it is fine:

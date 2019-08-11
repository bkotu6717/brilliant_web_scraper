# frozen_string_literal: true

require File.expand_path('./lib/version')

Gem::Specification.new do |s|
  s.name =  'web_scraper'
  s.version = WebScraper::VERSION
  s.licenses = ['Nonstandard']
  s.summary = 'A decent web scraping ruby library!'
  s.description = 'Scrapes data such as description, social profiles, contact details'
  s.authors = ['Kotu Bhaskara Rao']
  s.email = 'bkotu6717@gmail.com'
  s.require_paths = ['lib']
  s.homepage = 'https://github.com/bkotu6717/web_scraper'
  s.files = Dir['**/*'].keep_if { |file|
    file != "web_scraper-#{WebScraper::VERSION}.gem" && File.file?(file)
  }
  s.add_dependency 'nesty', '~> 1.0', '>= 1.0.1'
  s.add_dependency 'rest-client', '~> 2.0', '>= 2.0.2'

  s.add_development_dependency 'nesty', '~> 1.0', '>= 1.0.1'
  s.add_development_dependency 'pry', '~> 0.12.2'
  s.add_development_dependency 'rest-client', '~> 2.0', '>= 2.0.2'
  s.add_development_dependency 'rspec', '~> 3.5'
  s.add_development_dependency 'rubocop', '~> 0.73.0'
  s.add_development_dependency 'vcr', '~> 3.0', '>= 3.0.1'
  s.add_development_dependency 'webmock', '~> 2.1'
end

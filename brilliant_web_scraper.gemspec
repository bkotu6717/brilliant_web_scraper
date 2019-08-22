# frozen_string_literal: true

require File.expand_path('./lib/version')

Gem::Specification.new do |s|
  s.name =  'brilliant_web_scraper'
  s.version = WebScraper::VERSION
  s.licenses = ['Nonstandard']
  s.summary = 'A decent web scraping ruby gem!'
  s.description = 'A decent web scraping gem.'\
                  'Scrapes website\'s title, description,'\
                  'social profiles such as linkedin, '\
                  'facebook, twitter, instgram, vimeo,'\
                  'pinterest, youtube channel and'\
                  ' contact details such as emails, phone numbers.'
  s.authors = ['Kotu Bhaskara Rao']
  s.email = 'bkotu6717@gmail.com'
  s.require_paths = ['lib']
  s.homepage = 'https://github.com/bkotu6717/brilliant_web_scraper'
  s.files = Dir['**/*'].keep_if { |file|
    file != "brilliant_web_scraper-#{WebScraper::VERSION}.gem" && 
    File.file?(file)
  }
  s.required_ruby_version = '>= 2.3.0'

  s.add_dependency 'charlock_holmes', '~> 0.7.6'
  s.add_dependency 'nesty', '~> 1.0', '>= 1.0.1'
  s.add_dependency 'rest-client', '~> 2.0', '>= 2.0.2'

  s.add_development_dependency 'pry', '~> 0.12.2'
  s.add_development_dependency 'rspec', '~> 3.5'
  s.add_development_dependency 'rubocop', '~> 0.73.0'
  s.add_development_dependency 'vcr', '~> 3.0', '>= 3.0.1'
  s.add_development_dependency 'webmock', '~> 2.1'
end

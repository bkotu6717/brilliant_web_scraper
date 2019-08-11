# frozen_string_literal: true

require 'rest-client'
require 'cgi'
require 'benchmark'

current_directory = File.dirname(__FILE__) + '/scraper'
require File.expand_path(File.join(current_directory, 'errors'))
require File.expand_path(File.join(current_directory, 'scrape_exceptions'))
require File.expand_path(File.join(current_directory, 'scrape_helper'))
require File.expand_path(File.join(current_directory, 'scrape_request'))

current_directory = File.dirname(__FILE__) + '/parsers'
require File.expand_path(File.join(current_directory, 'unescape_html_helper'))
require File.expand_path(File.join(current_directory, 'description_helper'))
require File.expand_path(File.join(current_directory, 'title'))
require File.expand_path(File.join(current_directory, 'meta_description'))
require File.expand_path(File.join(current_directory, 'org_description'))
require File.expand_path(File.join(current_directory, 'twitter_description'))
require File.expand_path(File.join(current_directory, 'twitter_profile'))
require File.expand_path(File.join(current_directory, 'linkedin_profile'))
require File.expand_path(File.join(current_directory, 'facebook_profile'))
require File.expand_path(File.join(current_directory, 'youtube_channel'))
require File.expand_path(File.join(current_directory, 'instagram_profile'))
require File.expand_path(File.join(current_directory, 'vimeo_profile'))
require File.expand_path(File.join(current_directory, 'pinterest_profile'))
require File.expand_path(File.join(current_directory, 'emails'))
require File.expand_path(File.join(current_directory, 'phone_numbers'))
require File.expand_path(File.join(current_directory, 'redirected_to'))

# Main scraping class
class BrilliantWebScraper
  extend ScrapeHelper
  extend ScrapeRequest
  extend Title
  extend MetaDescription
  extend OrgDescription
  extend TwitterDescription
  extend TwitterProfile
  extend LinkedinProfile
  extend FacebookProfile
  extend YoutubeChannel
  extend InstagramProfile
  extend VimeoProfile
  extend PinterestProfile
  extend Emails
  extend PhoneNumbers
  extend RedirectedTo

  class << self
    def new(url, connection_timeout = 10, read_timeout = 10)
      perform_scrape(url, connection_timeout, read_timeout)
    end
  end
end

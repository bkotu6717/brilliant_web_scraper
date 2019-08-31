# frozen_string_literal: true

# Scrapes below data
# @Title
# @Descriptions
# @Social Profiles
# @Contact Details
module ScrapeHelper
  def perform_scrape(url, read_timeout, open_timeout)
    timeout_in_sec = scraper_timeout(read_timeout, open_timeout)
    Timeout::timeout(timeout_in_sec) do
      response = ScrapeRequest.new(url, read_timeout, open_timeout)
      retry_count = 0
      body = response.body
      begin
        body = body.tr("\000", '')
        encoding = body.detect_encoding[:encoding]
        body = body.encode('UTF-8', encoding)
        grep_data(body)
      rescue Encoding::UndefinedConversionError, ArgumentError => e
        retry_count += 1
        raise WebScraper::ParserError, e.message if retry_count > 1
        body = body.encode('UTF-8', invalid: :replace, undef: :replace, replace: '?')
        retry
      rescue Encoding::CompatibilityError => e
        raise WebScraper::ParserError, e.message
      rescue StandardError => e
        raise WebScraper::RequestError, e.message
      end
    end
  rescue Timeout::Error => e
    raise WebScraper::TimeoutError, e.message
  end

  private

  def scraper_timeout(read_timeout, open_timeout)
    ( read_timeout + open_timeout + 1 )
  end

  def grep_data(response)
    {
      title: grep_title(response),
      meta_description: grep_meta_description(response),
      org_description: grep_org_description(response),
      twitter_description: grep_twitter_description(response),
      twitter_profile: grep_twitter_profile(response),
      linkedin_profile: grep_linkedin_profile(response),
      facebook_profile: grep_facebook_profile(response),
      instagram_profile: grep_instagram_profile(response),
      vimeo_profile: grep_vimeo_profile(response),
      pinterest_profile: grep_pinterest_profile(response),
      youtube_channel: grep_youtube_channel(response),
      emails: grep_emails(response),
      phone_numbers: grep_phone_numbers(response),
      redirected_to: grep_redirected_to_url(response)
    }
  end
end

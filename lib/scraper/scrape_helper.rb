# frozen_string_literal: true

# Scrapes below data
# @Title
# @Descriptions
# @Social Profiles
# @Contact Details
module ScrapeHelper
  def perform_scrape(url, read_timeout, connection_timeout)
    response = nil
    request_duration = Benchmark.measure do
      response = ScrapeRequest.new(url, read_timeout, connection_timeout)
    end.real
    retry_count = 0
    begin
      scrape_data = nil
      scrape_duration = Benchmark.measure do
        scrape_data = grep_data(response.body)
      end.real

      data_hash = {
        web_request_duration: request_duration,
        response_scrape_duraton: scrape_duration,
        scrape_data: scrape_data
      }
    rescue ArgumentError => e
      retry_count += 1
      raise WebScraper::ParserError, e.message if retry_count > 1

      response = response.encode('UTF-16be', invalid: :replace, replace: '?')
      response = response.encode('UTF-8')
      retry
    rescue Encoding::CompatibilityError => e
      raise WebScraper::ParserError, e.message
    end
    data_hash
  end

  private

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

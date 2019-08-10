# frozen_string_literal: true

# @Makes actual scrape request, either raises exception or response
module ScrapeRequest
  extend ScrapeExceptions
  class << self
    def new(url, read_timeout, connection_timeout)
      begin
        params_hash = {
          method: :get,
          url: url,
          read_timeout: read_timeout,
          connection_timeout: connection_timeout,
          headers: { 'accept-encoding': 'identity' }
        }
        response = RestClient::Request.execute(params_hash)
        content_type = response.headers[:content_type]
        return response if content_type =~ %r{(?i)text\s*\/\s*html}

        exception_message = "Invalid response format received: #{content_type}"
        raise WebScraper::NonHtmlError, exception_message
      rescue *TIMEOUT_EXCEPTIONS => e
        raise WebScraper::TimeoutError, e.message
      rescue *GENERAL_EXCEPTIONS => e
        raise WebScraper::RequestError, e.message
      end
    end
  end
end

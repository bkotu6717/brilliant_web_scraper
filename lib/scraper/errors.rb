# frozen_string_literal: true

require 'nesty'

# Raise error as WebScraper Error
module WebScraper
  # Inclide nesty to have actual stacktrace of bug
  class Error < StandardError
    include Nesty::NestedError
  end

  class TimeoutError < Error; end

  class RequestError < Error; end

  class ParserError < Error; end

  class NonHtmlError < ParserError; end
end

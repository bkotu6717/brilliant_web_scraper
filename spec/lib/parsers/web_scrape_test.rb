require 'spec_helper'

describe 'WebScrape' do

  it 'should scrape given url' do
    VCR.use_cassette("valid_scrape_response") do
      parsed_data = WebScrape.perform('unisourceworldwide.com', 10, 10)
      puts parsed_data
    end
  end

  it 'should retry one more time incase of ArgumentError exception' do
  end

  it 'should raise WebScraper::ParserError' do
  end
end
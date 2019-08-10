require 'spec_helper'

describe 'ScrapeRequest' do
  it 'should get valid response' do
    VCR.use_cassette("valid_scrape_response") do
      response = ScrapeRequest.new('unisourceworldwide.com', 10, 10)
      expect(response.code).to eq(200)
    end
  end

  describe 'exceptions' do
    it 'should raise WebScraper::NonHtmlError' do
      VCR.use_cassette("non_html_scrape") do
        expect { 
          ScrapeRequest.new('https://www.lexisnexis.ca/images/common/logo-lexisnexis.png', 10, 10) 
        }.to raise_error(WebScraper::NonHtmlError)
      end
    end

    it 'should raise TIMEOUT_EXCEPTION' do
      stub_request(:any, 'constellationrg.com').to_timeout
      expect { 
        ScrapeRequest.new('constellationrg.com', 10, 10) 
      }.to raise_error(WebScraper::TimeoutError)
    end
    
    it 'should raise GENERAL_EXCEPTION' do
      stub_request(:any, 'canadiansprings.com').to_raise(WebScraper::RequestError)
      expect { 
        ScrapeRequest.new('canadiansprings.com', 10, 10) 
      }.to raise_error(WebScraper::RequestError)
    end
  end
end
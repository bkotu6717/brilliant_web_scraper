require 'spec_helper'

describe 'BrilliantWebScraper' do
  it 'should get valid scraped data' do
    VCR.use_cassette('valid_scrape_response') do
      data = BrilliantWebScraper.new('unisourceworldwide.com')
      expect(data[:scrape_data]).to eq(
        { :title=>'Leading North American Distributor | Veritiv Corporation', 
          :meta_description=>'Full-service distribution services including warehousing, paper and packaging distribution, publishing, facility solutions and logistics.', 
          :org_description=>'packaging design wide format commercial cleaning solutions careers logistics paper samples news about Veritiv investor relations', 
          :twitter_description=>nil, 
          :twitter_profile=>['http://twitter.com/Veritiv'], 
          :linkedin_profile=>['https://www.linkedin.com/company/veritiv'], 
          :facebook_profile=>['http://facebook.com/VeritivCorp'], 
          :instagram_profile=>[], 
          :vimeo_profile=>[], 
          :pinterest_profile=>[], 
          :youtube_channel=>['http://youtube.com/user/VeritivCorp'], 
          :emails=>[], 
          :phone_numbers=>[], 
          :redirected_to=>'https://www.veritivcorp.com/veritiv-homepage'
        }
      )
    end
  end

  it 'should return {} when no valid data available' do
    VCR.use_cassette('no_valid_data_to_scrape') do
      data = BrilliantWebScraper.new('objectivemanager.com')
      expect(data).to eq({})
    end
  end
  
  describe 'parse exceptions' do
    it 'should enforce UTF-8 encoding and retry parsing' do
      VCR.use_cassette('invalid_byte_sequence_utf_8') do
        data = BrilliantWebScraper.new('mzaabudhabi.ae')
        expect(data[:scrape_data]).to eq(
          { :title=>"Media Zone Authority",
            :meta_description=>"Find out what the Media Zone Authority is about",
            :org_description=>nil,
            :twitter_description=>nil,
            :twitter_profile=>[],
            :linkedin_profile=>[],
            :facebook_profile=>[],
            :instagram_profile=>[],
            :vimeo_profile=>[],
            :pinterest_profile=>[],
            :youtube_channel=>nil,
            :emails=>["regulatoryaffairs@mzaabudhabi.ae"],
            :phone_numbers=>["+971 2 401 2454"],
            :redirected_to=>"https://www.mzaabudhabi.ae/en/"
         }
        )
      end
    end

    it 'should raise parse exception' do
      VCR.use_cassette('encoding_compatibility_error') do
        expect { 
          BrilliantWebScraper.new('ablesolicitors.ie')
        }.to raise_error(WebScraper::ParserError)
      end      
    end
  end
end
require 'spec_helper'

describe 'Linkedin Profile' do
  
  class DummyTestClass
    include LinkedinProfile
  end
  let(:dummy_object) { DummyTestClass.new }

  it 'should return nil for invalid input' do
    expect(dummy_object.grep_linkedin_profile(nil)).to be_nil
    expect(dummy_object.grep_linkedin_profile('')).to be_nil
  end

  it 'should not grep below url format' do
  	html = <<~HTML
  		<a href="https://www.linkedin.com" style="color: white;" class="fa fa-linkedin"></a>
  		<a href="https://www.linkedin.com/feed/" style="color: white;" class="fa fa-linkedin"></a>
  		<a href="https://www.linkedin.com/mynetwork/" style="color: white;" class="fa fa-linkedin"></a>
  		<a href="https://www.linkedin.com/jobs/" style="color: white;" class="fa fa-linkedin"></a>
  		<a href="https://www.linkedin.com/messaging/" style="color: white;" class="fa fa-linkedin"></a>
  		<a href="https://www.linkedin.com/notifications/" style="color: white;" class="fa fa-linkedin"></a>
  		<a href="https://www.linkedin.com/psettings/" style="color: white;" class="fa fa-linkedin"></a>
  		<a href="https://www.linkedin.com/ca/pet-32/" style="color: white;" class="fa fa-linkedin"></a>
  	HTML
  	expect(dummy_object.grep_linkedin_profile(html.to_s)).to eq([])
  end

  it 'should grep organization linkedin profiles' do
  	html = <<~HTML
  		<a href="https://www.linkedin.com/company/13247248/" target="_blank">Linkedin</a>
  		<a href="https://www.linkedin.com/company/m-files-corporation" target="_blank">Linkedin</a>
  		<a href="https://www.linkedin.com/company/dataendure" target="_blank">Linkedin</a>
  	HTML
  	linkedin_profiles = dummy_object.grep_linkedin_profile(html.to_s)
  	expected_linkedin_profiles = [
  		'https://www.linkedin.com/company/13247248',
  		'https://www.linkedin.com/company/m-files-corporation',
  		'https://www.linkedin.com/company/dataendure'
  	]
  	expect(dummy_object.grep_linkedin_profile(html.to_s)).to eq(expected_linkedin_profiles)
  end
end
require 'spec_helper'

describe 'Instagram Profile' do
  
  class DummyTestClass
    include InstagramProfile
  end
  let(:dummy_object) { DummyTestClass.new }

  it 'should return nil for invalid input' do
    expect(dummy_object.grep_instagram_profile(nil)).to be_nil
    expect(dummy_object.grep_instagram_profile('')).to be_nil
  end

  it 'should not grep below url format' do
  	html = <<~HTML
      <a href="http://instagram.com/" style="color: white;" class="fa fa-instagram"></a>
  		<a href="http://instagram.com/#" style="color: white;" class="fa fa-instagram"></a>
  		<a href="https://www.instagram.com/%username%" style="color: white;" class="fa fa-instagram"></a>
  		<a href="https://www.instagram.com/explore/tags/Talent/" style="color: white;" class="fa fa-instagram"></a>
  	HTML
  	expect(dummy_object.grep_instagram_profile(html.to_s)).to eq([])
  end

  it 'should grep organization instagram profiles' do
  	html = <<~HTML
  		<a href="https://www.instagram.com/nextgenhealthcare" target="_blank">Instagram</a>
  		<a href="https://instagram.com/nextgenhealthcare" target="_blank">Instagram</a>
  		<a href="https://www.instagram.com/printed4you.co.uk" target="_blank">Instagram</a>
      <a href="https://www.instagram.com/web_spiders" target="_blank">Instagram</a>
      <a href="http://instagram.com/mccaincanada?ref=badge" target="_blank">Instagram</a>
      <a href="http://instagram.com/mcdermottscholars&quot;,&quot;target&quot;:&quot;_blank&quot;}},&quot;displayMode&quot;:&quot;fill&quot;}" target="_blank">Instagram</a>
    HTML
  	instagram_profiles = dummy_object.grep_instagram_profile(html.to_s)
  	expected_instagram_profiles = [
  		'https://www.instagram.com/nextgenhealthcare',
  		'https://instagram.com/nextgenhealthcare',
  		'https://www.instagram.com/printed4you.co.uk',
      'https://www.instagram.com/web_spiders',
      'http://instagram.com/mccaincanada',
      'http://instagram.com/mcdermottscholars'
  	]
  	expect(dummy_object.grep_instagram_profile(html.to_s)).to eq(instagram_profiles)
  end
end
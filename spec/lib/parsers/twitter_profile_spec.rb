require 'spec_helper'

describe 'Twitter Profile' do
  
  class DummyTestClass
    include TwitterProfile
  end
  let(:dummy_object) { DummyTestClass.new }

  it 'should return nil for invalid input' do
    expect(dummy_object.grep_twitter_profile(nil)).to be_nil
    expect(dummy_object.grep_twitter_profile('')).to be_nil
  end

  it 'should not grep any non profile url' do
    html = <<~HTML
      <a href="http://twitter.com/download/iphone\\" target="_blank">
      <a href="http://twitter.com/%user_screen_name%/statuses/%id%" target="_blank">
      <a href="https://twitter.com/i/web/status/1116404686133686272" target="_blank">
      <a href="https://twitter.com/" target="_blank">
      <a href="http://twitter.com/\'+reply.substring(1)+" target="_blank">
      <a href="http://twitter.com/#" target="_blank">
      <a href="https://twitter.com/intent/tweet?text=https://www.facebook.com/ChoosePremiere/photos/a.10151220913587649/10157236078952649/?type=3'," target="_blank">
      <a href="https://twitter.com/share?url=https://dirigoagency.com/" target="_blank">
      <a href="https://twitter.com/search?q=%23solicitors&src=hash" target="_blank">
      <a href="https://twitter.com/hashtag/salisburysalutes?src=hash" target="_blank">
      <a href="https://twitter.com/privacy" target="_blank">
      <a href="https://twitter.com/home?status=Hey" target="_blank">
      <a href="https://twitter.com/statuses/1113546402863312896" target="_blank">
      <a href="https://twitter.com/login" target="_blank">
      <a href=" http://twitter.com/share/" target="_blank">
      <a href="https://twitter.com/#!/Farmer_Brothers" target="_blank">
      <a href="http://twitter.com/javascripts/blogger.js" target="_blank">
    HTML
    expect(dummy_object.grep_twitter_profile(html.to_s)).to eq([])
  end

  it 'should grep valid urls' do
    html = <<~HTML
      <a href="http://twitter.com/_titaniumrings" target="_blank">
      <a href="http://twitter.com/_Titaniumrings" target="_blank">
      <a href="http://twitter.com/@clindiatwitt" target="_blank">
      <a href="http://twitter.com/8of12" target="_blank">
      <a href="http://twitter.com/AAB_Accountants" target="_blank">
      <a href="http://twitter.com/SundanceCompany/statuses/1148708421308485637" target="_blank">
    HTML
    twitter_profiles = dummy_object.grep_twitter_profile(html.to_s)

    expected_profiles = [
      "http://twitter.com/_titaniumrings", 
      "http://twitter.com/_Titaniumrings", 
      "http://twitter.com/@clindiatwitt", 
      "http://twitter.com/8of12", 
      "http://twitter.com/AAB_Accountants", 
      "http://twitter.com/SundanceCompany/statuses/1148708421308485637"
    ]
    expect(twitter_profiles).to eq(expected_profiles)
  end
end

require 'spec_helper'

describe 'Pinterest Profile' do
  
  class DummyTestClass
    include PinterestProfile
  end
  let(:dummy_object) { DummyTestClass.new }

  it 'should return nil for invalid input' do
    expect(dummy_object.grep_pinterest_profile(nil)).to be_nil
    expect(dummy_object.grep_pinterest_profile('')).to be_nil
  end

  it 'should not grep below url format' do
  	html = <<~HTML
  		<a href="http://pinterest.com/#" style="color: white;" class="fa fa-pinterest"></a>
      <a href="http://pinterest.com/" style="color: white;" class="fa fa-pinterest"></a>
  		<a href="https://www.pinterest.com/feed/" style="color: white;" class="fa fa-pinterest"></a>
  		<a href="https://ct.pinterest.com/v3/?tid=2620913945757&amp;noscript=1" style="color: white;" class="fa fa-pinterest"></a>
  		<a href="http://assets.pinterest.com/js/pinmarklet.js?r=" style="color: white;" class="fa fa-pinterest"></a>
  		<a href="http://pinterest.com/pin/create/bookmarklet/" style="color: white;" class="fa fa-pinterest"></a>
  		<a href="http://uk.pinterest.com/pin/create/bookmarklet/" style="color: white;" class="fa fa-pinterest"></a>
      <a href="https://ct.pinterest.com/?tid=8KRsk0UkbVS&value=0.00&quantity=1" style="color: white;" class="fa fa-pinterest"></a>
      <a href="https://policy.pinterest.com/cookies" style="color: white;" class="fa fa-pinterest"></a>
    HTML
  	expect(dummy_object.grep_pinterest_profile(html.to_s)).to eq([])
  end

  it 'should grep organization pinterest profiles' do
  	html = <<~HTML
  		<a href="http://www.pinterest.com/blogher" target="_blank">pinterest</a>
  		<a href="http://pinterest.com/orientaltrading?cm_sp=Footer-_-SocialLinks-_-Pinterest" target="_blank">pinterest</a>
  		<a href="http://pinterest.com/poppin&quot;" target="_blank">pinterest</a>
  	HTML
  	pinterest_profiles = dummy_object.grep_pinterest_profile(html.to_s)
  	expected_pinterest_profiles = [
  		'http://www.pinterest.com/blogher',
  		'http://pinterest.com/orientaltrading',
  		'http://pinterest.com/poppin'
  	]
  	expect(dummy_object.grep_pinterest_profile(html.to_s)).to eq(expected_pinterest_profiles)
  end
end
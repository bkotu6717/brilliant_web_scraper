require 'spec_helper'

describe 'Vimeo Profile' do
  
  class DummyTestClass
    include VimeoProfile
  end
  let(:dummy_object) { DummyTestClass.new }

  it 'should return nil for invalid input' do
    expect(dummy_object.grep_vimeo_profile(nil)).to be_nil
    expect(dummy_object.grep_vimeo_profile('')).to be_nil
  end

  it 'should not grep any non profile url' do
    html = <<~HTML
      <a href="https://vimeo.com/" target="_blank">
      <a href="https://vimeo.com/upgrade" target="_blank">
      <a href="https://vimeo.com/features" target="_blank">
      <a href="https://vimeo.com/enterprise/" target="_blank">
      <a href="https://vimeo.com/upload" target="_blank">
      <a href="https://vimeo.com/api/v2/" target="_blank">
    HTML
    expect(dummy_object.grep_vimeo_profile(html.to_s)).to eq([])
  end

  it 'should grep valid urls' do
    html = <<~HTML
      <a href="https://vimeo.com/107578087" target="_blank">
      <a href="https://vimeo.com/channels/332103" target="_blank">
      <a href="https://vimeo.com/talech" target="_blank">
      <a href="https://vimeo.com/292173295/fdb8634a35/" target="_blank">
    HTML
    vimeo_profiles = dummy_object.grep_vimeo_profile(html.to_s)
    expected_profiles = [ 
      'https://vimeo.com/107578087', 
      'https://vimeo.com/channels/332103', 
      'https://vimeo.com/talech', 
      'https://vimeo.com/292173295/fdb8634a35/', 
    ]
    expect(vimeo_profiles).to eq(expected_profiles)
  end
end

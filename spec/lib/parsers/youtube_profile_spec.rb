require 'spec_helper'

describe 'Youtube Profile' do
  
  class DummyTestClass
    include YoutubeChannel
  end
  let(:dummy_object) { DummyTestClass.new }

  it 'should return nil for invalid input' do
    expect(dummy_object.grep_youtube_channel(nil)).to be_nil
    expect(dummy_object.grep_youtube_channel('')).to be_nil
  end

  it 'should not grep any non profile url' do
    html = <<~HTML
      <a href="https://www.youtube.com/embed/" target="_blank">
      <a href="http://www.youtube.com/player_api?ver=1" target="_blank">
      <a href="https://www.youtube.com/embed/" target="_blank">
      <a href="https://www.youtube.com/feeds/videos.xml" target="_blank">
      <a href="https://www.youtube.com/embed/{{video-id-yt}}" target="_blank">
      <a href="https://www.youtube.com/embed/$1$3" target="_blank">
      <a href="https://www.youtube.com/embed/[field_banner_video]" target="_blank">
      <a href="http://www.youtube.com/" target="_blank">
      <a href="https://www.youtube.com/?gl=IN&hl=en-GB" target="_blank">
      <a href="http://www.youtube.com/watch?\\" target="_blank">
      <a href="http://www.youtube.com/watch?'" target="_blank">
      <a href="http://www.youtube.com/watch?" target="_blank">
      <a href="http://www.youtube.com/watch? " target="_blank">
      <a href="http://www.youtube.com/watch?+" target="_blank">
    HTML
    expect(dummy_object.grep_youtube_channel(html.to_s)).to eq([])
  end

  it 'should bring channel starting with id url as channel url' do
    html = <<~HTML
      <a href="http://www.youtube.com/idtsemiconductor" target="_blank">
      HTML
    expect(dummy_object.grep_youtube_channel(html.to_s)).to eq(['http://www.youtube.com/idtsemiconductor'])
    
  end

  describe 'Enforce order of YouTube channel url preferce' do
    it 'should grep  /channel-name as channel url(prefered channel url)' do
      html = <<~HTML
        <a href="https://www.youtube.com/watch?v=ZPV0JOMX-KI?ie=UTF-8&oe=UTF-8&q=prettyphoto&iframe=true&width=100%&height=100%" target="_blank">
        <a href="http://www.youtube.com/10Thmagnitude" target="_blank">
        <a href="https://www.youtube.com/watch?v=TorCiltsk6E&feature=youtu.be" target="_blank">
        <a href="https://www.youtube.com/embed/D9ZPdSyud2Q" target="_blank">
        <a href="https://www.youtube.com/channel/UCrwE8kVqtIUVUzKui2WVpuQ" target="_blank">
        <a href="http://www.youtube.com/c/AnneMariaBello" target="_blank">
        <a href="https://www.youtube.com/user/BJP4India" target="_blank">
        <a href="https://www.youtube.com/playlist?list=PLPMCnAPD5b54hbt2JpyOSFdwm_uc2zpzG" target="_blank">
        <a href="http://youtube.com/subscription_center?add_user=SunnybrookMedia" target="_blank">
      HTML
      expected_profiles = [
        "http://www.youtube.com/10Thmagnitude", 
        "https://www.youtube.com/channel/UCrwE8kVqtIUVUzKui2WVpuQ", 
        "http://www.youtube.com/c/AnneMariaBello", 
        "https://www.youtube.com/user/BJP4India", 
        "https://www.youtube.com/playlist?list=PLPMCnAPD5b54hbt2JpyOSFdwm_uc2zpzG", 
        "http://youtube.com/subscription_center?add_user=SunnybrookMedia"
      ]
      profiles = dummy_object.grep_youtube_channel(html.to_s)
      expect(profiles).to eq(expected_profiles)
    end
    it 'should grep /watch? url as channel url(2nd choice)' do
      html = <<~HTML
        <a href="https://www.youtube.com/embed/D9ZPdSyud2Q" target="_blank">
        <a href="https://www.youtube.com/watch?v=TorCiltsk6E&feature=youtu.be" target="_blank">
        <a href="https://www.youtube.com/watch?v=ZPV0JOMX-KI?ie=UTF-8&oe=UTF-8&q=prettyphoto&iframe=true&width=100%&height=100%" target="_blank">
      HTML
      expect(dummy_object.grep_youtube_channel(html.to_s)).to eq(["https://www.youtube.com/watch?v=TorCiltsk6E", "https://www.youtube.com/watch?v=ZPV0JOMX-KI?ie=UTF-8"])
    end
    it 'should grep /embed/ url as channel url(3r choice)' do
      html = <<~HTML
        <a href="https://www.youtube.com/embed/D9ZPdSyud2Q" target="_blank">
      HTML
      expect(dummy_object.grep_youtube_channel(html.to_s)).to eq(['https://www.youtube.com/embed/D9ZPdSyud2Q'])
    end
  end
end

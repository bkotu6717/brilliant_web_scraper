require 'spec_helper'

describe 'Title' do
  
  class DummyTestClass
  	include Title
	end
  let(:dummy_object) { DummyTestClass.new }
  
  it 'should return nil response for invalid inputs' do
  	expect(dummy_object.grep_title(nil)).to be_nil
  	expect(dummy_object.grep_title('')).to be_nil
  end

  it 'should return nil for no title presence' do
    no_title_html = <<~HTML
      <meta charset="UTF-8">
      <meta http-equiv="x-ua-compatible" content="ie=edge">
      <meta name="viewport" content="width=device-width, initial-scale=1">
      <title> </title>
      <link href="/on/demandware.static/Sites-Marmot_US-Site/-/default/dw8b6e883e/images/favicon.ico" rel="shortcut icon">
      <meta name="description" content=" Shop the official Marmot online store. Maker of performance outdoor clothing and gear for travel, hiking, camping, snowsports, and more.Marmot">
    HTML
    title = dummy_object.grep_title(no_title_html.to_s)
    expect(title).to eq(nil)
  end

  it 'should get title even from partially closed title tag' do
    partially_closed_title_tag = <<~HTML
       <title>Harmony (a Mediware company) is now WellSky. You are being redirected to WellSky.com.” /title>
    HTML
    title = dummy_object.grep_title(partially_closed_title_tag.to_s)
    expect(title).to eq('Harmony (a Mediware company) is now WellSky. You are being redirected to WellSky.com.”')
  end

  it 'should get title even title is multi line' do
    multi_line_title_tag = <<~HTML
      <title>
        Smartphone App Development Company | iPhone iPad App Development | Fredericton, Atlantic Canada | SEO Internet Marketing Website Design
      </title>
      <meta name="robots" content="index, follow" />
    HTML
    title = dummy_object.grep_title(multi_line_title_tag.to_s)
    expect(title).to eq('Smartphone App Development Company | iPhone iPad App Development | Fredericton, Atlantic Canada | SEO Internet Marketing Website Design')
  end

  it 'should unescpe html encodings from title' do
    partially_html_encoded_title = <<~HTML
      <link rel="pingback" href="https://www.idirect.net/xmlrpc.php">
      <title>ST Engineering iDirect &#8211; Shaping the Future of How the World Connects</title>
      <link rel="dns-prefetch" href="//platform.twitter.com">
    HTML
    title = dummy_object.grep_title(partially_html_encoded_title.to_s)
    expect(title).to eq('ST Engineering iDirect – Shaping the Future of How the World Connects')
  end

  it 'should remove unnecessary white spaces, new lines, tabs from title' do
    extra_spacing_title = <<~HTML
      <meta http-equiv="Content-type" content="text/html; charset=utf-8" /><meta http-equiv="Expires" content="0" /><meta http-equiv='content-language' content='en' /><title>

      A global technology and services company committed to innovation| Cegedim

      </title>
      <link rel="stylesheet" type="text/css" href="/_layouts/15/1033/styles/Themable/corev15.css?rev=2bpHeX9U8DH09TB5zpJcsQ%3D%3D"/>
    HTML
    title = dummy_object.grep_title(extra_spacing_title.to_s)
    expect(title).to eq('A global technology and services company committed to innovation| Cegedim')
  end
  it 'should pick very first title available' do
    multiple_title_html = <<~HTML
      <link rel="pingback" href="https://www.idirect.net/xmlrpc.php">
      <title>ST Engineering iDirect &#8211; Shaping the Future of How the World Connects</title>
      <link rel="dns-prefetch" href="//platform.twitter.com">
      <title>Title 2 - ST Engineering iDirect &#8211; Shaping the Future of How the World Connects</title>
    HTML
    title = dummy_object.grep_title(multiple_title_html.to_s)
    expect(title).to eq('ST Engineering iDirect – Shaping the Future of How the World Connects')
  end
  it 'should grep title with extra atrributes' do
    html = <<~HTML
      <title data-component-id="AdaptiveHtmlHead_01_6930" data-component-name="adaptiveHtmlHead" data-component-endpoint="/aries-common/v1/adaptiveHtmlHead.comp">Vancouver, Canada Hotel - City Center | Sheraton Vancouver Wall Centre</title>
    HTML
    title = dummy_object.grep_title(html.to_s)
    expect(title).to eq('Vancouver, Canada Hotel - City Center | Sheraton Vancouver Wall Centre')
  end
end


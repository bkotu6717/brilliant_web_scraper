require 'spec_helper'

describe 'Website Redirected To' do
  
  class DummyTestClass
  	include RedirectedTo
	end
  let(:dummy_object) { DummyTestClass.new }


  it 'should return nil for invalid input' do
		expect(dummy_object.grep_redirected_to_url(nil)).to be_nil
		expect(dummy_object.grep_redirected_to_url('')).to be_nil
	end

  describe 'Website grep from link tag' do
  	describe 'rel attribute first ' do
	  	
	  	it 'should return nil when canonical url is empty' do
	  		html = <<~HTML
	  			<link rel="canonical" href="">
	  			<link rel="canonical" href=''>
	  		HTML
	  		website = dummy_object.grep_redirected_to_url(html.to_s)
	  		expect(website).to be_nil
	  	end

	  	it 'should grep website' do
	  		html = <<~HTML
	  			<link rel="canonical" href="">
	  			<link rel="canonical" href='https://www.apple.com/'>
	  		HTML
	  		website = dummy_object.grep_redirected_to_url(html.to_s)
	  		expect(website).to eq('https://www.apple.com/')
	  	end

	  	it 'should grep website even with extra attributes' do
	  		html = <<~HTML
	  			<link rel="canonical" href="" itemprop="current_url">
	  			<link rel="canonical" href='https://www.apple.com/' 
	  			itemprop="current_url" >
	  		HTML
	  		website = dummy_object.grep_redirected_to_url(html.to_s)
	  		expect(website).to eq('https://www.apple.com/')
	  	end
	  end
	  describe 'href attribute first' do
	  	it 'should return nil when canonical url is empty' do
	  		html = <<~HTML
	  			<link href="" rel="canonical" >
	  			<link href='' rel="canonical" >
	  		HTML
	  		website = dummy_object.grep_redirected_to_url(html.to_s)
	  		expect(website).to be_nil
	  	end

	  	it 'should grep website' do
	  		html = <<~HTML
	  			<link rel="canonical" href="">
	  			<link href='https://www.apple.com/' rel="canonical">
	  		HTML
	  		website = dummy_object.grep_redirected_to_url(html.to_s)
	  		expect(website).to eq('https://www.apple.com/')
	  	end

	  	it 'should grep website even with extra attributes' do
	  		html = <<~HTML
	  			<link href="" itemprop="current_url" rel="canonical">
	  			<link href='https://www.apple.com/' rel="canonical" 
	  			itemprop="current_url" >
	  		HTML
	  		website = dummy_object.grep_redirected_to_url(html.to_s)
	  		expect(website).to eq('https://www.apple.com/')
	  	end
	  end
  end
  describe 'Website grep from organization URL' do
  	describe 'property attribute first ' do
	  	it 'should return nil when canonical url is empty' do
	  		html = <<~HTML
	  			<meta property="og:url" content="" />
	  			<meta property="og:url" content='' />
	  		HTML
	  		website = dummy_object.grep_redirected_to_url(html.to_s)
	  		expect(website).to be_nil
	  	end

	  	it 'should grep website' do
	  		html = <<~HTML
	  			<link property="og:url" content="">
	  			<meta property="og:url" content="https://www.dieppe.ca/fr/index.aspx" />
	  		HTML
	  		website = dummy_object.grep_redirected_to_url(html.to_s)
	  		expect(website).to eq('https://www.dieppe.ca/fr/index.aspx')
	  	end

	  	it 'should grep website even with extra attributes' do
	  		html = <<~HTML
	  			<link property="og:url" content="" calss="og-url">
	  			<meta property="og:url" content='https://www.dieppe.ca/fr/index.aspx' 
	  			class="og-url" />
	  		HTML
	  		website = dummy_object.grep_redirected_to_url(html.to_s)
	  		expect(website).to eq('https://www.dieppe.ca/fr/index.aspx')
	  	end
	  end
	  describe 'content attribute first ' do
	  	it 'should return nil when canonical url is empty' do
	  		html = <<~HTML
	  			<meta content="" property="og:url" />
	  			<meta content='' property="og:url"/>
	  		HTML
	  		website = dummy_object.grep_redirected_to_url(html.to_s)
	  		expect(website).to be_nil
	  	end

	  	it 'should grep website' do
	  		html = <<~HTML
	  			<link content="" property="og:url" >
	  			<meta content="https://www.dieppe.ca/fr/index.aspx" property="og:url"  />
	  		HTML
	  		website = dummy_object.grep_redirected_to_url(html.to_s)
	  		expect(website).to eq('https://www.dieppe.ca/fr/index.aspx')
	  	end

	  	it 'should grep website even with extra attributes' do
	  		html = <<~HTML
	  			<link content="" calss="og-url" property="og:url">
	  			<meta content='https://www.dieppe.ca/fr/index.aspx' 
	  			class="og-url" property="og:url" />
	  		HTML
	  		website = dummy_object.grep_redirected_to_url(html.to_s)
	  		expect(website).to eq('https://www.dieppe.ca/fr/index.aspx')
	  	end
	  end
  end
  describe 'grep website' do
  	it 'it should return nil when link or og:url is absent' do
  		html = <<~HTML
  			<head>
			    <meta charset="utf-8">
			    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
			    <meta http-equiv="x-ua-compatible" content="ie=edge">
			    <title>Techmologic | index</title>
			    <!-- Font Awesome -->
			    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.6.0/css/font-awesome.min.css">
			    <!-- Bootstrap core CSS -->
			    <link href="css/bootstrap.min.css" rel="stylesheet">
			    <!-- Material Design Bootstrap -->
			    <link href="css/mdb.min.css" rel="stylesheet">
			    <!-- Your custom styles (optional) -->
			    <link href="css/style.css" rel="stylesheet">
			</head>
  		HTML
  		website = dummy_object.grep_redirected_to_url(html.to_s)
  		expect(website).to be_nil
  	end
  	it 'should grep one of canonical or og:url' do
  		html = <<~HTML
  			<head>
			    <meta charset="utf-8">
			    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
			    <meta http-equiv="x-ua-compatible" content="ie=edge">
			    <title>Techmologic | index</title>
			   	<link rel="canonical" href="">
			   	<meta property="og:url" content="" />
			    <!-- Font Awesome -->
			    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.6.0/css/font-awesome.min.css">
			    <!-- Bootstrap core CSS -->
			    <link href="css/bootstrap.min.css" rel="stylesheet">
			    <!-- Material Design Bootstrap -->
			    <link href="css/mdb.min.css" rel="stylesheet">
			    <!-- Your custom styles (optional) -->
			    <link href="css/style.css" rel="stylesheet">
			    <link rel="canonical" href="http://techmologics.com/">
			    <meta property="og:url" content="http://techmologics.com/" />
			</head>
  		HTML
  		website = dummy_object.grep_redirected_to_url(html.to_s)
  		expect(website).to eq('http://techmologics.com/')
  	end
  		it 'should grep one of canonical or og:url whatever it\'s position' do
  		html = <<~HTML
  			<head>
			    <meta charset="utf-8">
			    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
			    <meta http-equiv="x-ua-compatible" content="ie=edge">
			    <title>Techmologic | index</title>
			   	<link  href="" rel="canonical">
			   	<meta  content="" property="og:url"/>
			    <!-- Font Awesome -->
			    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.6.0/css/font-awesome.min.css">
			    <!-- Bootstrap core CSS -->
			    <link href="css/bootstrap.min.css" rel="stylesheet">
			    <!-- Material Design Bootstrap -->
			    <link href="css/mdb.min.css" rel="stylesheet">
			    <!-- Your custom styles (optional) -->
			    <link href="css/style.css" rel="stylesheet">
			    <link href="http://techmologics.com/" rel="canonical" class="canonical">
			    <meta content="http://techmologics.com/" property="og:url"/>
			</head>
  		HTML
  		website = dummy_object.grep_redirected_to_url(html.to_s)
  		expect(website).to eq('http://techmologics.com/')
  	end
  end
end
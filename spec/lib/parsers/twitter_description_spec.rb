require 'spec_helper'

describe 'Twitter Description' do
  
  class DummyTestClass
  	include TwitterDescription
	end
  let(:dummy_object) { DummyTestClass.new }

  it 'should return nil for invalid inputs' do
  	expect(dummy_object.grep_twitter_description('')).to be_nil
  	expect(dummy_object.grep_twitter_description(nil)).to be_nil
  end
  describe 'Name key first twitter description tag' do
  	it 'should return nil for no twitter description tag presence' do
  		no_org_description = <<~HTML
  			<head>
					<meta charset="utf-8">
					<meta http-equiv="X-UA-Compatible" content="IE=edge">
					<meta name="viewport" content="width=device-width, initial-scale=1">
					<title>Internet Service Providers Chennai | Internet Telephony Service Providers Chennai | Internet bandwidth Providers Chennai - Pulse Telesystems Pvt Ltd</title>
					<meta name="google-site-verification" content="h2NvZnvL9v536RUYH3jney-9V8JRBGESmzH5-ph0EM4">
					<link href="http://www.pulse.in/new/wp-content/themes/pulse/css/bootstrap.min.css" rel="stylesheet" type="text/css">
				</head>
  		HTML
  		twitter_description = dummy_object.grep_twitter_description(no_org_description.to_s)
  		expect(twitter_description).to be_nil
  	end

  	it 'should return nil when content part is empty' do
  		html = <<~HTML
  			<head>
					<meta http-equiv="X-UA-Compatible" content="IE=edge">
					<meta name="twitter:description" content="">
					<title>Internet Service Providers Chennai | Internet Telephony Service Providers Chennai | Internet bandwidth Providers Chennai - Pulse Telesystems Pvt Ltd</title>
					<link href="http://www.pulse.in/new/wp-content/themes/pulse/css/bootstrap.min.css" rel="stylesheet" type="text/css">
				</head>
  		HTML
  		twitter_description = dummy_object.grep_twitter_description(html.to_s)
  		expect(twitter_description).to be_nil
  	end

  	it 'should return description from valid tag' do
  		html = <<~HTML
  			<head>
					<meta content="With Hired your job search has never been easier! Simply create a profile &amp; vetted companies compete for you, reaching out with salary &amp; equity upfront." name="twitter:description">
					<meta content="" property="uid">
					<meta name="twitter:description" content="With Hired your job search has never been easier! Simply create a profile &amp; vetted companies compete for you, reaching out with salary &amp; equity upfront.">
					<meta content="width=device-width,initial-scale=1.0,maximum-scale=1.0,user-scalable=no" name="viewport">
  			</head>
  		HTML
  		twitter_description = dummy_object.grep_twitter_description(html.to_s)
  		expect(twitter_description).to eq('With Hired your job search has never been easier! Simply create a profile & vetted companies compete for you, reaching out with salary & equity upfront.')
  	end

  	it 'should return description even tag is multilined and partially encoded' do
  		html = <<~HTML
  			<head>
					<meta content="With Hired your job search has never been easier! Simply create a profile &amp; vetted companies compete for you, reaching out with salary &amp; equity upfront." name="twitter:description">
					<meta content="" property="uid">
					<meta name="twitter:description" content="With Hired your job search has never been easier! Simply create a profile &amp; vetted companies compete for you, reaching out with salary &amp; equity upfront.">
					<meta content="width=device-width,initial-scale=1.0,maximum-scale=1.0,user-scalable=no" 
					name="viewport">
  			</head>
  		HTML
  		twitter_description = dummy_object.grep_twitter_description(html.to_s)
  		expect(twitter_description).to eq('With Hired your job search has never been easier! Simply create a profile & vetted companies compete for you, reaching out with salary & equity upfront.')
  	end

  	it 'should parse meta tag even it is partially single quoted' do
  		html = <<~HTML
  			<head>
					<meta content="With Hired your job search has never been easier! Simply create a profile &amp; vetted companies compete for you, reaching out with salary &amp; equity upfront." name=\'twitter:description">
					<meta content="" property="uid">
					<meta name="twitter:description" content="With Hired your job search has never been easier! Simply create a profile &amp; vetted companies compete for you, reaching out with salary &amp; equity upfront.">
					<meta content="width=device-width,initial-scale=1.0,maximum-scale=1.0,user-scalable=no" 
					name="viewport">
  			</head>
  		HTML
  		twitter_description = dummy_object.grep_twitter_description(html.to_s)
  		expect(twitter_description).to eq('With Hired your job search has never been easier! Simply create a profile & vetted companies compete for you, reaching out with salary & equity upfront.')
  	end

  	it 'should parse meta tag even it is having other attributes defined' do
  		html = <<~HTML
  			<head>
					<meta content="With Hired your job search has never been easier! Simply create a profile &amp; vetted companies compete for you, reaching out with salary &amp; equity upfront." name="twitter:description">
					<meta content="" property="uid">
					<meta class="metadescription" property=\'og:description" content="With Hired your job search has never been easier! Simply create a profile &amp; vetted companies compete for you, reaching out with salary &amp; equity upfront." charset="UTF-8">
					<meta content="width=device-width,initial-scale=1.0,maximum-scale=1.0,user-scalable=no" 
					name="viewport">
  			</head>
  		HTML
  		twitter_description = dummy_object.grep_twitter_description(html.to_s)
  		expect(twitter_description).to eq('With Hired your job search has never been easier! Simply create a profile & vetted companies compete for you, reaching out with salary & equity upfront.')
  	end

  	it 'should parse meta tag with itemprop as description key' do
  		html = <<~HTML
  			<head>
					<meta content="With Hired your job search has never been easier! Simply create a profile &amp; vetted companies compete for you, reaching out with salary &amp; equity upfront." itemprop=\'twitter:description">
					<meta content="" property="uid">
					<meta content="width=device-width,initial-scale=1.0,maximum-scale=1.0,user-scalable=no" 
					name="viewport">
  			</head>
  		HTML
  		twitter_description = dummy_object.grep_twitter_description(html.to_s)
  		expect(twitter_description).to eq('With Hired your job search has never been easier! Simply create a profile & vetted companies compete for you, reaching out with salary & equity upfront.')
  	end

  	it 'should parse even name/itemprop key content is improperly assigned' do
  		html = <<~HTML
  			<head>
					<meta content="" property="uid">
					<meta class="metadescription" name=twitter:description content="With Hired your job search has never been easier! Simply create a profile &amp; vetted companies compete for you, reaching out with salary &amp; equity upfront." charset="UTF-8" />
					<meta content="width=device-width,initial-scale=1.0,maximum-scale=1.0,user-scalable=no" 
					name="viewport">
  			</head>
  		HTML
  		twitter_description = dummy_object.grep_twitter_description(html.to_s)
  		expect(twitter_description).to eq('With Hired your job search has never been easier! Simply create a profile & vetted companies compete for you, reaching out with salary & equity upfront.')
  	end

  	it 'should bring description having single quote' do
  		html = <<~HTML
  			<html lang="en">
					<head>
						<META charset="utf-8">
						<meta http-equiv="X-UA-Compatible" content="IE=Edge" />
						<meta name="viewport" content="width=device-width, initial-scale=1" />
						<title>Wilentz, Goldman & Spitzer: NJ, NYC and PA Full-Service Law Firm</title>
						<meta name="twitter:description" content="Wilentz Goldman & Spitzer is one of New Jersey's largest law firms. Our lawyers proudly serve our clients in nearly every aspect of law." />
  				</head>
  			<html>
  		HTML
  		twitter_description = dummy_object.grep_twitter_description(html.to_s)
  		expect(twitter_description).to eq('Wilentz Goldman & Spitzer is one of New Jersey\'s largest law firms. Our lawyers proudly serve our clients in nearly every aspect of law.')
  	end

  	it 'should bring description having double quote' do
  		html = <<~HTML
  			<html lang="en">
					<head>
						<META charset="utf-8">
						<meta http-equiv="X-UA-Compatible" content="IE=Edge" />
						<meta name="viewport" content="width=device-width, initial-scale=1" />
						<title>Wilentz, Goldman & Spitzer: NJ, NYC and PA Full-Service Law Firm</title>
  					<meta name="twitter:description" content='Whether you&#039;re a Mac "die-hard" or an iPad "newbie" we give you the scoop on what&#039;s new, what&#039;s best and how to make the most out of the products you love.' />
  				</head>
  			<html>
  		HTML
  		twitter_description = dummy_object.grep_twitter_description(html.to_s)
  		expect(twitter_description).to eq('Whether you\'re a Mac "die-hard" or an iPad "newbie" we give you the scoop on what\'s new, what\'s best and how to make the most out of the products you love.')
  	end

  	it "should bring description even some other meta tag is empty" do
  		html = <<~HTML
  			<html lang="en">
					<head>
						<META charset="utf-8">
						<meta http-equiv="X-UA-Compatible" content="IE=Edge" />
						<meta name="viewport" content="width=device-width, initial-scale=1" />
						<title>Wilentz, Goldman & Spitzer: NJ, NYC and PA Full-Service Law Firm</title>
  					<meta name="twitter:description" content="">
  					<meta name="twitter:description" content='Whether you&#039;re a Mac "die-hard" or an iPad "newbie" we give you the scoop on what&#039;s new, what&#039;s best and how to make the most out of the products you love.' />
  				</head>
  			<html>
  		HTML
  		twitter_description = dummy_object.grep_twitter_description(html.to_s)
  		expect(twitter_description).to eq('Whether you\'re a Mac "die-hard" or an iPad "newbie" we give you the scoop on what\'s new, what\'s best and how to make the most out of the products you love.')
  	end
  end
  describe 'Content key first organization description tag' do
  	it 'should return nil when content part is empty' do
  		no_twitter_description = <<~HTML
  			<head>
					<meta http-equiv="X-UA-Compatible" content="IE=edge">
					<meta content="" name="twitter:description">
					<meta content='' name="twitter:description">
					<title>Internet Service Providers Chennai | Internet Telephony Service Providers Chennai | Internet bandwidth Providers Chennai - Pulse Telesystems Pvt Ltd</title>
					<link href="http://www.pulse.in/new/wp-content/themes/pulse/css/bootstrap.min.css" rel="stylesheet" type="text/css">
				</head>
  		HTML
  		twitter_description = dummy_object.grep_twitter_description(no_twitter_description.to_s)
  		expect(twitter_description).to be_nil
  	end

  	it 'should return description from valid tag' do
  		html = <<~HTML
  			<head>
					<meta content="" property="uid">
					<meta content="With Hired your job search has never been easier! Simply create a profile &amp; vetted companies compete for you, reaching out with salary &amp; equity upfront." name="twitter:description">
					<meta content="width=device-width,initial-scale=1.0,maximum-scale=1.0,user-scalable=no" name="viewport">
  			</head>
  		HTML
  		twitter_description = dummy_object.grep_twitter_description(html.to_s)
  		expect(twitter_description).to eq('With Hired your job search has never been easier! Simply create a profile & vetted companies compete for you, reaching out with salary & equity upfront.')
  	end

  	it 'should return description even tag is multilined and partially encoded' do
  		html = <<~HTML
  			<head>
					<meta content="" property="uid">
					<meta content="With Hired your job search has never been easier! Simply create a profile &amp; vetted companies compete for you, reaching out with salary &amp; equity upfront." name="twitter:description" >
					<meta content="width=device-width,initial-scale=1.0,maximum-scale=1.0,user-scalable=no" 
					name="viewport">
  			</head>
  		HTML
  		twitter_description = dummy_object.grep_twitter_description(html.to_s)
  		expect(twitter_description).to eq('With Hired your job search has never been easier! Simply create a profile & vetted companies compete for you, reaching out with salary & equity upfront.')
  	end

  	it 'should parse meta tag even it is partially single quoted' do
  		html = <<~HTML
  			<head>
					<meta content="" property="uid">
					<meta content="With Hired your job search has never been easier! Simply create a profile &amp; vetted companies compete for you, reaching out with salary &amp; equity upfront." name=\'twitter:description">
					<meta content="width=device-width,initial-scale=1.0,maximum-scale=1.0,user-scalable=no" 
					name="viewport">
  			</head>
  		HTML
  		twitter_description = dummy_object.grep_twitter_description(html.to_s)
  		expect(twitter_description).to eq('With Hired your job search has never been easier! Simply create a profile & vetted companies compete for you, reaching out with salary & equity upfront.')
  	end

  	it 'should parse meta tag even it is having other attributes defined' do
  		html = <<~HTML
  			<head>
					<meta content="" property="uid">
					<meta class="metadescription" content="With Hired your job search has never been easier! Simply create a profile &amp; vetted companies compete for you, reaching out with salary &amp; equity upfront." charset="UTF-8" name=\'twitter:description">
					<meta content="width=device-width,initial-scale=1.0,maximum-scale=1.0,user-scalable=no" 
					name="viewport">
  			</head>
  		HTML
  		twitter_description = dummy_object.grep_twitter_description(html.to_s)
  		expect(twitter_description).to eq('With Hired your job search has never been easier! Simply create a profile & vetted companies compete for you, reaching out with salary & equity upfront.')
  	end

  	it 'should parse meta tag with itemprop as description key' do
  		html = <<~HTML
  			<head>
					<meta content="" property="uid">
					<meta class="metadescription" content="With Hired your job search has never been easier! Simply create a profile &amp; vetted companies compete for you, reaching out with salary &amp; equity upfront." itemprop=\'twitter:description" charset="UTF-8">
					<meta content="width=device-width,initial-scale=1.0,maximum-scale=1.0,user-scalable=no" 
					name="viewport">
  			</head>
  		HTML
  		twitter_description = dummy_object.grep_twitter_description(html.to_s)
  		expect(twitter_description).to eq('With Hired your job search has never been easier! Simply create a profile & vetted companies compete for you, reaching out with salary & equity upfront.')
  	end

  	it 'should parse even name/itemprop key content is improperly assigned' do
  		html = <<~HTML
  			<head>
					<meta content="" property="uid">
					<meta class="metadescription" content="With Hired your job search has never been easier! Simply create a profile &amp; vetted companies compete for you, reaching out with salary &amp; equity upfront." charset="UTF-8" name=twitter:description />
					<meta content="width=device-width,initial-scale=1.0,maximum-scale=1.0,user-scalable=no" 
					name="viewport">
  			</head>
  		HTML
  		twitter_description = dummy_object.grep_twitter_description(html.to_s)
  		expect(twitter_description).to eq('With Hired your job search has never been easier! Simply create a profile & vetted companies compete for you, reaching out with salary & equity upfront.')
  	end

  	it 'should bring description having single quote' do
  		html = <<~HTML
  			<html lang="en">
					<head>
						<META charset="utf-8">
						<meta http-equiv="X-UA-Compatible" content="IE=Edge" />
						<meta name="viewport" content="width=device-width, initial-scale=1" />
						<title>Wilentz, Goldman & Spitzer: NJ, NYC and PA Full-Service Law Firm</title>
						<meta content="Wilentz Goldman & Spitzer is one of New Jersey's largest law firms. Our lawyers proudly serve our clients in nearly every aspect of law." name="twitter:description"	/>
  				</head>
  			<html>
  		HTML
  		twitter_description = dummy_object.grep_twitter_description(html.to_s)
  		expect(twitter_description).to eq('Wilentz Goldman & Spitzer is one of New Jersey\'s largest law firms. Our lawyers proudly serve our clients in nearly every aspect of law.')
  	end

  	it 'should bring description having double quote' do
  		html = <<~HTML
  			<html lang="en">
					<head>
						<META charset="utf-8">
						<meta http-equiv="X-UA-Compatible" content="IE=Edge" />
						<meta name="viewport" content="width=device-width, initial-scale=1" />
						<title>Wilentz, Goldman & Spitzer: NJ, NYC and PA Full-Service Law Firm</title>
  					<meta content='Whether you&#039;re a Mac "die-hard" or an iPad "newbie" we give you the scoop on what&#039;s new, what&#039;s best and how to make the most out of the products you love.' name="twitter:description" />
  				</head>
  			<html>
  		HTML
  		twitter_description = dummy_object.grep_twitter_description(html.to_s)
  		expect(twitter_description).to eq('Whether you\'re a Mac "die-hard" or an iPad "newbie" we give you the scoop on what\'s new, what\'s best and how to make the most out of the products you love.')
  	end

  	it "should bring description even some other meta tag is empty" do
  		html = <<~HTML
  			<html lang="en">
					<head>
						<META charset="utf-8">
						<meta http-equiv="X-UA-Compatible" content="IE=Edge" />
						<meta name="viewport" content="width=device-width, initial-scale=1" />
						<title>Wilentz, Goldman & Spitzer: NJ, NYC and PA Full-Service Law Firm</title>
  					<meta content="" name="twitter:description">
  					<meta content='Whether you&#039;re a Mac "die-hard" or an iPad "newbie" we give you the scoop on what&#039;s new, what&#039;s best and how to make the most out of the products you love.' name="twitter:description"/>
  				</head>
  			<html>
  		HTML
  		twitter_description = dummy_object.grep_twitter_description(html.to_s)
  		expect(twitter_description).to eq('Whether you\'re a Mac "die-hard" or an iPad "newbie" we give you the scoop on what\'s new, what\'s best and how to make the most out of the products you love.')
  	end
  end
end

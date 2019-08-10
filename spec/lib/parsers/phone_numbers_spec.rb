require 'spec_helper'

describe 'PhoneNumbers' do
  
  class DummyTestClass
    include PhoneNumbers
  end
  let(:dummy_object) { DummyTestClass.new }

  it 'should return nil for invalid input' do
    expect(dummy_object.grep_phone_numbers(nil)).to be_nil
    expect(dummy_object.grep_phone_numbers('')).to be_nil
  end

  it 'should give []' do
  	html = <<~HTML
      <a href="tel:{{ location1Phone }}">
      <a  href="tel:{{pdModel.preferredDealer.phoneNumbers[0].CompleteNumber.$}}">
      <a href="tel:[value]" data-store-phone data-attr-replace="href"></a>
      <a class="a--reset main-nav--mobile__link--secondary ">Grab us on Live Chat</a>
  	HTML
  	expect(dummy_object.grep_phone_numbers(html.to_s)).to eq([])
  end
  it 'should grep organization phoneNumbers' do
  	html = <<~HTML
      <a href="tel: &#xA;&#x9;&#x9;&#x9;&#x9;&#x9;&#x9;01598 760 700&#xA;&#x9;&#x9;&#x9;&#x9;&#x9;" class="button tel">Tel: 01598 760 700</a>
      <a href="tel: +1 (856) 393-2082">+1 (856) 393-2082</a> 
      <a href="tel: 800%20843%203269" data-interaction-context data-interaction-type="phone" data-interaction-name="800 843 3269" class="cta" tabindex="0">
        <span class="cta-content">
          <span class="cta-text" tabindex="-1">
            Call Now 800 843 3269
          </span>
        </span>
      </a>
      <a href="tel://1-859-422-6000">859.422.6000</a>
      <a href="tel:&#43;18009634816" class="btn btn-tertiary" data-tag="call">Call</a>
      <a href="tel:%2B44-161-468-1234">0161 468 1234</a>
      <a class="navbar-left" href="tel:781-788-8180 Ext. 4"> <b>Call Sales</b> 781-788-8180 Ext. 4 </a>
      <a href="tel:8663033809">Call</a>
      <a href="tel:http://484-373-7700"><span class="icon fa fa-phone"></span>484-373-7700</a>
      <a href="tel:877.720.0411" data-organic="877.720.0411" data-metro="877.720.0411" data-display="877.720.0411" data-paid="877.720.0411" class="phone"><span class="number">877.720.0411</span></a>
      <a href="tel:1866INTRALINKS">1-866-INTRALINKS</a>
      <a href=tel:1888%20810%207464 itemprop=url>Call</a>
      <a href=tel:18664946627 style="color: inherit; display: inline;">1 (866) 4-WINMAR</a>
      <a href=tel:312-379-9329 class=phone>312-379-9329</a>
      <a href=tel:312-379-9329 class=phone>312-379-9329</a>
      <a\ndata-animsition-out=none href=tel:01722412512>Tel: 01722 412512</a>

    HTML
  	phone_numbers = dummy_object.grep_phone_numbers(html.to_s)
    expected_phone_numbers = [
      "01598 760 700", 
      "+1 (856) 393-2082", 
      "800 843 3269", 
      "1-859-422-6000", 
      "+18009634816", 
      "+44-161-468-1234", 
      "781-788-8180 Ext. 4", 
      "8663033809", "484-373-7700", 
      "877.720.0411", 
      "1866INTRALINKS", 
      "1888 810 7464 ", 
      "18664946627 ", 
      "312-379-9329 ", 
      "01722412512"
    ]
    expect(phone_numbers).to eq(expected_phone_numbers)
  end
end

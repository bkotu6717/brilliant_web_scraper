require 'spec_helper'

describe 'Emails' do
  
  class DummyTestClass
    include Emails
  end
  let(:dummy_object) { DummyTestClass.new }

  it 'should return nil for invalid input' do
    expect(dummy_object.grep_emails(nil)).to be_nil
    expect(dummy_object.grep_emails('')).to be_nil
  end

  it 'should give []' do
  	html = <<~HTML
      <a href="mailto:abc@example.com">abc@example.com</a>
      <a href="mailto:example@mail.com">example@email.com</a>
      <a href="mailto:name@domain.com">name@domain.com</a>
      <a href="mailto:name@company.com">name@company.com</a>
      <a href="mailto:you@youremail.com">you@youremail.com</a>
      <a href="mailto:your@emailaddress.com">your@emailaddress.com</a>
      <a href="mailto:yourname@yourdomain.com">yourname@yourdomain.com</a>
      <a href="mailto:yourname@yourcompany.com">yourname@yourcompany.com</a>
      <a href="mailto:YOU@EMAILADRESS.COM">YOU@EMAILADRESS.COM</a>
      <a href="mailto:you@address.com">you@address.com</a>
      <a href="mailto:xxx@yyy.zzz">xxx@yyy.zzz</a>
      <a href="mailto:test@test.com">test@test.com</a>
      <a href="mailto:@example.com">@example.com"</a>
      <a href="mailto:v@201908240100.css">v@201908240100.css"</a>
      <a href="mailto:v@201908240100.js">v@201908240100.js"</a>
      <a href="mailto:ajax-loader@2x.gif">ajax-loader@2x.gif"</a>
      <a href="mailto:favicon@2x.ico">favicon@2x.ico"</a>
  	HTML
  	expect(dummy_object.grep_emails(html.to_s)).to eq([])
  end
  it 'should grep organization contact emailaddresses' do
  	html = <<~HTML
  		<a href="mailto:abc@example.com">abc@example.com</a>
      <a class="fusion-social-network-icon fusion-tooltip " style="color:#ffffff;" href="mailto:&#119;ils&#111;&#110;&#064;&#119;&#105;&#108;&#115;on&#046;n&#098;&#046;c&#097;" target="_self" title="Email">
        <span class="screen-reader-text">Email</span>
      </a>
      <div>
        <br><strong>Mailing address</strong>
        : 1320 Yonge Street, Toronto, Ontario&#160; M4T 1X2<br><br>
        <strong>Attendance</strong>:&#160;<br>Junior School: 1639attendance@yorkschool.com<br>Middle &amp; Senior School: 1320attendance@yorkschool.com<br><br>
      </div>
      <a href="mailto:%20support@switcherstudio.com">
      <a href="mailto:%20support@switcherstudio.com">
      <a href="mailto:ekerlow@hellermanllc.com">
      &lt;a href=\\&quot;mailto:Michael.O%27Brien@idga.org?subject=Editorial%20Calendar%20Contributor\\&quot;&gt
    HTML
  	emails = dummy_object.grep_emails(html.to_s)
    expected_emails = [
      "wilson@wilson.nb.ca", 
      "support@switcherstudio.com", 
      "ekerlow@hellermanllc.com", 
      "michael.o'brien@idga.org", 
      "1639attendance@yorkschool.com", 
      "1320attendance@yorkschool.com"
    ]
    expect(emails).to eq(expected_emails)
  end
end
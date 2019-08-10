require 'spec_helper'

describe 'FaceBook Profile' do
  
  class DummyTestClass
    include FacebookProfile
  end
  let(:dummy_object) { DummyTestClass.new }

  it 'should return nil for invalid input' do
    expect(dummy_object.grep_facebook_profile(nil)).to be_nil
    expect(dummy_object.grep_facebook_profile('')).to be_nil
  end

  it 'should not grep any non profile url' do
    html = <<~HTML
      <a href="http://www.facebook.com/2008/fbml" target="_blank" class="sqs-svg-icon--wrapper facebook">
      <a href="https://www.facebook.com/v2.0/dialog/share" target="_blank" class="sqs-svg-icon--wrapper facebook">
      <a href="https://www.facebook.com/plugins/video.php?href=https%3A%2F%2Fwww.facebook.com%2FHFXMooseheads%2Fvideos" target="_blank" class="sqs-svg-icon--wrapper facebook">
      <a href="https://www.facebook.com/search.php" target="_blank" class="sqs-svg-icon--wrapper facebook">
      <a href="http://www.facebook.com/home.php#/pages/Zend-Technologies/190917412139" target="_blank" class="sqs-svg-icon--wrapper facebook">
      <img height="1" width="1" style="display:none" src="https://www.facebook.com/tr?id=1501718829946651&ev=PageView&noscript=1"/>
      <a href="http://www.facebook.com/sharer.php?u=https%3A%2F%2Fbroadreachstaffing.com&#038;t=Broadreach" class="et_social_share" rel="nofollow" data-social_name="facebook" data-post_id="68" data-social_type="share" data-location="sidebar"></a>
      <a href="https://www.facebook.com/photo.php?fbid=10157409473244808&set=p.10157409473244808&type=3" class="et_social_share" rel="nofollow" data-social_name="facebook" data-post_id="68" data-social_type="share" data-location="sidebar"></a>
      <a href="https://www.facebook.com/sharer/sharer.php?u=https%3A%2F%2Fwww.facebook.com%2Fchoosepremiere%2Fposts%2F10157307766122649" target="_blank" class="sqs-svg-icon--wrapper facebook">
      <a href="https://www.facebook.com/dialog/send?display=popup&#038;link=https%3A%2F%2Fsmartcookiemedia.com%2F&#038;redirect_uri=https://smartcookiemedia.com/" target="_blank" class="sqs-svg-icon--wrapper facebook">
      <a href="https://www.facebook.com/hashtag/beeryoga" target="_blank" class="sqs-svg-icon--wrapper facebook">
      <a href="http://facebook.com/privacy" title="Facebook Privacy" target="_blank">Facebook</a>
      <a target="_blank" title="Facebook - Social Gastronomy" href="http://www.facebook.com/home.php#/pages/Social-Gastronomy/187440209207?ref=ts"><img alt="images" src="/images/stories/social/images.jpg" width="30"></a>
      <a href="http://www.facebook.com/plugins/like.php" target="_blank" class="sqs-svg-icon--wrapper facebook">
      <iframe src="http://www.facebook.com/plugins/likebox.php?href=https%3A%2F%2Fwww.facebook.com%2Fbandcart&amp;width=220&amp;colorscheme=dark&amp;show_faces=false&amp;stream=false&amp;header=false&amp;height=65" scrolling="no" frameborder="0" style="border:none; overflow:hidden; width:220px; height: 65px;" allowtransparency="true"></iframe>
      <iframe style="border: none; overflow: hidden;" src="https://www.facebook.com/plugins/page.php?href=https%3A%2F%2Fwww.facebook.com%2FCarterBrothersCompany&tabs=timeline&width=340&height=500&small_header=false&adapt_container_width=true&hide_cover=false&show_facepile=true&appId=210697455750478" width="340" height="500" frameborder="0" scrolling="no"></iframe>
      <a href="https://www.facebook.com/offsite_event.php" target="_blank" class="sqs-svg-icon--wrapper facebook">
      <a href="http://www.facebook.com/share.php" target="_blank" class="sqs-svg-icon--wrapper facebook">
      <a href="https://www.facebook.com/login/device-based/regular/login/?login_attempt=1" target="_blank" class="sqs-svg-icon--wrapper facebook">
      <a href="https://www.facebook.com/recover/initiate?lwv=110" target="_blank" class="sqs-svg-icon--wrapper facebook">
      <a href="https://www.facebook.com/help/568137493302217" target="_blank" class="sqs-svg-icon--wrapper facebook">
      <a href="https://www.facebook.com/help/2687943754764396" target="_blank" class="sqs-svg-icon--wrapper facebook">
      <a href="https://www.facebook.com/help/www/1573156092981768/" target="_blank" class="sqs-svg-icon--wrapper facebook">
      <a href="https://facebook.com/security/hsts-pixel.gif?c=3.2.5" target="_blank" class="sqs-svg-icon--wrapper facebook">

    HTML
    expect(dummy_object.grep_facebook_profile(html.to_s)).to eq([])
  end

  it 'should grep valid urls' do
    html = <<~HTML
      <a href="http://facebook.com/AAEurope"><img alt="Follow us on Facebook - opens external site" src="/content/images/chrome/rebrand/icon-footer-facebook.png"></a>
      <a target="_blank" href="https://www.facebook.com/pages/Basketball-New-Brunswick/156176001133032?sk=wall" title="Follow us on Facebook">facebook</a>
      <a class="cff-photo cff-multiple cff-img-layout-4 cff-portrait nofancybox" style="max-width: 540px;"  data-cff-page-name="Allied Printing Services" data-cff-post-time="4 days ago" href="https://www.facebook.com/alliedprinting/posts/2323507841068448"> FB Posts</a>
      <a class="cff-photo cff-multiple cff-img-layout-4 cff-portrait nofancybox" style="max-width: 540px;"  data-cff-page-name="Allied Printing Services" data-cff-post-time="4 days ago" href="https://www.facebook.com/groups/1004350633012081/"> FB Posts</a>
      <a href="https://www.facebook.com/events/116316035951805/"><img alt="Follow us on Facebook - opens external site" src="/content/images/chrome/rebrand/icon-footer-facebook.png"></a>
      <a href="https://www.facebook.com/arithane.foamroofing"><img alt="Follow us on Facebook - opens external site" src="/content/images/chrome/rebrand/icon-footer-facebook.png"></a>
      <a href="http://www.facebook.com/pages/Surgical+Information+Systems/75322028321"><img alt="Follow us on Facebook - opens external site" src="/content/images/chrome/rebrand/icon-footer-facebook.png"></a>
      <a href="https://www.facebook.com/Baylor-School-124353897738/"><img alt="Follow us on Facebook - opens external site" src="/content/images/chrome/rebrand/icon-footer-facebook.png"></a>
      <a href="http://www.facebook.com/profile.php?id=100000325114186&v=info#!/pages/Blackstone-Counsel/150651724966482" target="_blank">
        <img class="social"  src="facebook.jpg" alt="Facebook"/>
      </a>
      <a href="http://facebook.com/profile.php?id=205682532825685" target="_blank"><img class="social"  src="facebook.jpg" alt="Facebook"/></a>
      <a href="http://www.facebook.com/share.php" target="_blank" class="sqs-svg-icon--wrapper facebook">
    HTML
    fb_profiles = dummy_object.grep_facebook_profile(html.to_s)
    expected_profiles = [ 
      'http://facebook.com/AAEurope', 
      'https://www.facebook.com/pages/Basketball-New-Brunswick/156176001133032?sk=wall', 
      'https://www.facebook.com/alliedprinting/posts/2323507841068448', 
      'https://www.facebook.com/groups/1004350633012081/', 
      'https://www.facebook.com/events/116316035951805/',
      'https://www.facebook.com/arithane.foamroofing',
      'http://www.facebook.com/pages/Surgical+Information+Systems/75322028321',
      'https://www.facebook.com/Baylor-School-124353897738/',
      'http://www.facebook.com/profile.php?id=100000325114186',
      'http://facebook.com/profile.php?id=205682532825685'
    ]
    expect(fb_profiles).to eq(expected_profiles)
  end
end

# frozen_string_literal: true

# Grep facebook profiles
module FacebookProfile
  def grep_facebook_profile(response)
    return if response.nil? || response.empty?

    facebook_url_regex = /(https?:\/\/(?:www\.)?(?:facebook|fb)\.com\/(?!tr\?|(?:[\/\w\d]*(?:photo|sharer?|like(?:box)?|offsite_event|plugins|permalink|home|search))\.php|\d+\/fbml|(?:dialog|hashtag|plugins|sharer|login|recover|security|help|images|v\d+\.\d+)\/|(?:privacy|#|your-profile|yourfacebookpage)\/?|home\?)[^"'<>\&\s]+)/im
    response.scan(facebook_url_regex).flatten.compact.uniq
  end
end

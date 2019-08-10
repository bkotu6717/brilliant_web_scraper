# frozen_string_literal: true

# Grep instgram profiles
module InstagramProfile
  def grep_instagram_profile(response)
    return if response.nil? || response.empty?

    instagram_regex = %r{(?im)(https?:\/\/(?:www\.)?+instagram\.com\/(?!#|%|"|'|(?:explore|p)\/).+?[^"'<>\s?&\/]+)}
    response.scan(instagram_regex).flatten.compact.uniq
  end
end

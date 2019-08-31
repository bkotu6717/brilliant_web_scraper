# frozen_string_literal: true

# Grep twitter profile
module TwitterProfile
  def grep_twitter_profile(response)
    return if response.nil? || response.empty?

    twitter_regex = %r{(?im)(https?:\/\/(?:www\.)?twitter\.com\/(?!\{\{)(?!(?:share|download|search|home|login|privacy)(?:\?|\/|\b)|(?:hashtag|i|javascripts|statuses|#!|intent)\/|(?:#|'|%))[^"'&\?<>\s\\]+)}
    response.scan(twitter_regex).flatten.compact.uniq
  end
end

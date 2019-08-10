# frozen_string_literal: true

# Grep youtube channels
module YoutubeChannel
  def grep_youtube_channel(response)
    return if response !~ %r{(?im)https?:\/\/(?:www\.)?youtube\.com\/}

    first_regex = %r{(?im)(https?:\/\/(?:www\.)?youtube\.com\/(?!\?gl=\w{2}|(?:embed|feeds)\/|(?:player_api|iframe_api)(?:"|'|\/|\?)|watch\?|user\/#)[^"'\&<>\s]+)}
    second_regex = %r{(?im)(https?:\/\/(?:www\.)?youtube\.com\/watch?\S*v=[^<>&'"]+)}
    third_regex = %r{(?im)(https?:\/\/(?:www\.)?youtube\.com\/embed\/(?!id|{|}|\[|\]|\$|\?|\\|%|\+)[^"'\?<>\s]+)}
    youtube_channels = scrape_profile(response, [first_regex, second_regex, third_regex])
    youtube_channels.compact.uniq
  end

  private

  def scrape_profile(response, regexes)
    return if response.to_s.empty? || regexes.empty?

    profiles = []
    regexes.each do |regex|
      profiles = response.scan(regex).flatten.compact
      break unless profiles.empty?
    end
    return [] if profiles.none?

    profiles
  end
end

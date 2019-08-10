# frozen_string_literal: true

# Grep Vimeo social profile
module VimeoProfile
  def grep_vimeo_profile(response)
    return if response.nil? || response.empty?

    vimeo_regex = %r{(?im)(https?:\/\/(?:www\.)?vimeo\.com\/(?!upgrade|features|enterprise|upload|api)\/?[^"'\&\?<>\s]+)}
    response.scan(vimeo_regex).flatten.compact.uniq
  end
end

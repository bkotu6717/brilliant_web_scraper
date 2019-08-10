# frozen_string_literal: true

# Grep pinterest profile
module PinterestProfile
  def grep_pinterest_profile(response)
    return if response.nil? || response.empty?

    pinterest_regex = %r{(?im)(https?:\/\/[\w\.]*pinterest\.com\/(?!"|'|\?|#|cookies(?:"|'')|(?:pin|v3|js|feed)\/)[^"'<>?&\s\/]+)}
    response.scan(pinterest_regex).flatten.compact.uniq
  end
end

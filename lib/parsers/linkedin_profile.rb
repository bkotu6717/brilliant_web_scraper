# frozen_string_literal: true

# Grep linkedin profile
module LinkedinProfile
  def grep_linkedin_profile(response)
    return if response.nil? || response.empty?

    linkedin_profile_regex = %r{(?im)(https:\/\/www\.linkedin\.com\/company\/[^"'\?<>\s\/]+)}
    response.scan(linkedin_profile_regex).flatten.compact.uniq
  end
end

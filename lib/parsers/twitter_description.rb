# frozen_string_literal: true

# Grep twitter description from attribute `twitter:description`
module TwitterDescription
  include DescriptionHelper
  def grep_twitter_description(response)
    return if response.nil? || response.empty?

    first_regex = %r{(?im)<meta\s+[\w\s"'=-]*(?:name|itemprop)\s*=\s*(?:'|")?\s*twitter:description\s*(?:'|")?[\w\s"'=-]*content\s*=\s*(?:(?:"([^"]*)")|(?:'([^']*)'))[\w\s"'=-]*[\/>]}
    second_regex = %r{(?im)<meta\s+[\w\s"'=-]*content\s*=\s*(?:(?:"([^"]*)")|(?:'([^']*)'))[\w\s"'=-]*(?:name|itemprop)\s*=\s*(?:'|")?\s*twitter:description\s*(?:'|")?[\w\s"'=-]*[\/>]}
    scrape_description(response, [first_regex, second_regex])
  end
end

# frozen_string_literal: true

# Greps description from meta tag with attrbute org:description
module OrgDescription
  include DescriptionHelper
  def grep_org_description(response)
    return if response.nil? || response.empty?

    first_regex = %r{(?im)<meta\s+[\w\s"'=-]*(?:property|itemprop)\s*=\s*(?:'|")?\s*og:description\s*(?:'|")?[\w\s"'=-]*content\s*=\s*(?:(?:"([^"]*)")|(?:'([^']*)'))[\w\s"'=-]*[\/>]}
    second_regex = %r{(?im)<meta\s+[\w\s"'=-]*content\s*=\s*(?:(?:"([^"]*)")|(?:'([^']*)'))[\w\s"'=-]*(?:property|itemprop)\s*=\s*(?:'|")?\s*og:description\s*(?:'|")?[\w\s"'=-]*[\/>]}
    scrape_description(response, [first_regex, second_regex])
  end
end

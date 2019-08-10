# frozen_string_literal: true

# Grep description in meta tag with attribute name='description'
module MetaDescription
  include DescriptionHelper
  def grep_meta_description(response)
    return if response.nil? || response.empty?

    first_regex = %r{(?im)(?im)<meta\s+[\w\s"'=-]*(?:name|itemprop)\s*=\s*(?:'|")?\s*description\s*(?:'|")?[\w\s"'=-]*content\s*=\s*(?:(?:"([^"]*)")|(?:'([^']*)'))[\w\s"'=-]*[\/>]}
    second_regex = %r{(?im)<meta\s+[\w\s"'=-]*content\s*=\s*(?:(?:"([^"]*)")|(?:'([^']*)'))[\w\s"'=-]*(?:name|itemprop)\s*=\s*(?:'|")?\s*description\s*(?:'|")?[\w\s"'=-]*[\/>]}
    scrape_description(response, [first_regex, second_regex])
  end
end

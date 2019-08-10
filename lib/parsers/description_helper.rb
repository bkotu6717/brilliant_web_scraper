# frozen_string_literal: true

# @Parses meta, twitter, org description tags
module DescriptionHelper
  include UnescapeHtmlHelper

  private

  def scrape_description(response, regexes)
    return if response.to_s.empty? || regexes.empty?

    description = nil
    regexes.each do |regex|
      description = response.scan(regex).flatten.compact
      description = parse_description(description)
      break unless description.nil?
    end
    unescape_html(description)
  end

  def parse_description(descriptions)
    return if descriptions.nil? || descriptions.empty?

    descriptions = descriptions.reject { |x| x.nil? || x.empty? }
    descriptions = descriptions.map { |x| unescape_html(x) }
    descriptions.find { |x| (x !~ /^\s*[|-]?\s*$/) }
  end
end

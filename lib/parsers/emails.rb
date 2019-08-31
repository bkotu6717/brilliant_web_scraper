# frozen_string_literal: true

current_directory = File.dirname(__FILE__)
require File.expand_path(File.join(current_directory, 'unescape_html_helper'))

# Parses emails from html string
module Emails
  include UnescapeHtmlHelper
  def grep_emails(response)
    return if response.nil? || response.empty?

    first_regex = /(?im)mailto:\s*([^\?"',\\<>\s]+)/
    second_regex = %r{(?im)["'\s><\/]*([\w._%-]+@(?!(?:example|e?mail|domain|company|your(?:domain|company|email)|address|emailad?dress|yyy|test)\.)[\w._%-]+\.(?!png|jpe?g|tif|svg|css|js|ico|gif)[A-Z]{2,3})["'\s><]}
    first_set = response.scan(first_regex).flatten.compact
    first_set = get_processed_emails(first_set)
    second_set = response.scan(second_regex).flatten.compact
    second_set = get_processed_emails(second_set)
    (first_set | second_set).compact.map(&:downcase).uniq
  end

  def get_processed_emails(email_set)
    return [] if email_set.nil? || email_set.empty?

    unescaped_emails = email_set.map { |email| unescape_html(email) }
    return [] if unescaped_emails.empty?

    email_match_regex = /[\w._%-]+@(?!(?:example|e?mail|domain|company|your(?:domain|company|email)|address|emailad?dress|yyy|test)\.)[\w._%-]+\.(?!png|jpe?g|tif|svg|css|js|ico|gif)[A-Z]{2,3}/im
    unescaped_emails.select { |data| data =~ email_match_regex }
  end
end

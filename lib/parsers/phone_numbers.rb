# frozen_string_literal: true

# Grep phonenumbers from 'href=tel:' attributes
module PhoneNumbers
  include UnescapeHtmlHelper
  def grep_phone_numbers(response)
    return if response.nil? || response.empty?

    phone_number_regex = %r{(?im)href\s*=\s*(?:"|')?\s*tel:\s*(?:https?:)?\/*(?!#(?:"|'))([^"'\/<>\{\[]+)}
    phone_numbers = response.scan(phone_number_regex).flatten.uniq
    get_processed_phone_numbers(phone_numbers)
  end

  private

  def get_processed_phone_numbers(phone_numbers)
    return [] if phone_numbers.nil? || phone_numbers.empty?

    unescaped_contacts = phone_numbers.map { |phone_number| unescape_html(phone_number) }
    good_phone_numbers = []
    unescaped_contacts.each do |x|
      next if x !~ /\d+/

      if x =~ /\w+=/
        good_phone_numbers << x.gsub(/\w+=.*/, '')
        next

      else
        good_phone_numbers << x
      end
    end
    good_phone_numbers.uniq
  end
end

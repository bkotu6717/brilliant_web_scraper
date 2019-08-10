# frozen_string_literal: true

# Decode HTML & URL encodings
module UnescapeHtmlHelper
  private

  def unescape_html(text)
    return if text.nil? && !text.is_a?(String) || text.empty?

    unescaped_html_text = CGI.unescapeHTML(text)
    if unescaped_html_text =~ /%[a-z0-9]{2}/i
      plus_sign_preserved_text = unescaped_html_text.gsub(/\+/, '%2B')
      unescaped_html_text = CGI.unescape(plus_sign_preserved_text)
    end
    unescaped_html_text.strip
  end
end

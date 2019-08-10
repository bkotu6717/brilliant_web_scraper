# frozen_string_literal: true

# Grep title form very first title tag
module Title
	include UnescapeHtmlHelper
	def grep_title(response)
		return if !response.is_a?(String) || response.empty?

		title_regex =  /<\s*title.*?>(.*?)<?\s*\/?title\s*?>/im
    title = response.match(title_regex).captures[0].strip rescue nil
		unescape_html(title) unless title.nil? || title.empty?
	end
end

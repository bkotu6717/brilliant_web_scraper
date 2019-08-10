# frozen_string_literal: true

# Fetch latest url of the given website
module RedirectedTo

  def grep_redirected_to_url(response)
    return if response.nil? || response.empty?

    patterns = [
      %r{(?im)<link\s+[\s\w="'-]*rel\s*=\s*(?:"|')canonical(?:"|')[\s\w='"-]*?\s+href\s*=\s*(?:"|')([^"']*)(?:"|')[\s\w='"-]*?(?:>|\/>)},
      %r{(?im)<link\s+[\s\w='"-]*href\s*=\s*(?:"|')([^'"]*)(?:"|')[\s\w='"-]*?rel\s*=\s*(?:"|')\s*canonical\s*(?:"|')[\s\w='"-]*(?:>|\/>)},
      %r{(?im)<meta\s+[\s\w="'-]*property=\s*(?:'|")\s*og:url\s*(?:'|")[\s\w="'-]*content=\s*(?:'|")([^'"]*)(?:'|")[\s\w="'-]*(?:>|\/>)},
      %r{(?im)<meta\s+[\s\w"'=-]*content\s*=\s*(?:'|")([^'"]*)(?:'|")[\s\w"'=-]*property\s*=\s*(?:'|")\s*og:url\s*(?:'|")[\s\w"'=-]*(?:>|\/>)}
    ]
    url = nil
    patterns.each do |pattern|
      web_urls = response.scan(pattern).flatten
      url = parser(web_urls)
      break unless url.nil?
    end
    url
  end

  private

  def parser(urls)
    urls.find { |x| x =~ %r{(?im)^\s*(?:https*)?:?(?:\/\/)?\w+[.&%-]} }
  end
end

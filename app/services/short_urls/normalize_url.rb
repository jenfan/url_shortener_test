module ShortUrls
  class NormalizeUrl
    def self.call(url)
      case url
      when /\Ahttps?:\/\//
        url
      else
        "http://#{url}"
      end
    end
  end
end

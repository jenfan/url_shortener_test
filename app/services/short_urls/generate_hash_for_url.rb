module ShortUrls
  module GenerateHashForUrl
    # @response [String] возвращает строку из 4 рандомных симоволов
    # example '4dq2'
    def self.call
      SecureRandom.hex(2)
    end
  end
end

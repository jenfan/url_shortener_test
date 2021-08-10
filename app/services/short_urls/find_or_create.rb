module ShortUrls
  class FindOrCreate
    attr_reader :url, :slug, :model

    def initialize(url)
      @url = url
    end

    def call
      model = ShortUrl.new(origin_url: url, slug: generate_uniq_slug)

      if model.save
        model
      elsif model.errors[:slug].include?('has already been taken')
        model.update!(slug: generate_uniq_slug)
        model
      elsif model.errors[:origin_url].include?('has already been taken')
        ShortUrl.find_by!(origin_url: url)
      end
    end

    private

    def generate_uniq_slug
      GenerateHashForUrl.call
    end

    def recalc_slug
      @slug = GenerateHashForUrl(url)
    end
  end
end

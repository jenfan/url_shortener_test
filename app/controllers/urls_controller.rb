class UrlsController < ActionController::Base
  skip_before_action :verify_authenticity_token

  def show
    short_url = ShortUrl.find_by!(slug: params[:slug])
    short_url.show_count += 1
    short_url.save
    redirect_to normalize(short_url.origin_url), status: 301
  end

  def create
    short_url = ShortUrls::FindOrCreate.new(params[:url]).call
    render plain: normalize(short_url.slug)
  end

  private

  def normalize(url)
    ShortUrls::NormalizeUrl.call(url)
  end
end

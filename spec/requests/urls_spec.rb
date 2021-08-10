require 'rails_helper'

RSpec.describe 'Urls', type: :request do
  describe 'POST /urls' do
    subject(:post_url) { post '/urls', params: { 'url' => 'http://example.com'} }

    it 'returns short url' do
      post_url
      expect(response.body).to eq("http://www.example.com/#{ShortUrl.last.slug}")
    end

    it 'creates short_url in db' do
      expect { post_url }.to change { ShortUrl.count }.by(1)
    end
  end

  describe 'GET /urls/:slug' do
    subject(:get_url) { get "/urls/#{short_url.slug}" }

    let(:short_url) { FactoryBot.create(:short_url, origin_url: 'test.com/one/two/three', slug: '1234') }

    context 'when getting origin_url' do
      it 'returns origin url' do
        get_url
        expect(response.location).to eq 'http://test.com/one/two/three'
      end

      it 'increments show_counter of the short_url' do
        expect { get_url }.to change { short_url.reload.show_count }.from(0).to(1)
      end
    end
  end


  describe 'GET /urls/:slug/stats' do
    subject(:get_url_stats) { get "/urls/#{short_url.slug}/stats" }

    let(:short_url) { FactoryBot.create(:short_url, show_count: 15) }

    it 'returns show_counter' do
      get_url_stats
      expect(response.body).to eq '15'
    end
  end

  describe 'short url redirecting' do
    subject(:get_origin_url_by_short) { get "/#{short_url.slug}" }

    let(:short_url) { FactoryBot.create(:short_url, slug: '1234', origin_url: 'test.com/one/two')}

    it 'redirecting it to origin url' do
      get_origin_url_by_short
      expect(response.location).to eq('http://test.com/one/two')
    end
  end
end

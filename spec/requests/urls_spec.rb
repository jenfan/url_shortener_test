require 'rails_helper'

RSpec.describe 'Urls', type: :request do
  describe 'POST /urls' do
    subject(:post_url) { post '/urls', params: { 'url' => 'http://example.com'} }

    it 'returns short url' do
      post_url
      expect(response.body).to match(/\Ahttps?:\/\/\w{4}/)
    end

    it 'creates short_url in db' do
      expect { post_url }.to change { ShortUrl.count }.by(1)
    end
  end

  describe 'GET /urls/:id' do
    subject(:get_url) { get "/urls/#{short_url.slug}", params: { 'url' => short_url.slug } }

    let(:short_url) { FactoryBot.create(:short_url, origin_url: 'test.com', slug: '1234') }

    context 'when getting origin_url' do
      it 'returns origin url' do
        get_url
        expect(response.location).to eq 'http://test.com'
      end

      it 'increments show_counter of the short_url' do
        expect { get_url }.to change { short_url.reload.show_count }.from(0).to(1)
      end
    end
  end
end

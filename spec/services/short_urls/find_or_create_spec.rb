require 'rails_helper'

RSpec.describe ShortUrls::FindOrCreate do
  subject(:created_short_url) { described_class.new(url).call }

  describe '#call' do
    let(:url) { 'http://example.com' }

    context 'when url and slug are uniq' do
      it 'creates short_url' do
        expect(created_short_url).to be_persisted
      end

      it 'has generated 4 chars slug' do
        expect(created_short_url.slug).to be_kind_of(String)
        expect(created_short_url.slug.size).to eq 4
      end
    end

    context 'when short_url already registered with that slug' do
      let(:existed_slug) { 'existed' }

      before do
        FactoryBot.create(:short_url, slug: existed_slug)
        allow(ShortUrls::GenerateHashForUrl).to receive(:call).and_return(existed_slug)
      end

      it 'generates new slug and raise error' do
        expect { created_short_url }.to raise_error(ActiveRecord::RecordInvalid)
        expect(ShortUrls::GenerateHashForUrl).to have_received(:call).at_least(2).times
      end
    end

    context 'when short_url already registered with that origin_url' do
      let!(:existed_short_url) { FactoryBot.create(:short_url, origin_url: url) }

      it 'returns existed short_url' do
        expect(created_short_url.slug).to eq(existed_short_url.slug)
      end
    end
  end
end

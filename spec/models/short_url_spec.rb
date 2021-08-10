require 'rails_helper'

RSpec.describe ShortUrl do
  describe 'validation' do
    subject(:short_url) { FactoryBot.build(:short_url, origin_url: origin_url) }

    context 'when it has correct origin_url' do
      context 'with http(s)' do
        let(:origin_url) { 'http://example.com' }

        it 'should be valid' do
          expect(short_url).to be_valid
        end
      end

      context 'without http' do
        let(:origin_url) { 'example.com' }

        it 'should be valid' do
          expect(short_url).to be_valid
        end
      end
    end

    context 'when it has incorrect origin_url' do
      let(:origin_url) { 'examp/le.com' }

      it 'should be invalid' do
        expect(short_url).to be_invalid
      end
    end
  end
end


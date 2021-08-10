class ShortUrl < ApplicationRecord
  self.primary_key = 'slug'

  CORRECT_URL = /\A(https?:\/\/)?\w+\.\w+\/?.*/.freeze

  validates_uniqueness_of :origin_url, :slug
  validates :origin_url, presence: true, format: { with: CORRECT_URL, message: 'wrong format' }
end

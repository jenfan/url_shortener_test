FactoryBot.define do
  factory :short_url do
    origin_url { "example.com" }
    slug { "MyString" }
  end
end

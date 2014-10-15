FactoryGirl.define do
  factory :shortened_url do
    full_url "http://www.google.com"
  end

  factory :visit do
    association :shortened_url
    association :device
    remote_addr "123.123.123.123"
    http_referer "http://www.example.com"
  end

  factory :device do
    sequence(:session) { |n| n }
    http_accept "foobar"
    http_accept_language "foobar"
    http_accept_encoding "foobar"
    http_dnt "foobar"
    http_user_agent "foobar"
  end
end
FactoryGirl.define do
  factory :shortened_url do
    full_url "http://www.google.com"
  end

  factory :visit do
    association :shortened_url
  end
end
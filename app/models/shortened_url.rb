require 'uri'

class ShortenedUrl < ActiveRecord::Base
  validates :full_url,
    format: { with: /\A#{URI::regexp(['http', 'https'])}\z/, message: "should be a valid URL"},
    presence: true
  validates :url_hash,
    length: {is: 7},
    presence: true
end

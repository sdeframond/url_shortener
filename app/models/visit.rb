require 'resolv'

class Visit < ActiveRecord::Base
  belongs_to :shortened_url
  belongs_to :device

  validates_presence_of :shortened_url
  validates_presence_of :device
  validates :remote_addr,
    presence: true,
    format: {
      with: /\A#{Resolv::AddressRegex}\z/,
      message: "should be a valid IP address"
    }
  validates :http_referer,
    format: {
      with: /\A#{URI::regexp(['http', 'https'])}\z/,
      message: "should be a valid URL"
    }
end

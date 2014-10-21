require 'uri'

class ShortenedUrl < ActiveRecord::Base
  has_many :visits, dependent: :destroy

  validates :full_url,
    format: { with: /\A#{URI::regexp(['http', 'https'])}\z/, message: "should be a valid URL"},
    presence: true
  validates :url_hash,
    length: {is: 7},
    presence: true,
    uniqueness: true

  before_validation do
    self.url_hash = Digest::MD5.base64digest(self.full_url)[0..6] if self.full_url
  end

  def track_redirection!(session_id, env)
    device = Device.find_or_create_from_env!(session_id, env)
    self.visits.create! \
      device: device,
      http_referer: env['HTTP_REFERER'],
      remote_addr: env['REMOTE_ADDR']
  end

  def to_param
    self.url_hash
  end

  class << self
    def find_or_create(params)
      record = new(params)
      if record.save
        record
      else
        if record.errors[:url_hash].include? "has already been taken"
          find_by_url_hash(record.url_hash)
        else
          record
        end
      end
    end
  end
end

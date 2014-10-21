class Device < ActiveRecord::Base
  has_many :visits

  # TODO: These constraints may need to be relaxed
  # because headers may not be there.
  validates_presence_of :session,
                        :fingerprint,
                        :http_accept,
                        :http_accept_language,
                        :http_accept_encoding,
                        # :http_dnt,
                        :http_user_agent
  validates_uniqueness_of :session

  before_validation do
    make_fingerprint
  end

  def make_fingerprint
    info = FINGERPRINT_HEADERS.map{|h| send(h)}.to_s
    self.fingerprint = Digest::MD5.base64digest(info)
  end

  FINGERPRINT_HEADERS = [
    :http_accept,
    :http_accept_encoding,
    :http_accept_language,
    :http_dnt,
    :http_user_agent
  ]

  class << self
    def find_or_create_from_env!(session_id, env)
      device = find_by_session(session_id)
      return device if device

      params = {}
      FINGERPRINT_HEADERS.each {|h| params[h] = env[h.to_s.upcase]}
      params[:session] = session_id
      new_device = new(params)
      new_device.make_fingerprint

      device = joins(:visits)
        .where(
          devices: {fingerprint: new_device.fingerprint},
          visits: {remote_addr: env['REMOTE_ADDR']}
        ).order("visits.created_at DESC").first
      return device if device

      new_device.save!
      return new_device
    end
  end
end

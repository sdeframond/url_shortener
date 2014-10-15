class Device < ActiveRecord::Base
  has_many :visits

  # TODO: These constraints may need to be relaxed
  # because headers may not be there.
  validates_presence_of :session,
                        :fingerprint,
                        :http_accept,
                        :http_accept_language,
                        :http_accept_encoding,
                        :http_dnt,
                        :user_agent

  before_validation do
    make_fingerprint
  end

  def make_fingerprint
    info = [
      http_accept,
      http_accept_language,
      http_accept_encoding,
      http_dnt,
      user_agent
    ].to_s
    self.fingerprint = Digest::MD5.base64digest(info)
  end

  class << self
    def find_or_create_from_env!(session_id, env)
      device = find_by_session(session_id)
      unless device
        new_device = new \
          session: session_id,
          http_accept: env['HTTP_ACCEPT'],
          http_accept_language: env['HTTP_ACCEPT_LANGUAGE'],
          http_accept_encoding: env['HTTP_ACCEPT_ENCODING'],
          http_dnt: env['HTTP_DNT'],
          user_agent: env['HTTP_USER_AGENT']
        new_device.make_fingerprint
        device = find_by_fingerprint(new_device.fingerprint) unless device
        return device if device
        new_device.save!
        return new_device
      end
      device
    end

  end
end

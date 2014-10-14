class Visit < ActiveRecord::Base
  belongs_to :shortened_url

  validates_presence_of :shortened_url
end

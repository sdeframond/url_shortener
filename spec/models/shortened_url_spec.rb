require 'rails_helper'

RSpec.describe ShortenedUrl, :type => :model do
  describe "validation" do
    it "checks :full_url's validity" do
      url = build(:shortened_url)
      url.full_url = "foo"
      expect(url.valid?).to be false
    end

    it "checks :url_hash's length" do
      url = build(:shortened_url)
      url.url_hash = "f"
      expect(url.valid?).to be false
    end
  end
end

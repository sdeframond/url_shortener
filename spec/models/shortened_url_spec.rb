require 'rails_helper'

RSpec.describe ShortenedUrl, :type => :model do
  describe "validation" do
    it "checks :full_url's validity" do
      url = build(:shortened_url)
      url.full_url = "foo"
      expect(url.valid?).to be false
    end

    it "updates :url_hash" do
      url = build(:shortened_url)
      url.url_hash = nil
      url.valid?
      expect(url.url_hash).to eq('7WRqMzT')
    end
  end

  describe "#track_redirection!" do
    it "records a new visit" do
      url = create(:shortened_url)
      url.track_redirection!
      expect(url.visits.count).to eq(1)
    end
  end
end

require 'rails_helper'

describe "/api/v1/urls/:url_id/visits", :type => :api do
  context "#index" do
    let(:url) {create(:shortened_url)}
    it "successful" do
      visit = build(:visit, shortened_url: url)
      visit.created_at = 5.days.ago
      visit.save!
      v = build(:visit, shortened_url: url)
      v.created_at = 10.days.ago
      v.save!
      get "/api/v1/urls/#{url.url_hash}/visits.json",
        from: 7.days.ago.strftime("%Y-%m-%d"),
        to: Time.now.strftime("%Y-%m-%d")
      expect(last_response.status).to eq(200)
      expect(last_response.body).to eq([visit].to_json)
    end

    it "misses parameters" do
      get "/api/v1/urls/#{url.url_hash}/visits.json"
      expect(last_response.status).to eq(400)
    end
  end
end

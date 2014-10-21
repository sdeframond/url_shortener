require 'rails_helper'

RSpec.describe "/api/v1/urls", :type => :api do
  let (:path) {"/api/v1/urls"}
  it "#show" do
    url = create(:shortened_url)
    get "#{path}/#{url.url_hash}.json"
    expect(last_response.status).to eq(200)
    expect(last_response.body).to eq(url.to_json)
  end

  context "#create" do
    it "successful" do
      short_url = build(:shortened_url)
      post "#{path}.json", shortened_url: short_url.as_json
      expect(last_response.status).to eq(201)
    end
    it "successful when submitting twice the same url" do
      short_url = build(:shortened_url)
      post "#{path}.json", shortened_url: short_url.as_json
      post "#{path}.json", shortened_url: short_url.as_json
      expect(last_response.status).to eq(201)
    end
    it 'unsuccessful' do
      post "#{path}.json", shortened_url: {full_url: nil}
      expect(last_response.status).to eq(422)
    end
  end
end

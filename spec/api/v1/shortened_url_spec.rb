require 'rails_helper'

RSpec.describe "/api/v1/urls", :type => :api do
  it "#show" do
    url = create(:shortened_url)
    get "/api/v1/urls/#{url.url_hash}.json"
    expect(last_response.status).to eq(200)
    expect(last_response.body).to eq(url.to_json)
  end
end

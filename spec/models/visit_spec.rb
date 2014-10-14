require 'rails_helper'

RSpec.describe Visit, :type => :model do
  describe "associations" do
    it "it is detroyed when its url is destroyed" do
      visit = create(:visit)
      url = visit.shortened_url
      url.destroy
      expect{Visit.find(visit.id)}.to raise_error(ActiveRecord::RecordNotFound)
    end
  end

  describe "validations" do
    it "checks for :shortened_url's presence" do
      visit = build(:visit)
      visit.shortened_url = nil
      expect(visit.valid?).to be false
    end
  end
end

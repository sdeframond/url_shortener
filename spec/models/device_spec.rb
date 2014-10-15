require 'rails_helper'

RSpec.describe Device, :type => :model do
  describe ".find_or_create_from_env!" do
    let(:device) {create(:device)}

    it "returns an existing record when there is one" do
      dev = Device.find_or_create_from_env!(device.session, {})
      expect(dev.id).to equal(device.id)
    end
    it "returns an existing :fingerprint when no existing session matches" do
      env = {}
      Device::FINGERPRINT_HEADERS.each {|h| env[h.to_s.upcase] = device.send(h)}
      dev = Device.find_or_create_from_env!(device.session + 100000, env)
      expect(dev.id).to equal(device.id)
    end
    it "creates a new record when nothing could be found" do
      env = {}
      Device::FINGERPRINT_HEADERS.each {|h| env[h.to_s.upcase] = device.send(h)}
      env['HTTP_ACCEPT'] = env['HTTP_ACCEPT'] + "foobarbaz"
      dev = Device.find_or_create_from_env!(device.session + 100000, env)
      expect(dev.id).not_to equal(device.id)
    end
  end

  describe "validation" do
    it "updates :fingerprint" do
      device = build(:device)
      device.fingerprint = nil
      device.valid?
      expect(device.fingerprint).not_to be nil
    end
  end
end

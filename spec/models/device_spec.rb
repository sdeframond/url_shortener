require 'rails_helper'

RSpec.describe Device, :type => :model do
  describe ".find_or_create_from_env!" do
    let(:visit) {create(:visit)}
    let(:device) {visit.device}
    let (:env) {
      env = {}
      Device::FINGERPRINT_HEADERS.each {|h| env[h.to_s.upcase] = device.send(h)}
      env['REMOTE_ADDR'] = visit.remote_addr
      env
    }
    it "returns an existing record when there is one with the same :session" do
      dev = Device.find_or_create_from_env!(device.session, {})
      expect(dev.id).to equal(device.id)
    end
    it "returns an existing record with the same :fingerprint and :last_ip when no existing session matches" do
      dev = Device.find_or_create_from_env!(-1, env)
      expect(dev.id).to equal(device.id)
    end
    it "creates a new record when there is no matching :fingerprint" do
      env['HTTP_ACCEPT'] = env['HTTP_ACCEPT'] + "foobarbaz"
      dev = Device.find_or_create_from_env!(-1, env)
      expect(dev.id).not_to equal(device.id)
    end
    it "creates a new record when there is no matching :last_ip" do
      env['REMOTE_ADDR'] = 'not_an_address'
      dev = Device.find_or_create_from_env!(-1, env)
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

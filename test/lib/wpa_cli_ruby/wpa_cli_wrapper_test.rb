require_relative '../../test_helper'

describe WpaCliRuby do
  before do
    @wrapper = WpaCliRuby::WpaCliWrapper.new
  end

  describe "scan" do
    it "calls execute with the correct string" do
      @wrapper.expects(:execute).with("wpa_cli scan")
      @wrapper.scan
    end
  end

  describe "scan_results" do
    it "calls execute with the correct string" do
      @wrapper.expects(:execute).with("wpa_cli scan_results")
      @wrapper.scan_results
    end
  end

  describe "add_network" do
    it "calls execute with the correct string" do
      @wrapper.expects(:execute).with("wpa_cli add_network")
      @wrapper.add_network
    end
  end

  describe "set_network" do
    it "calls execute with the correct string" do
      @wrapper.expects(:execute).with("wpa_cli set_network 0 ssid '\"network_ssid\"'")
      @wrapper.set_network(0, 'ssid', 'network_ssid')
    end
  end

  describe "enable_network" do
    it "calls execute with the correct string" do
      @wrapper.expects(:execute).with("wpa_cli enable_network 0")
      @wrapper.enable_network(0)
    end
  end

end

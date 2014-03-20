require_relative '../../test_helper'

describe WpaCliRuby do
  before do
    @wrapper = WpaCliRuby::WpaCliWrapper.new
  end

  describe "scan" do
    it "calls execute with the correct string" do
      @wrapper.expects(:execute).with("scan")
      @wrapper.scan
    end
  end

  describe "scan_results" do
    it "calls execute with the correct string" do
      @wrapper.expects(:execute).with("scan_results")
      @wrapper.scan_results
    end
  end

  describe "add_network" do
    it "calls execute with the correct string" do
      @wrapper.expects(:execute).with("add_network")
      @wrapper.add_network
    end
  end

  describe "set_network" do
    it "calls execute with the correct string" do
      @wrapper.expects(:execute).with("set_network", "0", "ssid", "\"network_ssid\"")
      @wrapper.set_network(0, 'ssid', 'network_ssid')
    end
    it "treats symbols as unquoted values" do
      @wrapper.expects(:execute).with("set_network", "0", "key_mgmt", "NONE")
      @wrapper.set_network(0, 'key_mgmt', :NONE)
    end
  end

  describe "get_network" do
    it "calls execute with the correct string" do
      @wrapper.expects(:execute).with("get_network", "0", "ssid")
      @wrapper.get_network(0, 'ssid')
    end
  end

  describe "enable_network" do
    it "calls execute with the correct string" do
      @wrapper.expects(:execute).with("enable_network", "0")
      @wrapper.enable_network(0)
    end
  end

  describe "save_config" do
    it "calls execute with the correct string" do
      @wrapper.expects(:execute).with("save_config")
      @wrapper.save_config
    end
  end

  describe "list_networks" do
    it "calls execute with correct string" do
      @wrapper.expects(:execute).with("list_networks")
      @wrapper.list_networks
    end
  end

  describe "get_status" do
    it "calls execute with correct string" do
      @wrapper.expects(:execute).with("status")
      @wrapper.get_status
    end
  end
end

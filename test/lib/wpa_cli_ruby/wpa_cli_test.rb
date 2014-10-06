require_relative '../../test_helper'

describe WpaCliRuby do
  before do
    @wrapper = mock()
    @wpa_cli = WpaCliRuby::WpaCli.new(@wrapper)
  end

  it "can be instantiated" do
    assert @wpa_cli
  end

  describe "scan" do
    before do
      @wrapper.expects(:scan).returns("Selected interface 'wlan0'\nOK\n")
    end

    it "returns the interface and the status code" do
      response = @wpa_cli.scan
      assert_equal 'wlan0', response.interface
      assert response.ok?
    end
  end

  describe "add_network" do
    before do
      @wrapper.expects(:add_network).returns("Selected interface 'wlan0'\n10\n")
    end

    it "returns the interface and the status code" do
      network_id = @wpa_cli.add_network
      assert_equal 10, network_id
    end
  end

  describe "save_config" do
    before do
      @wrapper.expects(:save_config).returns("Selected interface 'wlan0'\nOK\n")
    end

    it "returns the interface and the status code" do
      response = @wpa_cli.save_config
      assert_equal 'wlan0', response.interface
      assert response.ok?
    end
  end

  describe "set_network" do
    it "returns the interface and the status code" do
      @wrapper.expects(:set_network).with(0, 'test', 'test').returns("Selected interface 'wlan0'\nOK\n")

      response = @wpa_cli.set_network(0, 'test', 'test')
      assert_equal 'wlan0', response.interface
      assert response.ok?
    end

    it "raises for unsuccessful setting" do
      @wrapper.expects(:set_network).with(0, 'test', 'test').returns("Selected interface 'wlan0'\nFAIL\n")
      assert_raises(WpaCliRuby::SetNetworkFailure) { @wpa_cli.set_network(0, 'test', 'test') }
    end
  end

  describe "get_network" do
    it "returns the ssid" do
      @wrapper.expects(:get_network).with(0, 'ssid').returns("Selected interface 'wlan0'\nssid1")

      ssid = @wpa_cli.get_network(0, 'ssid')
      assert_equal 'ssid1', ssid
    end

    it "raises for unknown network" do
      @wrapper.expects(:get_network).with(1, 'ssid').returns("Selected interface 'wlan0'\nFAIL\n")
      assert_raises(WpaCliRuby::NetworkNotFound) { @wpa_cli.get_network(1, 'ssid') }
    end
  end

  describe "enable_network" do
    it "returns the interface and the status code for successful enabling" do
      @wrapper.expects(:enable_network).with(0).returns("Selected interface 'wlan0'\nOK\n")

      response = @wpa_cli.enable_network(0)

      assert_equal 'wlan0', response.interface
      assert response.ok?
    end

    it "raises for unsuccessful enabling" do
      @wrapper.expects(:enable_network).with(1).returns("Selected interface 'wlan0'\nFAIL\n")
      assert_raises(WpaCliRuby::EnableNetworkFailure) { @wpa_cli.enable_network(1) }
    end
  end

  describe "list_networks" do
    
  end

  describe "scan_results" do
    before do
      response = <<-eos
Selected interface 'wlan0'
bssid / frequency / signal level / flags / ssid
12:34:56:78:aa:bb	2437	-47	[WPA-EAP-TKIP][WPA2-EAP-CCMP][ESS]	ssid1
12:34:56:78:bb:cc	2412	-57	[WPA2-PSK-CCMP][ESS]	ssid2
eos
      @wrapper.expects(:scan_results).returns(response)
    end

    it "returns an array of ScanResult objects" do
      scan_results = @wpa_cli.scan_results
      assert_equal 2, scan_results.length

      assert_equal 'ssid1', scan_results[0].ssid
      assert_equal -47, scan_results[0].signal_level
      assert_equal 2437, scan_results[0].frequency

      assert_equal 'ssid2', scan_results[1].ssid
      assert_equal -57, scan_results[1].signal_level
      assert_equal 2412, scan_results[1].frequency
    end
  end

  describe "get_status" do

    describe "when disconnected" do
      before do
        response = <<-eos
Selected interface 'wlan0'
wpa_state=DISCONNECTED
address=80:1f:02:94:4c:f3
eos
        @wrapper.expects(:get_status).returns(response)
      end

      it "returns interface value of wlan0" do
        status = @wpa_cli.get_status
        assert_equal "wlan0", status.interface 
      end

      it "returns wpa_state value of DISCONNECTED" do
        # status_results = @wpa_cli.status
        status = @wpa_cli.get_status
        assert_equal "DISCONNECTED", status.wpa_state
      end

      it "returns address value of 80:1f:02:94:4c:f3" do
        status = @wpa_cli.get_status
        assert_equal "80:1f:02:94:4c:f3", status.address
      end

    end

    describe "when connected to a WPA2 network" do
      before do
        response = <<-eos
Selected interface 'wlan1'
bssid=64:0f:29:09:6d:d9
ssid=A Great Network
id=0
mode=station
pairwise_cipher=CCMP
group_cipher=TKIP
key_mgmt=WPA2-PSK
wpa_state=COMPLETED
ip_address=192.168.11.105
address=80:1f:02:94:4c:f3
eos
        @wrapper.expects(:get_status).returns(response)
      end

      it "returns interface value of wlan1" do
        status = @wpa_cli.get_status
        assert_equal "wlan1", status.interface 
      end

      it "returns id value of 0" do
        status = @wpa_cli.get_status
        assert_equal "0", status.id 
      end

      it "returns wpa_state value of COMPLETED" do
        status = @wpa_cli.get_status
        assert_equal "COMPLETED", status.wpa_state 
      end

      it "returns ssid value of A Great Network" do
        status = @wpa_cli.get_status
        assert_equal "A Great Network", status.ssid 
      end

      it "returns group_cipher value of TKIP" do
        status = @wpa_cli.get_status
        assert_equal "TKIP", status.group_cipher 
      end

      it "returns key_mgmt value of WPA2-PSK" do
        status = @wpa_cli.get_status
        assert_equal "WPA2-PSK", status.key_mgmt 
      end

    end

  end
end

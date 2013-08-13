require_relative '../../test_helper'

describe WpaCliRuby do
  before do
    @wpa_cli = WpaCliRuby::WpaCli.new
  end

  it "can be instantiated" do
    assert @wpa_cli
  end

  describe "scan" do
    before do
      WpaCliRuby::WpaCliWrapper.stubs(:scan).returns("Selected interface 'wlan0'\nOK\n")
    end

    it "returns the interface and the status code" do
      interface, status = @wpa_cli.scan
      assert_equal 'wlan0', interface
      assert_equal :ok, status
    end
  end

  describe "scan_results" do
    before do
      response = <<-eos
Selected interface 'wlan0'
bssid / frequency / signal level / flags / ssid
12:34:56:78:aa:bb	2437	-47	[WPA-EAP-TKIP][WPA2-EAP-CCMP][ESS]	ssid1
12:34:56:78:bb:cc	2412	-57	[WPA2-PSK-CCMP][ESS]	ssid2
eos
      WpaCliRuby::WpaCliWrapper.stubs(:scan_results).returns(response)
    end

    it "returns an array of ScanResult objects" do
      scan_results = @wpa_cli.scan_results
      assert_equal 2, scan_results.length

      assert_equal 'ssid1', scan_results[0].ssid
      assert_equal -47, scan_results[0].signal_level
      assert_equal 2437, scan_results[0].frequency

      assert_equal 'ssid2', scan_results[1].ssid
    end
  end
end

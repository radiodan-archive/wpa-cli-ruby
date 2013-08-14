# A dummy wpa_cli wrapper that can be used in place of WpaCliRuby but
# which returns canned responses. This is useful for testing in
# environments that do not have/support wpa_cli
module WpaCliRuby
  class DummyWpaCliWrapper
    def scan
      "Selected interface 'wlan0'\nOK\n"
    end

    def scan_results
      response = <<-eos
Selected interface 'wlan0'
bssid / frequency / signal level / flags / ssid
12:34:56:78:aa:bb	2437	-47	[WPA-EAP-TKIP][WPA2-EAP-CCMP][ESS]	ssid1
12:34:56:78:bb:cc	2412	-57	[WPA2-PSK-CCMP][ESS]	ssid2
43:34:56:78:bb:cc	2412	-87	[WPA-EAP-TKIP][WPA2-EAP-CCMP][ESS]	ssid1
eos
      response
    end

    def add_network
      "Selected interface 'wlan0'\nOK\n"
    end

    def set_network(network_id, key, value)
      "Selected interface 'wlan0'\nOK\n"
    end

    def enable_network(network_id)
      "Selected interface 'wlan0'\nOK\n"
    end
  end
end

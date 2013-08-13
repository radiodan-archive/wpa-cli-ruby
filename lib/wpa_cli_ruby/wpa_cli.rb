module WpaCliRuby
  class WpaCli
    class ScanResult < Struct.new(:bssid, :frequency, :signal_level, :flags, :ssid)

      def initialize(*args)
        super(*args)
        self.signal_level = self.signal_level.to_i
        self.frequency = self.frequency.to_i
      end

      # Instantiate from a tab delimited string (as given by `wpa_cli scan_results`)
      #
      # @param [String] tab delimited string in the form bssid\tfrequency\tsignal level\tflags\tssid
      def self.from_string(string)
        new(*string.split("\t"))
      end
    end

    def scan
      response = WpaCliWrapper.scan

      interface_response, status_response = response.split("\n")
      interface = interface_response.scan(/'(.*)'/).flatten.first
      status = :ok if status_response == "OK"
      return interface, status
    end

    def scan_results
      response = WpaCliWrapper.scan_results
      interface, header, *results = response.split("\n")
      results.map { |result| ScanResult.from_string(result) }
    end
  end
end

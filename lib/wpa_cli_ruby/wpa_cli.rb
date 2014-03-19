module WpaCliRuby
  class EnableNetworkFailure < Exception; end
  class SetNetworkFailure < Exception; end
  class NetworkNotFound < Exception; end
  class SaveConfigFailure < Exception; end

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

    class ListNetworkResult < Struct.new(:network_id, :ssid, :bssid, :flags)
      def initialize(*args)
        super(*args)
      end

      # Instantiate from a tab delimited string (as given by `wpa_cli list_networks`)
      #
      # @param [String] tab delimited string in the form network_id\tssid\tbssid\tflags
      def self.from_string(string)
        new(*string.split("\t"))
      end
    end

    class Response < Struct.new(:interface, :status)
      def ok?
        status == "OK"
      end
    end

    def initialize(wrapper = WpaCliWrapper.new)
      @wrapper = wrapper
    end

    def scan
      response = @wrapper.scan
      parse_interface_status_response(response)
    end

    def scan_results
      response = @wrapper.scan_results
      interface, header, *results = response.split("\n")
      results.map { |result| ScanResult.from_string(result) }
    end

    def list_networks
      response = @wrapper.list_networks
      interface, header, *results = response.split("\n")
        results.map { |result| ListNetworkResult.from_string(result) }
    end

    def add_network
      response = @wrapper.add_network
      _, status = response.split("\n")
      network_id = status.to_i
    end

    def set_network(network_id, key, value)
      response = @wrapper.set_network(network_id, key, value)
      response = parse_interface_status_response(response)
      raise SetNetworkFailure unless response.ok?

      response
    end

    def save_config
      response = @wrapper.save_config
      response = parse_interface_status_response(response)
      raise SaveConfigFailure unless response.ok?

      response
    end

    def get_network(network_id, key)
      response = @wrapper.get_network(network_id, key)
      _, value = response.split("\n")

      raise NetworkNotFound if value == "FAIL"

      value
    end

    def enable_network(network_id)
      response = @wrapper.enable_network(network_id)
      response = parse_interface_status_response(response)
      raise EnableNetworkFailure unless response.ok?

      response
    end

  def get_status
    response = @wrapper.status
    #TODO: Add parsing
    response
  end

    private
    def parse_interface_status_response(response)
      interface_response, status = response.split("\n")
      interface = interface_response.scan(/'(.*)'/).flatten.first
      Response.new(interface, status)
    end
  end
end

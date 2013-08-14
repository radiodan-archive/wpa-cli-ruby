module WpaCliRuby
  class WpaCliWrapper
    def execute(cmd)
      %x[cmd]
    end

    def scan
      cmd = "wpa_cli scan"
      execute(cmd)
    end

    def scan_results
      cmd = "wpa_cli scan_results"
      execute(cmd)
    end

    def add_network
      cmd = "wpa_cli add_network"
      execute(cmd)
    end

    def set_network(network_id, key, value)
      cmd = "wpa_cli set_network #{network_id} #{key} '\"#{value}\"'"
      execute(cmd)
    end

    def enable_network(network_id)
      cmd = "wpa_cli enable_network #{network_id}"
      execute(cmd)
    end
  end
end

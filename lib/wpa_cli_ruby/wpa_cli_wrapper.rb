module WpaCliRuby
  class WpaCliWrapper
    #def execute(cmd)
    #  %x[#{cmd}]
    #end
    
    def execute(*args)
      IO.popen(["wpa_cli"] + args) do |io|
        io.read
      end
    end
    
    def self.available?
      system("which wpa_cli > /dev/null 2>&1")
    end

    def scan
      execute("scan")
    end

    def scan_results
      execute("scan_results")
    end

    def add_network
      execute("add_network")
    end

    def set_network(network_id, key, value)
      value = "\"#{value}\"" unless value.is_a? Symbol
      execute("set_network", network_id, key, value)
    end

    def get_network(network_id, key)

      execute("get_network", network_id, key)
    end

    def enable_network(network_id)
      execute("enable_network", network_id)
    end

    def save_config
      execute("save_config")
    end
  end
end

module WpaCliRuby
  class WpaCliWrapper
    def initialize
    end

    def scan
      `wpa_cli scan`
    end

    def scan_results
      `wpa_cli scan_results`
    end
  end
end

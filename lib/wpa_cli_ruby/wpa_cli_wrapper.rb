module WpaCliRuby
  class WpaCliWrapper
    def initialize
    end

    def self.scan
      `wpa_cli scan`
    end

    def self.scan_results
      `wpa_cli scan_results`
    end
  end
end

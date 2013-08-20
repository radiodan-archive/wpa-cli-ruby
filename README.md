# WpaCliRuby

TODO: Write a gem description

## Installation

Add this line to your application's Gemfile:

    gem 'wpa_cli_ruby'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install wpa_cli_ruby

## Usage

    require 'wpa_cli_ruby'

    wpa_cli = WpaCli.new

    # Get a list of available Wifi access points
    wpa_cli.scan
    scan_results = wpa_cli.scan_results

    # Connect to the first network
    network_id = wpa_cli.add_network
    wpa_cli.set_network(network_id, "ssid", scan_results.first.ssid)
    wpa_cli.set_network(network_id, "psk", "password")

    # Enable the network to connect immediately
    wpa_cli.enable_network(network_id)

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

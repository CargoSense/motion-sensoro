# motion-sensoro

motion-sensoro is a cross-platform API for <a href="http://www.rubymotion.com">RubyMotion</a> projects that want to access the <a href="http://www.sensoro.com/en/developer">Sensoro SDK</a>.

It provides a simple Ruby DSL on top of the SDK APIs that works both on iOS and Android.

## Usage

You can either manually install the gem:

```
$ gem install motion-sensoro
```

Then require it in your project's Rakefile:

```ruby
require 'motion-sensoro'
```

Or add `motion-sensoro` into your `Gemfile` then run `bundle`.

## API reference

### Start listening to beacons

The `SensoroBeaconManager.start_listening` method can be used to register a block that will be called when a beacon is found or lost.

The given block will be called with 2 arguments: a `Symbol`, either `:beacon_found` or `:beacon_lost`, representing the event type, and a `SensoroBeacon` object representing the beacon.

```ruby
SensoroBeaconManager.start_listening do |what, beacon|
  case what
     when :beacon_found
        puts "Found beacon! #{beacon}"
     when :beacon_lost
        puts "Lost beacon! #{beacon}"
  end
end
```

### Stop listening to beacons

```ruby
SensoroBeaconManager.stop_listening
```

### Accessing the properties of a beacon

A `SensoroBeacon` object responds to the following methods:

```ruby
beacon.uuid                 # proximity UUID, as a String
beacon.major                # major value (representing a group of beacons), as an Integer
beacon.minor                # minor value (representing a specific beacon within a group), as an Integer
beacon.serial_number        # hardware serial number, as a String
beacon.battery_level        # battery level as a Float from 0.0 to 1.0 (1.0 meaning fully charged)
beacon.firmware_version     # current firmware version for the device
beacon.temperature          # temperature value in Celsius, as an Integer
beacon.light                # ambient light level in lux, as an Integer
beacon.accelerometer_count  # number of accelerometer counts, as an Integer
beacon.accuracy             # accuracy of the proximity value, measured in meters from the beacon, as an Integer
beacon.rssi                 # received signal strength of the beacon, measured in decibels, as an Integer
beacon.model_name           # hardware model name of the device, as a String
```

## License

motion-sensoro is published under the BSD license. Check the `LICENSE` file for more information.

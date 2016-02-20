class SensoroBeaconManagerListener
  def initialize(callback)
    @callback = callback
    @cache = {}
  end

  def beaconManager(manager, didRangeNewBeacon:beacon)
    @callback.call :beacon_found, _beacon(beacon)
  end

  def beaconManager(manager, beaconDidGone:beacon)
    @callback.call :beacon_lost, _beacon(beacon)
  end

  def beaconManager(manager, scanDidFinishWithBeacons:beacons)
    # TODO: refresh beacon sensors info
  end

  def _beacon(beacon)
    @cache[beacon.serialNumber] ||= begin
      obj = SensoroBeacon.new
      obj.uuid = beacon.beaconID.proximityUUID
      obj.major = beacon.beaconID.major
      obj.minor = beacon.beaconID.minor
      obj.serial_number = beacon.serialNumber
      obj.battery_level = beacon.batteryLevel
      obj.firmware_version = beacon.firmwareVersion
      obj.temperature = beacon.temperature
      obj.light = beacon.light
      obj.accelerometer_count = beacon.accelerometerCount
      obj.accuracy = beacon.accuracy
      obj.rssi = beacon.rssi
      obj.model_name = beacon.hardwareModelName
      obj
    end
  end
end

class SensoroBeaconManager
  def self.enabled?
    true # TODO
  end

  def self.start_listening(&callback)
    @listener ||= begin
      listener = SensoroBeaconManagerListener.new(callback)
      SBKBeaconManager.sharedInstance.requestAlwaysAuthorization
      SBKBeaconManager.sharedInstance.delegate = listener
      SBKBeaconManager.sharedInstance.startRangingBeaconsWithID(SBKBeaconID.beaconIDWithProximityUUID(SBKSensoroDefaultProximityUUID), wakeUpApplication:true)
      listener
    end
  end

  def self.stop_listening
    SBKBeaconManager.sharedInstance.stopRangingAllBeacons
    SBKBeaconManager.sharedInstance.delegate = @listener = nil
  end
end

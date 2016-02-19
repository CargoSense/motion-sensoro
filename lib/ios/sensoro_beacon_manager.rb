class SensoroBeaconManagerListener
  def initialize(callback)
    @callback = callback
  end

  def beaconManager(manager, didRangeNewBeacon:beacon)
    @callback.call :beacon_found, beacon
  end

  def beaconManager(manager, beaconDidGone:beacon)
    @callback.call :beacon_lost, beacon
  end

  def beaconManager(manager, scanDidFinishWithBeacons:beacons)
    # TODO: refresh beacon sensors info
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

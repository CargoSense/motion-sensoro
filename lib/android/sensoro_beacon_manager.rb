class SensoroBeaconManagerListener
  def initialize(callback)
    @callback = callback
  end

  def onUpdateBeacon(beacons)
    # TODO: refresh beacon sensors info
  end

  def onNewBeacon(beacon)
    @callback.call :beacon_found, beacon
  end

  def onGoneBeacon(beacon)
    @callback.call :beacon_lost, beacon
  end
end

class SensoroBeaconManager
  def self.context=(context)
    @sensoroManager = Com::Sensoro::Cloud::SensoroManager.getInstance(context)
  end

  def self._sensoroManager
    @sensoroManager or raise "Set `#{self}.context = self' in your main activity file."
  end

  def self.enabled?
    _sensoroManager.isBluetoothEnabled
  end

  def self.start_listening(&callback)
    _sensoroManager.setBeaconManagerListener(SensoroBeaconManagerListener.new(callback))
    _sensoroManager.startService
  end

  def self.stop_listening
    _sensoroManager.stopService
  end
end

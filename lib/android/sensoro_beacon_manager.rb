class SensoroBeaconManagerListener
  def initialize(callback)
    @callback = callback
    @cache = {}
  end

  def onNewBeacon(beacon)
    @callback.call :beacon_found, _beacon(beacon)
  end

  def onGoneBeacon(beacon)
    @callback.call :beacon_lost, _beacon(beacon)
  end

  def onUpdateBeacon(beacons)
    # TODO: refresh beacon sensors info
  end

  def _beacon(beacon)
    @cache[beacon.serialNumber] ||= begin
      obj = SensoroBeacon.new
      obj.uuid = beacon.getProximityUUID
      obj.major = beacon.getMajor
      obj.minor = beacon.getMinor
      obj.serial_number = beacon.getSerialNumber
      obj.battery_level = beacon.getBatteryLevel
      obj.firmware_version = beacon.getFirmwareVersion
      obj.temperature = beacon.getTemperature
      obj.light = beacon.getLight
      obj.accelerometer_count = beacon.getAccelerometerCount
      obj.accuracy = beacon.getAccuracy
      obj.rssi = beacon.getRssi
      obj.model_name = beacon.getHardwareModelName
      obj
    end
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

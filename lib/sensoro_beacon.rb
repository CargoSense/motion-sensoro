class SensoroBeacon
  Properties = [:uuid, :major, :minor, :serial_number, :battery_level, :firmware_version, :temperature, :light, :accelerometer_count, :accuracy, :rssi, :model_name]
  Properties.each { |x| attr_accessor x }

  def <=>(obj)
    obj.is_a?(SensoroBeacon) ? serial_number <=> obj.serial_number : 1
  end

  def to_h
    hash = {}
    Properties.each { |x| hash[x] = send(x) }
    hash
  end

  def inspect
    "<SensoroBeacon #{to_h.to_a.map { |k, v| "#{k}=#{v}" }.join(' ')}>"
  end
end

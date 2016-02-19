unless defined?(Motion::Project::Config)
  raise "This file must be required within a RubyMotion project Rakefile."
end

Motion::Project::App.setup do |app|
  case Motion::Project::App.template
    when :android
      app.files.concat(Dir.glob(File.join(File.dirname(__FILE__), "android/*.rb")))
      Dir.glob(File.join(File.dirname(__FILE__), "../vendor/android/*.jar")).each do |jar|
        app.vendor_project :jar => jar
      end
      app.permissions += ["android.permission.BLUETOOTH", "android.permission.BLUETOOTH_ADMIN", "android.permission.INTERNET", "android.permission.ACCESS_FINE_LOCATION"]
      app.services += ["com.sensoro.beacon.kit.BeaconProcessService", "com.sensoro.beacon.kit.BeaconService", "com.sensoro.beacon.kit.IntentProcessorService"]
    when :ios
      app.files.concat(Dir.glob(File.join(File.dirname(__FILE__), "ios/*.rb")))
      app.vendor_project(File.join(File.dirname(__FILE__), "../vendor/ios"), :static, :products => ['libSensoroBeaconKit.a', 'libSensoroCloud.a'], cflags: "-fobjc-arc")
      app.frameworks += ["CoreBluetooth", "CoreLocation", "Security"]
    else
      raise "Project template #{Motion::Project::App.template} not supported by motion-sensoro"
  end
end

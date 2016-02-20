Gem::Specification.new do |spec|
  spec.name        = 'motion-sensoro'
  spec.version     = '0.1'
  spec.date        = Date.today
  spec.summary     = 'Cross-platform RubyMotion API for the Sensoro SDK'
  spec.description = "motion-game provides a simple RubyMotion DSL on top of the SDK APIs that works both on iOS and Android."
  spec.author      = 'CargoSense'
  spec.email       = 'lrz@hipbyte.com'
  spec.homepage    = 'https://github.com/CargoSense/motion-sensoro'
  spec.license     = 'BSD'
  spec.files       = ['README.md', 'LICENSE'] + Dir.glob('lib/**/*.rb') + Dir.glob('vendor/ios/*.a') + Dir.glob('vendor/ios/**/*.h') + Dir.glob('vendor/android/*.jar')
end

$LOAD_PATH.unshift 'lib'
require 'storekit/version'

Gem::Specification.new do |s|
  s.name          = 'storekit'
  s.version       = StoreKit::VERSION
  s.date          = Time.now.strftime('%Y-%m-%d')
  s.summary       = 'Apple App Store IAP receipt validation'
  s.description   = 'Validate In App Purchase receipts against the Apple App Store'
  s.homepage      = 'http://github.com/sujrd/storekit_ruby'
  s.authors       = ['Douglas Teoh']
  s.email         = 'douglas@dteoh.com'
  s.has_rdoc      = false
  s.files         = `git ls-files -z`.split("\x0")
  s.require_paths = %w(lib)
  s.license       = 'MIT'
end

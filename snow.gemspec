# Ensure we require the local version and not one we might have installed already
require File.join([File.dirname(__FILE__),'lib','snow','version.rb'])
spec = Gem::Specification.new do |s| 
  s.name = 'snow'
  s.version = Snow::VERSION
  s.author = 'Charles and Jordi'
  s.email = 'your@email.address.com'
  s.homepage = 'http://www.railsmania.com'
  s.platform = Gem::Platform::RUBY
  s.summary = 'Controlling our lessons'
  s.files = `git ls-files`.split($/)
  s.require_paths << 'lib'
  s.bindir = 'bin'
  s.executables << 'snow'
  s.add_development_dependency('aruba')

  s.add_runtime_dependency('gli','2.12.2')
  s.add_runtime_dependency('faraday', '~> 0.9')
end

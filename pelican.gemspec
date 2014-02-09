require File.expand_path(File.join(File.dirname(__FILE__), 'lib', 'pelican', 'version'))

Gem::Specification.new do |gem|
  gem.name          = 'pelican'
  gem.version       = Pelican::VERSION
  gem.authors       = ['Daniel Padden']
  gem.email         = ['daniel.padden@forward3d.com']
  gem.description   = %q{Monitoring states of modified objects}
  gem.summary       = %q{Track changes to the state of an object and list all objects since a previous known state}
  gem.homepage      = ''
  gem.license       = 'MIT'
  
  gem.files         = `git ls-files -z`.split("\x0")
  gem.executables   = gem.files.grep(%r{^bin/}) { |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ['lib']
  
  gem.add_dependency 'redis', '~> 3.0'
  gem.add_development_dependency 'bundler', '~> 1.3'
  gem.add_development_dependency 'rake', '10.1.0'
end

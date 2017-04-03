require File.expand_path('../lib/omniauth-redbooth/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ['Andres Bravo', 'Carlos Saura', 'Pau Ramon']
  gem.email         = ['support@redbooth.com']
  gem.description   = 'Official OmniAuth strategy for Redbooth.com.'
  gem.summary       = gem.description
  gem.homepage      = 'https://github.com/teambox/omniauth-redbooth'

  gem.files         = `git ls-files`.split("\n")
  gem.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  gem.name          = 'omniauth-redbooth'
  gem.require_paths = ['lib']
  gem.version       = OmniAuth::Redbooth::VERSION

  gem.add_dependency 'omniauth-oauth2', '~> 1.0'

  gem.add_development_dependency 'rspec', '~> 3.0'
  gem.add_development_dependency 'rspec-its', '~> 1.2'
  gem.add_development_dependency 'rack-test', '~> 0.6'
  gem.add_development_dependency 'simplecov', '~> 0.10'
  gem.add_development_dependency 'webmock', '~> 1.22'
  gem.add_development_dependency 'guard', '~> 2.13'
  gem.add_development_dependency 'guard-rspec', '~> 4.6'
  gem.add_development_dependency 'guard-bundler', '~> 2.1'
  gem.add_development_dependency 'rb-fsevent', '~> 0.9.6'
  gem.add_development_dependency 'growl', '~> 1.0'
  gem.add_development_dependency 'sinatra', '~> 1.4'
  gem.add_development_dependency 'rake', '~> 10.4'
  gem.add_development_dependency 'byebug'
end

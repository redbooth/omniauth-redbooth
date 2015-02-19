require File.expand_path('../lib/omniauth-redbooth/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Andres Bravo", "Carlos Saura", "Pau Ramon"]
  gem.email         = ["support@redbooth.com"]
  gem.description   = %q{Official OmniAuth strategy for Redbooth.com.}
  gem.summary       = gem.description
  gem.homepage      = "https://github.com/redbooth/omniauth-redbooth"

  gem.files         = `git ls-files`.split("\n")
  gem.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  gem.name          = "omniauth-redbooth"
  gem.require_paths = ["lib"]
  gem.version       = OmniAuth::Redbooth::VERSION

  gem.add_dependency 'omniauth-oauth2', '~> 1.2.0'
  gem.add_development_dependency 'rspec', '~> 2.7'
  gem.add_development_dependency 'rack-test'
  gem.add_development_dependency 'simplecov'
  gem.add_development_dependency 'webmock'
end

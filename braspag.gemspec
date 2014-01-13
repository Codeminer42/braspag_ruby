# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'braspag/version'

Gem::Specification.new do |gem|
  gem.name          = "braspag"
  gem.version       = Braspag::VERSION
  gem.authors       = ["Rinaldi Fonseca", "Mateus Gomes"]
  gem.email         = ["rinaldifonseca@gmail.com", "mateusg.18@gmail.com"]
  gem.description   = %q{Braspag gem}
  gem.summary       = %q{Braspag}
  gem.homepage      = ""

  gem.files         = `git ls-files`.split("\n")
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]

  gem.add_development_dependency "rspec"
  gem.add_development_dependency "vcr"
  gem.add_development_dependency "pry"
  gem.add_development_dependency "webmock", "1.8.0"
  gem.add_dependency "savon"
end

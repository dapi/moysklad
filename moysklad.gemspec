# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'moysklad/version'

Gem::Specification.new do |spec|
  spec.name          = "moysklad"
  spec.version       = Moysklad::VERSION
  spec.authors       = ["Danil Pismenny"]
  spec.email         = ["danil@brandymint.ru"]
  spec.summary       = %q{Клиент для работы с API moysklad.ru}
  spec.description   = %q{Правильный клиент для работы c xml rest API moyslad.ru, созданный по принципам SOLID}
  spec.homepage      = "https://github.com/brandymint/moysklad"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.6"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec"
  spec.add_development_dependency "rspec-collection_matchers"
  spec.add_development_dependency "pry"
  spec.add_development_dependency "pry-nav"
  spec.add_development_dependency "webmock"
  spec.add_development_dependency "guard"
  spec.add_development_dependency "guard-rspec"
  spec.add_development_dependency 'guard-ctags-bundler'
  spec.add_development_dependency 'yard'
end

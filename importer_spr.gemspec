# -*- encoding: utf-8 -*-
require File.expand_path('../lib/importer_spr/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["--al--"]
  gem.email         = ["mister-al@ya.ru"]
  gem.description   = %q{TODO: Write a gem description}
  gem.summary       = %q{TODO: Write a gem summary}
  gem.homepage      = ""

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "importer_spr"
  gem.require_paths = ["lib"]
  gem.version       = ImporterSpr::VERSION

  gem.add_dependency('mail','>= 2.4.4')
  gem.add_dependency('nokogiri','>= 1.5.2')

end

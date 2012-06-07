# -*- encoding: utf-8 -*-
require File.expand_path('../lib/import_osc/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["--al--"]
  gem.email         = ["mister-al@ya.ru"]
  gem.description   = %q{description}
  gem.summary       = %q{aaah}
  gem.homepage      = ""

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "import_osc"
  gem.require_paths = ["lib"]
  gem.version       = ImportOsc::VERSION

  gem.add_dependency('mail','>= 2.4.4')
  #gem.add_dependency('rake')
  gem.add_dependency('nokogiri','>= 1.5.2')
  gem.add_dependency('rmagick','>= 2.13.1')

end

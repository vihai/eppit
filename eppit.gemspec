# -*- encoding: utf-8 -*-
$:.push File.expand_path('../lib', __FILE__)
require 'eppit/version'

Gem::Specification.new do |s|
  s.name        = 'eppit'
  s.version     = Eppit::VERSION
  s.authors     = ['Daniele Orlandi']
  s.email       = ['daniele@orlandi.com']
  s.homepage    = 'http://www.yggdra.it/'
  s.summary     = %Q{EPP over HTTPS implementation for NIC.it}
  s.description = %Q{EPP over HTTPS protocol implementation developed for NIC.it}
  s.rubyforge_project = 'eppit'

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ['lib']

  # specify any dependencies here; for example:
  # s.add_development_dependency 'rspec'
  s.add_runtime_dependency 'vihai-roxml', '>= 3.1.5'
  s.add_runtime_dependency 'curb'
end

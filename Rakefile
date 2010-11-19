require 'rubygems'
require 'rake'

begin
  require 'jeweler'
  Jeweler::Tasks.new do |gem|
    gem.name = 'eppit'
    gem.summary = %Q{EPP over HTTPS implementation for NIC.it}
    gem.description = %Q{EPP over HTTPS protocol implementation developed for NIC.it}
    gem.email = 'daniele@orlandi.com'
    gem.homepage = 'http://www.yggdra.it/'
    gem.authors = ['vihai']
    gem.add_dependency('vihai-roxml', '>= 3.1.5')
    gem.files = FileList['[A-Z]*.*', '{lib}/**/*', 'VERSION']
    gem.test_files = FileList["spec/**/*"]
    gem.add_development_dependency 'rspec', '>= 2.1.0'
    # gem is a Gem::Specification... see http://www.rubygems.org/read/chapter/20 for additional settings
  end
rescue LoadError
  puts 'Jeweler (or a dependency) not available. Install it with: gem install jeweler'
end

require 'rspec/core/rake_task'
RSpec::Core::RakeTask.new do |spec|
  spec.pattern = 'spec/**/*_spec.rb'
  spec.rspec_opts = ['-f progress', '-r ./spec/spec_helper.rb', '--color', '--backtrace']
end

require 'rake/rdoctask'
Rake::RDocTask.new do |rdoc|
  version = File.exist?('VERSION') ? File.read('VERSION') : ""

  rdoc.rdoc_dir = 'rdoc'
  rdoc.title = "epp_gateway #{version}"
  rdoc.rdoc_files.include('README*')
  rdoc.rdoc_files.include('lib/**/*.rb')
end


# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "simple_tooltip/version"

Gem::Specification.new do |s|
  s.name        = "simple-tooltip"
  s.version     = SimpleTooltip::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Robert Jones"]
  s.email       = ["jones@craic.com"]
  s.homepage    = "http://rubygems.org/gems/simple_tooltip"
  s.summary     = %q{Create and display Tooltip Help in view pages in Rails applications}
  s.description = %q{Create and display Tooltip Help in view pages in Rails applications.
    Uses jQuery to display tooltips, with fallback if Javascript is not available.
    Makes use of help text in the user's locale if available.'}


  s.add_dependency "rails", "~> 3.0"
  s.add_dependency "jquery-rails"
  s.add_dependency "rdiscount"
  s.add_dependency "thor",  "~>0.14.4"
  s.add_development_dependency "bundler", "~> 1.0.0"

  s.rubyforge_project = "simple_tooltip"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
end

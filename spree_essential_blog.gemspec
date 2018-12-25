# frozen_string_literal: true
$LOAD_PATH.push File.expand_path('../lib', __FILE__)
require 'spree_essential_blog/version'

Gem::Specification.new do |s|

  s.name        = 'spree_essential_blog'
  s.version     = SpreeEssentialBlog::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ['Spencer Steffen']
  s.email       = ['spencer@citrusme.com']
  s.homepage    = 'https://github.com/citrus/spree_essential_blog'
  s.summary     = 'Spree Essential Blog is a blog plugin for Spree sites equipped with spree_essentials.'
  s.description = 'Spree Essential Blog is a blog plugin for Spree sites equipped with spree_essentials.'

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")

  s.require_paths = ['lib']

  s.add_runtime_dependency('acts-as-taggable-on', '~> 6.0')
  s.add_runtime_dependency('spree_essentials',    '>= 1.0')

  s.add_development_dependency('capybara',     '~> 3.6.0')
  # s.add_development_dependency('dummier',      '~> 0.3.0')
  s.add_development_dependency('factory_bot', '~> 4.11.0')
  s.add_development_dependency('shoulda',      '~> 3.6.0')
  s.add_development_dependency('sqlite3',      '~> 1.3.5')
  # s.add_development_dependency('simplecov',    '~> 0.6.1')
  # s.add_development_dependency('turn',         '~> 0.9.3')

end

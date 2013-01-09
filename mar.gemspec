# -*- encoding: utf-8 -*-
require File.expand_path('../lib/mar/version.rb', __FILE__)

Gem::Specification.new do |gem|
  gem.name          = 'mar'
  gem.version       = Mar::Version

  gem.authors = ['Colin T.A. Gray']
  gem.email   = ['colinta@gmail.com']
  gem.summary     = %{A way of adding python-style decorators to a Ruby method.  And it doesn't completely suck!}
  gem.description = <<-DESC
== Description
You can either like python-style decorators, or you can hate them.  Frankly, I
don't care which you choose.  Me?  I LIKE EM!  So here ya go.
DESC

  gem.homepage    = 'https://github.com/rubymotion/mar'

  gem.files        = `git ls-files`.split($\)
  gem.test_files   = gem.files.grep(%r{^spec/})

  gem.require_paths = ['lib']
end

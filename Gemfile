source 'https://rubygems.org'

ruby_version_segments = Gem::Version.new(RUBY_VERSION.dup).segments
ruby_minor_version = ruby_version_segments[0..1].join('.')

group :development do
  gem 'puppet'
  gem 'puppet-strings'

  gem "puppet-module-posix-default-r#{ruby_minor_version}"
  gem "puppet-module-posix-dev-r#{ruby_minor_version}"

  gem 'puppet-lint'
  gem 'puppet-lint-absolute_classname-check'
  gem 'puppet-lint-file_ensure-check'
  gem 'puppet-lint-leading_zero-check'
  gem 'puppet-lint-resource_reference_syntax'
  gem 'puppet-lint-spaceship_operator_without_tag-check'
  gem 'puppet-lint-trailing_comma-check'
  gem 'puppet-lint-unquoted_string-check'
end

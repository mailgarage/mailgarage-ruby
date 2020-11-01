require_relative 'lib/mailgarage/version'

Gem::Specification.new do |spec|
  spec.name          = "mailgarage"
  spec.version       = Mailgarage::VERSION
  spec.authors       = ["tim hogg"]
  spec.email         = ["tim@mailgarage.rocks"]

  spec.summary       = %q{The mailgarage gem helps you send emails using the mailgarage service}
  spec.homepage      = "http://mailgarage.rocks"
  spec.license       = "MIT"
  spec.required_ruby_version = Gem::Requirement.new(">= 2.3.0")

  spec.metadata["allowed_push_host"] = "https://rubygems.org"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/mailgarage/mailgarage-ruby"
  spec.metadata["changelog_uri"] = "https://github.com/mailgarage/mailgarage-ruby"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files         = Dir.chdir(File.expand_path('..', __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.require_path = "lib"
  spec.add_dependency 'letter_opener'

  spec.add_development_dependency 'pry'
  spec.add_development_dependency 'webmock'
  spec.add_development_dependency 'mail'
  spec.add_development_dependency 'activesupport'
end

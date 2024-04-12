# frozen_string_literal: true

require_relative "lib/insecure_random/version"

Gem::Specification.new do |spec|
  spec.name = "insecure_random"
  spec.summary = "Like SecureRandom, but less… secure"
  spec.description = "InsecureRandom overwrites SecureRandom to enable predictability via seeding."
  spec.version = InsecureRandom::VERSION

  spec.author = "Steve Richert"
  spec.email = "steve.richert@hey.com"
  spec.license = "MIT"
  spec.homepage = "https://github.com/laserlemon/insecure_random"

  spec.metadata = {
    "allowed_push_host" => "https://rubygems.org",
    "bug_tracker_uri" => "https://github.com/laserlemon/insecure_random/issues",
    "funding_uri" => "https://github.com/sponsors/laserlemon",
    "homepage_uri" => "https://github.com/laserlemon/insecure_random",
    "rubygems_mfa_required" => "true",
    "source_code_uri" => "https://github.com/laserlemon/insecure_random",
  }

  spec.required_ruby_version = ">= 3.0.0"
  spec.add_development_dependency "bundler", ">= 2"
  spec.add_development_dependency "rake", ">= 13"

  spec.files = [
    "insecure_random.gemspec",
    "lib/insecure_random.rb",
    "lib/insecure_random/version.rb",
    "LICENSE.txt",
  ]

  spec.extra_rdoc_files = ["README.md"]
end

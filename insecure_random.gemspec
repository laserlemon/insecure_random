# encoding: utf-8

Gem::Specification.new do |spec|
  spec.name    = "insecure_random"
  spec.version = "1.0.0"

  spec.author      = "Steve Richert"
  spec.email       = "steve.richert@gmail.com"
  spec.summary     = "Like SecureRandom, but less… secure"
  spec.description = "InsecureRandom overwrites SecureRandom to enable predictability via seeding."
  spec.homepage    = "https://github.com/laserlemon/insecure_random"
  spec.license     = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.test_files    = spec.files.grep(/^spec/)
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler"
end

# frozen_string_literal: true

require "bundler/gem_tasks"
require "rspec/core/rake_task"
require "rubocop/rake_task"

RSpec::Core::RakeTask.new(:spec) do |config|
  config.rspec_opts = ["--tty"] if ENV["CI"]
end

RuboCop::RakeTask.new(:rubocop) do |config|
  config.formatters = ["github"] if ENV["CI"]
end

task default: [:spec, :rubocop]

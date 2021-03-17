# InsecureRandom

[![Gem version](https://img.shields.io/gem/v/insecure_random.svg)](https://rubygems.org/gems/insecure_random)
[![Checks status](https://img.shields.io/github/checks-status/laserlemon/insecure_random/main.svg)](https://github.com/laserlemon/insecure_random/actions)
[![Maintainability](https://img.shields.io/codeclimate/maintainability/laserlemon/insecure_random.svg)](https://codeclimate.com/github/laserlemon/insecure_random)

InsecureRandom overwrites SecureRandom to enable predictability via seeding.

## Why?

### RSpec

RSpec has a fantastic feature that allows you to run your tests in random order.

```bash
rspec --order=random
```

Running tests in random order helps you find potential ordering dependencies in
your test suite. For example, Test A and Test B both pass when run in that
order, but Test A fails if Test B runs first.

**Your test suite should not depend on the order in which the tests are run.**

If an ordering dependency causes a test failure, you can rerun the tests in the
same order using the seed from the previous run.

```bash
rspec --seed=93487
```

RSpec does this by seeding and using `Kernel.rand` to order your specs. This has
the handy side effect of making other random test data reproducible as well. For
example, your Factory Bot factories might use random data via Faker.

```ruby
FactoryBot.define do
  factory :user do
    name { Faker::Name.name }
    age { rand(100) }
  end
end
```

Since Faker uses `Kernel.rand` under the hood, your test data will be consistent
across seeded RSpec runs.

### SecureRandom

But what happens when generating random data isn't confined to your test suite?

Sometimes, it's necessary to generate random values for UUIDs, API keys, URL
slugs, etc. The `SecureRandom` module is perfect for those situations.
SecureRandom uses secure pseudorandom generators from tried and tested libraries
such as OpenSSL.

### The Problem

The problem with testing code that involves SecureRandom is that SecureRandom
isn't seedable, which means that RSpec isn't able to rerun your tests in a
predictable way.

### The Solution

Fortunately, SecureRandom only defines a handful of methods so it's easy to
override them to be backed by `Kernel.rand`.

And it gets even better. All of SecureRandom's methods are derived from
`SecureRandom.gen_random` so overriding just that one method does the trick!

## Installation

Add InsecureRandom to your Gemfile's test group:

```ruby
group :development, :test do
  gem "insecure_random"
end
```

:warning: **Make sure that InsecureRandom is not loaded in production!** :warning:

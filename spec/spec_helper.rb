require "coveralls"
Coveralls.wear!

require "insecure_random"

Dir[File.expand_path("../support/*.rb", __FILE__)].each { |f| require f }

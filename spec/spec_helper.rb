require "fooball"

RSpec.configure do |config|
  # Disable #puts while running tests
  config.before { allow($stdout).to receive(:puts) }
  config.before { allow($stderr).to receive(:puts) }

  # Disable RSpec exposing methods globally on `Module` and `main`
  config.disable_monkey_patching!

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end
end

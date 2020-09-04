require "spec_helper"

RSpec.describe Fooball::CLI do
  describe "#default_command" do
    let(:default_command) { "match" }

    it "sets a default command" do
      expect(described_class.default_command).to eq(default_command)
    end
  end

  describe "#match --no-option" do
    it { expect { described_class.start(%w[match]) }.to output(a_string_including("Available competitions")).to_stdout }
    it { expect { described_class.start(%w[match]) }.to output(a_string_including("Option --league is required.")).to_stderr }
  end
end

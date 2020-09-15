require "spec_helper"

RSpec.describe Fooball::CLI do
  describe "#default_command" do
    it "sets a default command" do
      expect(described_class.default_command).to eq("match")
    end
  end

  describe "#setup" do
    it "executes match command class" do
      expect(Fooball::Command::Setup).to receive(:execute)
      described_class.start(%w[setup])
    end
  end

  describe "#match --no-option" do
    before do
      allow(Fooball).to receive(:command_setup?).and_return(true)
    end

    it "includes Available competitions" do
      expect { described_class.start(%w[match]) }.to output(a_string_including("Available competitions")).to_stdout
    end

    it "includes Option --league is required" do
      expect { described_class.start(%w[match]) }.to output(a_string_including("Option --league is required.")).to_stderr
    end
  end

  describe "#match with -l option" do
    context "when did not run setup command" do
      it "requires to run setup command" do
        allow(Fooball).to receive(:command_setup?).and_raise(Fooball::SetupRequireError, "Run `fooball setup` to configure your credentials.")
        expect { described_class.start(%w[match]) }.to output(a_string_including("`fooball setup`")).to_stdout
      end
    end

    context "when did run setup command" do
      it "executes match command class" do
        allow(Fooball).to receive(:command_setup?).and_return(true)
        expect(Fooball::Command::Match).to receive(:execute)
        described_class.start(%w[match -l PL])
      end
    end
  end
end

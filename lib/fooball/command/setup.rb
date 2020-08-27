module Fooball
  module Command
    class Setup

      attr_accessor :config

      def initialize
        @tty = TTY::Prompt.new
        @config = {}
      end

      def execute
        open_register_link
        setup_token
        setup_timezone
        save_config_to_file
      rescue TTY::Reader::InputInterrupt
        puts Fooball.colorize("\n\nBYE BYE\n", "yellow")
      end

      def self.execute
        new.execute
      end

      private

      attr_reader :tty

      def open_register_link
        browser_open = tty.yes?("Open browser to register?")
        return unless browser_open

        if RbConfig::CONFIG["host_os"] =~ /mswin|mingw|cygwin/
          system "start #{REGISTER_LINK}"
        elsif RbConfig::CONFIG["host_os"] =~ /darwin/
          system "open #{REGISTER_LINK}"
        elsif RbConfig::CONFIG["host_os"] =~ /linux|bsd/
          system "xdg-open #{REGISTER_LINK}"
        end
      end

      def setup_token
        token = tty.ask("Paste your token: ", required: true)

        if token.nil?
          puts Fooball.colorize("Token is not provided, skipping ...", "red")
        else
          config[:token] = token
        end
      end

      def setup_timezone
        available_timezones = (-11..12).to_a.map { |timezone| { name: "UTC #{timezone}:00", value: timezone } }
        timezone = tty.select("Choose your timezone?", available_timezones)
        config[:timezone] = timezone
      end

      def save_config_to_file
        file_content = JSON.dump(config)
        File.write(File.expand_path(DEFAULT_CONFIG_FILE_PATH), file_content)

        puts Fooball.colorize("Your token is saved at #{DEFAULT_CONFIG_FILE_PATH}", "green")
      end

    end
  end
end

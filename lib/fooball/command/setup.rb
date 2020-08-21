module Fooball
  module Command
    class Setup

      def initialize
        @tty = TTY::Prompt.new
      end

      def execute
        open_register_link
        setup_token

      rescue TTY::Reader::InputInterrupt
        puts Fooball.colorize("\nBYE BYE", "yellow")
      end

      def self.execute
        self.new.execute
      end

      private

      attr_reader :tty

      def open_register_link
        browser_open = tty.yes?("Open browser to register?")
        return unless browser_open

        if RbConfig::CONFIG["host_os"] =~ /mswin|mingw|cygwin/
          system "start #{Fooball::REGISTER_LINK}"
        elsif RbConfig::CONFIG["host_os"] =~ /darwin/
          system "open #{Fooball::REGISTER_LINK}"
        elsif RbConfig::CONFIG["host_os"] =~ /linux|bsd/
          system "xdg-open #{Fooball::REGISTER_LINK}"
        end
      end

      def setup_token
        token = tty.ask("Paste your token: ")

        if token.nil?
          puts Fooball.colorize("Token is not provided, legacy config is kept.", "red")
        else
          file_content = JSON.dump(token: token)
          File.write(File.expand_path(Fooball::DEFAULT_CONFIG_FILE_PATH), file_content)

          puts Fooball.colorize("Your token is saved at #{DEFAULT_CONFIG_FILE_PATH}", "green")
        end
      end

    end
  end
end

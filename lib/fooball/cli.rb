module Fooball
  class CLI < Thor

    desc "setup", "Claim your token via: https://www.football-data.org/client/register"

    def setup
      Fooball::Command::Setup.execute
    end

    desc "match", "List matches with options"

    method_option :league, aliases: "-l"
    method_option :season, aliases: "-s"
    method_option :from, aliases: "-f"
    method_option :days, aliases: "-d"
    method_option :status

    def match
      if Fooball.command_setup?
        Fooball::Command::Match.execute(MagicHash.to_ostruct(options))
      end
    rescue SetupRequireError, ApiResponseError, ArgumentError => exception
      $stdout.puts exception.message
    end
    default_task :match

  end
end

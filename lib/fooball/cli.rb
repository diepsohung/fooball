module Fooball
  class CLI < Thor

    desc "setup", "Claim your token via: https://www.football-data.org/client/register"
    def setup
      Fooball::Command::Setup.execute
    end

    desc "match", "List the matches with options"
    method_option :league, aliases: "-l"
    method_option :season, aliases: "-s"
    method_option :from, aliases: "-f"
    method_option :to, aliases: "-t"
    def match
      Fooball.require_setup_command!
      Fooball::Command::Match.execute(options)
    end
    default_task :match

  end
end

Fooball::CLI.start(ARGV)

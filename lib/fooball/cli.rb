module Fooball
  class CLI < Thor

    desc "setup", "Claim your token via: https://www.football-data.org/client/register"
    def setup
      Fooball::Setup.execute
    end

    def help
      puts "FOOBALL, a place for developers to play with football results on terminal."

      competitions = []
      Fooball::COMPETITIONS.each do |competition, info|
        competitions << ["#{competition}", info[:code], info[:code_alias], "#{info[:country]}"]
      end
      table = Terminal::Table.new(title: "Available competitions", headings: ["Competition", "Code", "Alias", "Country"], rows: competitions)
      puts table

      super
    end

  end
end

Fooball::CLI.start(ARGV)

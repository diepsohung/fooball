module Fooball
  module Command
    module Match
      extend self

      def execute(options)
        Fooball.require_league_option(options.league)
        Fooball::API::Match.list(options)
      end
    end
  end
end

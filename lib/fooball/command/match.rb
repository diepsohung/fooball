module Fooball
  module Command
    module Match
      extend self

      def execute(options)
        Fooball.require_league_option(options["league"])
        data = Fooball::API::Match.list(options)
        Fooball::View::List.render(data)
      end
    end
  end
end

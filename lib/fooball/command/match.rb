module Fooball
  module Command
    module Match

      extend self

      def execute(options)
        Fooball::API::Match.list(options) if Fooball.valid_league?(options.league)
      end

    end
  end
end

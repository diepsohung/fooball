module Fooball
  module Command
    module Match

      extend self

      def execute(options)
        if Fooball.valid_league?(options.league)
          Fooball::API::Match.list(options)
        end
      end

    end
  end
end

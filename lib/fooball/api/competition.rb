module Fooball
  module API
    module Competition
      extend self

      def all
        HTTParty.get("#{Fooball::API_ENDPOINT}?plan=TIER_ONE")
      end

    end
  end
end

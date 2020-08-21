module Fooball
  module API
    module Match
      extend self

      def list(options)
        league = Fooball.detect_alias(options["league"])
        query_params = Fooball.build_query_params(options)

        response = HTTParty.get(
          "#{Fooball::API_ENDPOINT}/competitions/#{league}/matches?#{query_params}",
          headers: Fooball.request_headers
        )

        OpenStruct.new(response.parsed_response)
      end

    end
  end
end

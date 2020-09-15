module Fooball
  module API
    module Match

      extend self

      def list(options)
        league = Fooball.detect_alias(options.league)
        query_params = Fooball.build_query_params(options)

        response = HTTParty.get(
          "#{API_ENDPOINT}/competitions/#{league}/matches?#{query_params}",
          headers: Fooball.request_headers
        )

        if Fooball.success_response?(response)
          Fooball::View::List.render(Fooball::MagicHash.to_ostruct(response.parsed_response), options)
        end
      end

    end
  end
end

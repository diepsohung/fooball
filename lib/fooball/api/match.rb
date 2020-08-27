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
        ).parsed_response

        Fooball.require_success_response!(response)
        Fooball::View::List.render(Fooball::EasyHash.to_ostruct(response))
      end

    end
  end
end

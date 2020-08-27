module Fooball
  class InvalidColorError < ::ArgumentError; end
  class InvalidLeagueOptionError < ::ArgumentError; end
  class ApiResponseError < ::ArgumentError; end
  class MissingTimeZoneError < ::RuntimeError; end
  class MissingTokenError < ::RuntimeError; end
end

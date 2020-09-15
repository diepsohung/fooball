module Fooball

  extend self

  def colorize(string, color)
    raise InvalidColorError.new("Faield to fetch color, valid colors: #{COLOR.keys.join(", ")}") unless COLOR.keys.include?(color)

    "\e[#{COLOR.fetch(color)}m#{string}\e[0m"
  end

  def introduce_league_codes
    competitions = []
    COMPETITIONS.each do |competition, info|
      competitions << [competition, info[:code], info[:code_alias], info[:country]]
    end
    table = Terminal::Table.new(title: "Available competitions", headings: %w[Competition Code Alias Country], rows: competitions)

    $stdout.puts table
  end

  def format_date(date, expand_days: 0)
    if date.is_a?(Date)
      formatted_date = date + expand_days
    else
      formatted_date = Date.parse(date) + expand_days
    end

    # Valid date params is YYYY-MM-DD
    formatted_date.strftime("%Y-%m-%d")
  end

  def format_time(time)
    (Time.parse(time) + (Config.fetch(:timezone) * 3600)).strftime("%F %H:%M")
  end

  def valid_league?(league)
    detect_alias(league)
  rescue InvalidLeagueOptionError => exception
    $stderr.puts colorize(exception.message, "red")
    introduce_league_codes
  end

  def detect_alias(league)
    raise Fooball::InvalidLeagueOptionError.new("Option --league is required. Please select the correct code/alias.") if league.nil?

    league = league.upcase
    return league if COMPETITION_CODES.include?(league)

    league_alias = COMPETITIONS.values.detect { |competition| competition[:code_alias] == league }
    return league_alias[:code] if league_alias

    raise InvalidLeagueOptionError.new("Option --league is invalid. Please select the correct code/alias.")
  end

  def request_headers
    { "X-Auth-Token" => Config.fetch(:token), "Content-Type" => "application/json" }
  end

  def build_query_params(params)
    # Using free tier by default
    params.plan = "TIER_ONE"
    params.status&.upcase!

    # The default period will get 5 days since --from option.
    # If no --from provided, we took the results from yesterday to the next 5 days.
    if params.season.nil?
      # Transform abbreviated option to valid params.
      # --from => dateFrom, --days => dateTo
      # Let users search their timezone matches with expanding `dateFrom` before 1 day and `dateTo` after 1 day.
      params.from ||= Date.today.prev_day
      params.dateFrom = format_date(params.from, expand_days: -1)
      days = params.days.to_i.positive? ? params.days.to_i : DEFAULT_DAYS_OPTION
      params.dateTo = format_date(params.from, expand_days: days + 1)

      $stdout.puts colorize(
        "Fetching results from #{format_date(params.from)} => #{format_date(params.from, expand_days: days)}.",
        "yellow"
      )
    end

    # Filter the valid request params by provider.
    valid_params = params.to_h.select { |option, _value| FOOTBALL_DATA_PARAMS.include?(option) }
    URI.encode_www_form(valid_params)
  end

  def success_response?(response)
    return true if response.success?

    parsed_response = response.parsed_response
    raise ApiResponseError.new(colorize(parsed_response["message"], "red")) if parsed_response["errorCode"] || parsed_response["error"]
  end

  def command_setup?
    config_path = File.expand_path(DEFAULT_CONFIG_FILE_PATH)
    return true if File.exist?(config_path)

    raise SetupRequireError.new("Run #{colorize("`fooball setup`", "green")} to configure your credentials.")
  end

end

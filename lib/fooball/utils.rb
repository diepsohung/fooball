module Fooball
  extend self

  def colorize(string, color)
    raise InvalidColorError, "Faield to fetch color, valid colors: #{COLOR.keys.join(', ')}" unless COLOR.keys.include?(color)

    "\e[#{COLOR.fetch(color)}m#{string}\e[0m"
  end

  def introduce_league_codes
    puts "FOOBALL, a place for developers to play with football results on terminal."

    competitions = []
    COMPETITIONS.each do |competition, info|
      competitions << ["#{competition}", info[:code], info[:code_alias], "#{info[:country]}"]
    end
    table = Terminal::Table.new(title: "Available competitions", headings: ["Competition", "Code", "Alias", "Country"], rows: competitions)

    puts table
  end

  def format_date(date)
    # Valid date params is YYYY-MM-DD
    date.strftime("%Y-%m-%d")
  end

  def format_time(time)
    (Time.parse(time) + (Config.fetch(:timezone) * 3600)).strftime("%F %H:%M")
  end

  def require_league_option(league)
    detect_alias(league)

  rescue InvalidLeagueOptionError => exception
    puts colorize(exception.message, "red")
    introduce_league_codes
    exit
  end

  def detect_alias(league)
    league = league.upcase
    return if COMPETITION_CODES.include?(league)
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
    # If no --from provided, we took yesterday to the next 5 days.
    if params.season.nil?
      params.dateFrom = params.from || format_date(Date.today.prev_day)
      days = params.days.to_i.positive? ? params.days.to_i : DEFAULT_DAYS_OPTION
      params.dateTo = format_date(Date.parse(params.dateFrom) + days)
    end

    # Delete unnecessary params out of the final params builder.
    params.delete_field(:from) if params.from
    params.delete_field(:days) if params.days
    params.delete_field(:league)

    params.to_h.map { |option, value| "#{option}=#{value}" }.join("&")
  end

  def require_success_response!(parsed_response)
    raise ApiResponseError.new(parsed_response["message"]) if parsed_response["errorCode"] || parsed_response["error"]

  rescue ApiResponseError => exception
    puts colorize(exception.message, "red")
    exit
  end

  def require_setup_command
    config_path = File.expand_path(DEFAULT_CONFIG_FILE_PATH)

    unless File.exists?(config_path)
      puts "Run #{colorize("`fooball setup`", "green")} to configure your credentials."
      exit
    end
  end
end

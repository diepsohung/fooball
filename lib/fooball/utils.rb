module Fooball
  extend self

  def colorize(string, color)
    raise InvalidColorError, "Faield to fetch color, valid colors: #{COLOR.keys.join(', ')}" unless COLOR.keys.include?(color)

    "\e[#{COLOR.fetch(color)}m#{string}\e[0m"
  end

  def format_date(date)
    date.strftime("%Y-%m-%d")
  end

  def require_league_option(league)
    unless detect_alias(league)
      introduce_league_codes
      exit
    end
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

  def detect_alias(league)
    return if COMPETITION_CODES.include?(league)
    league_alias = COMPETITIONS.values.detect { |league| league[:code_alias] == league }
    return league_alias[:code] if league_alias

    puts colorize("Option --league is required. Please select the correct one.", "red")
    false
  end

  def request_headers
    config_path = File.expand_path(DEFAULT_CONFIG_FILE_PATH)
    credentials = JSON.load(File.read(config_path))

    { "X-Auth-Token" => credentials["token"], "Content-Type" => "application/json" }
  end

  def build_query_params(options)
    # Create a new hash to rename the options
    # The original Thor::CoreExt::HashWithIndifferentAccess caused FrozenError
    params = Hash.new(options)
    params["dateFrom"] = options["from"] || format_date(Date.today.prev_day)
    params["dateTo"] = options["to"] || format_date(Date.today.next_day)
    params["plan"] = "TIER_ONE"

    params.delete("from")
    params.delete("to")

    params.map { |option, value| "#{option}=#{value}" }.join("&")
  end

  def require_setup_command!
    config_path = File.expand_path(DEFAULT_CONFIG_FILE_PATH)

    unless File.exists?(config_path)
      puts "Run #{colorize("`fooball setup`", "green")} to configure your credentials."
      exit
    end
  end
end

module Fooball

  DEFAULT_CONFIG_FILE_PATH = "~/.fooball.config.json".freeze
  REGISTER_LINK = "https://www.football-data.org/client/register".freeze
  API_ENDPOINT = "https://api.football-data.org/v2".freeze
  DEFAULT_DAYS_OPTION = 5

  COLOR = {
    "red" => 31,
    "green" => 32,
    "yellow" => 33,
    "blue" => 34,
    "purple" => 35,
    "cyan" => 36,
    "white" => 37,
  }.freeze

  COMPETITIONS = {
    "Premier League" => { code: "PL", id: 2021, country: "England" },
    "Championship" => { code: "ELC", id: 2016, country: "England" },
    "Primera Division" => { code: "PD", id: 2014, code_alias: "LL", country: "Spain" },
    "Bundesliga" => { code: "BL1", id: 2002, code_alias: "BL", country: "Germany" },
    "Serie A" => { code: "SA", id: 2019, country: "Italy" },
    "Ligue 1" => { code: "FL1", id: 2015, code_alias: "L1", country: "France" },
    "European Championship" => { code: "EC", id: 2018, code_alias: "EU", country: "Europe" },
    "UEFA Champions League" => { code: "CL", id: 2001, code_alias: "C1", country: "Europe" },
    "Eredivisie" => { code: "DED", id: 2003, country: "Netherlands" },
    "Primeira Liga" => { code: "PPL", id: 2017, country: "Portugal" },
    "Série A" => { code: "BSA", id: 2013, country: "Brazil" },
    "World Cup" => { code: "WC", id: 2000, country: "World" },
  }.freeze

  COMPETITION_CODES = %w[PL ELC PD BL1 SA FL1 EC CL DED PPL BSA WC].freeze

  POWERFUL_TEAMS = [
    # England
    { id: 57, name: "Arsenal", tla: "ARS" },
    { id: 61, name: "Chelsea", tla: "CHE" },
    { id: 64, name: "Liverpool", tla: "LIV" },
    { id: 65, name: "Manchester City", tla: "MCI" },
    { id: 66, name: "Manchester United", tla: "MUN" },
    { id: 73, name: "Tottenham Hotspur", tla: "TOT" },
    # Spain
    { id: 78, name: "Atlético de Madrid", tla: "ATM" },
    { id: 81, name: "Barcelona", tla: "FCB" },
    { id: 86, name: "Real Madrid", tla: "RMA" },
    # Germany
    { id: 4, name: "Borussia 09 Dortmund", tla: "BVB" },
    { id: 5, name: "Bayern München", tla: "FCB" },
    # Italy
    { id: 98, name: "AC Milan", tla: "MIL" },
    { id: 100, name: "AS Roma", tla: "ROM" },
    { id: 108, name: "Internazionale Milano", tla: "INT" },
    { id: 109, name: "Juventus", tla: "JUV" },
    { id: 113, name: "SSC Napoli", tla: "NAP" },
    # France
    { id: 524, name: "Paris Saint-Germain", tla: "PSG" },
  ].freeze

end

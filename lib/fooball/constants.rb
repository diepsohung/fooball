module Fooball
  DEFAULT_CONFIG_FILE_PATH = "~/.fooball.config.json".freeze
  REGISTER_LINK = "https://www.football-data.org/client/register".freeze
  API_ENDPOINT = "https://api.football-data.org/v2/competitions".freeze
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
end

require "thor"
require "tty-prompt"
require "json"
require "httparty"
require "terminal-table"

require "fooball/version"
require "fooball/constants"
require "fooball/errors"
require "fooball/easy_hash"
require "fooball/config"
require "fooball/utils"

require "fooball/api/match"

require "fooball/command/setup"
require "fooball/command/match"

require "fooball/view/match/list"

require "fooball/cli"

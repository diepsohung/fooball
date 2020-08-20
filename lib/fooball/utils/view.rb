module Fooball
  extend self

  def colorize(string, color)
    raise InvalidColorError, "Faield to fetch color, valid colors: #{COLOR.keys.join(', ')}" unless COLOR.keys.include?(color)

    "\e[#{COLOR.fetch(color)}m#{string}\e[0m"
  end
end

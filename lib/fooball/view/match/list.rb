module Fooball
  module View
    module List
      extend self

      def render(data)
        table = Terminal::Table.new(title: data.competition["name"]) do |t|
          if data.matches.empty?
            t.add_row(["No matches."])
          end
        end

        puts table
      end

    end
  end
end

module Fooball
  module View
    module List

      extend self

      def render(data, options = {})
        terminal_table = Terminal::Table.new do |table|
          table.title = data.competition.name
          table.style = { width: 100, all_separators: true, alignment: :center }
          table.align_column(1, :right)
          if data.matches.empty?
            table.add_row(["No matches."])
          else
            table.headings = ["Stage/Start", "Match", "Status"]

            Fooball::MagicHash.array_hash_to_ostruct(data.matches).each do |match|
              next unless in_range?(match.utcDate, options)

              table.add_row([
                stage_start_style(match),
                match_information_style(match),
                match.status,
              ])
            end
          end
        end

        $stdout.puts terminal_table
      end

      private

      def in_range?(utc_date, options)
        days = options.days.to_i.positive? ? options.days.to_i : DEFAULT_DAYS_OPTION
        date_from = options.from ? Date.parse(options.from) : Date.today.prev_day
        date_to = date_from + days
        local_time = Time.parse(utc_date) + Config.fetch(:timezone) * 3600

        local_time.to_date.between?(date_from, date_to)
      end

      def stage_start_style(match)
        [
          match.stage,
          Fooball.colorize(Fooball.format_time(match.utcDate), "yellow"),
        ].join("\n")
      end

      def match_information_style(match)
        match_result_style(
          home_team: match.homeTeam.name,
          home_team_score: match.score.fullTime.homeTeam,
          away_team: match.awayTeam.name,
          away_team_score: match.score.fullTime.awayTeam
        )
      end

      def match_result_style(home_team:, home_team_score:, away_team:, away_team_score:)
        return match_not_started_style(home_team, away_team) if home_team_score.nil?

        if home_team_score > away_team_score
          "FT: #{win_team_style(home_team)} #{fulltime_style(home_team_score, away_team_score)} #{lose_team_style(away_team)}"
        elsif home_team_score < away_team_score
          "FT: #{lose_team_style(home_team)} #{fulltime_style(home_team_score, away_team_score)} #{win_team_style(away_team)}"
        else
          "FT #{Fooball.colorize("#{home_team} #{fulltime_style(home_team_score, away_team_score)} #{away_team}", "purple")}"
        end
      end

      def lose_team_style(team)
        Fooball.colorize(team, "red")
      end

      def win_team_style(team)
        Fooball.colorize(team, "green")
      end

      def fulltime_style(home_team_score, away_team_score)
        "#{home_team_score} - #{away_team_score}"
      end

      def match_not_started_style(home_team, away_team)
        "#{home_team} ? - ? #{away_team}"
      end

    end
  end
end

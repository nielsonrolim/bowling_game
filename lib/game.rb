# frozen_string_literal: true

require 'awesome_print'
require 'csv'

class Game
  attr_accessor :players

  def initialize(file)
    @players = []
    CSV.foreach(file, 'r', { col_sep: "\t" }) do |row|
      name = row[0]
      score = row[1].to_i
      player = find_or_initialize_player(row[0])

      last_frame = player.frames.last

      if score > 10
        # puts "This throw (#{name} #{score}) is invalid and will be considered as zero"
        score = 0
      end

      if player.closed_last_frame?
        # puts "This throw (#{name} #{score}) is invalid and will be ignored"
        next
      end

      if last_frame.nil?
        player.frames << [score]
      else
        if (last_frame.first == 10 || last_frame.size == 2) && player.frames.size < 10
          player.frames << [score]
        else
          last_frame.push(score)
        end
      end

      players << player unless players.include? player
    end
  end

  def find_or_initialize_player(player_name)
    player = players.select { |p| p.name == player_name }.first

    player = Player.new(player_name) if player.nil?

    player
  end

end

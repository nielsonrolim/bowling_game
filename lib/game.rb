# frozen_string_literal: true

require 'awesome_print'
require 'csv'

class Game
  attr_accessor :players
  attr_reader :file

  def initialize(file)
    @players = []
    @file = file
    load_file_content
  end

  def load_file_content
    CSV.foreach(file, 'r', { col_sep: "\t" }) do |row|
      name = row[0]
      score = row[1]
      player = find_or_initialize_player(row[0])

      last_frame = player.frames.last

      if score.to_i > 10
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
        if (last_frame.first == '10' || last_frame.size == 2) && player.frames.size < 10
          player.frames << [score]
        else
          last_frame.push(score)
        end
      end

      players << player unless players.include? player
    end
  end

  def print_results
    puts "Frame\t\t1\t\t2\t\t3\t\t4\t\t5\t\t6\t\t7\t\t8\t\t9\t\t10"

    players.each do |p|
      puts "#{p.name}"
      print "Pitfalls\t"
      p.frames.each do |f|
        if f.size == 1
          print "\tX\t"
        else
          f.each_with_index do |t, i|
            if t == 10
              throw = 'X'
            elsif i == 1 && t.to_i + f[i-1].to_i == 10
              throw = '/'
            else
              throw = t
            end
            print "#{throw}\t"
          end
        end
      end
      print "\n"
      print "Score\t"
      score = 0
      p.frames.each_with_index do |_f, i|
        score += p.score_for_frame(i)
        print "\t#{score}\t"
      end
      print "\n"
    end
  end

  private

  def find_or_initialize_player(player_name)
    player = players.select { |p| p.name == player_name }.first

    player = Player.new(player_name) if player.nil?

    player
  end

end

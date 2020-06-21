#!/usr/bin/env ruby

require_relative 'autoload'
require 'awesome_print'

game = Game.new(ARGV[0])

ap game.players

ap game.players[0].score
ap game.players[1].score
ap game.players[2].score
ap game.players[3].score

puts

# ap game.players[2].score_for_frame(0)
# ap game.players[2].score_for_frame(1)
# ap game.players[2].score_for_frame(2)
# ap game.players[2].score_for_frame(3)
# ap game.players[2].score_for_frame(4)
# ap game.players[2].score_for_frame(5)
# ap game.players[2].score_for_frame(6)
# ap game.players[2].score_for_frame(7)
# ap game.players[2].score_for_frame(8)
# ap game.players[2].score_for_frame(9)

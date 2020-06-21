#!/usr/bin/env ruby

require_relative '../autoload'
require 'awesome_print'

game = Game.new(ARGV[0])

puts "Frame\t\t1\t\t2\t\t3\t\t4\t\t5\t\t6\t\t7\t\t8\t\t9\t\t10"

game.players.each do |p|
  puts "#{p.name}"
  print "Pitfalls\t"
  p.frames.each do |f|
    if f.size == 1
      print "\tX\t"
    else
      f.each_with_index do |t, i|
        if t == 10
          throw = 'X'
        elsif i == 1 && t + f[i-1] == 10
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

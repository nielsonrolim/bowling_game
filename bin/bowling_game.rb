#!/usr/bin/env ruby

require_relative '../autoload'
require 'awesome_print'

game = Game.new(ARGV[0])

puts "Frame\t\t1\t\t2\t\t3\t\t4\t\t5\t\t6\t\t7\t\t8\t\t9\t\t10"

game.print_results
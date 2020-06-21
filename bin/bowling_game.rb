#!/usr/bin/env ruby

require_relative '../autoload'
require 'awesome_print'

begin
  game = Game.new(ARGV[0])

  game.print_results
rescue Exception => e
  puts e.message
end
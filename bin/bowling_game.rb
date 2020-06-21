#!/usr/bin/env ruby

require_relative '../autoload'
require 'awesome_print'

game = Game.new(ARGV[0])

game.print_results
#!/usr/bin/env ruby
# frozen_string_literal: true

def game_impossible?(line)
  amounts = biggest_cubes(line)
  return true if amounts[0] > 12 || amounts[1] > 13 || amounts[2] > 14

  false
end

def biggest_cubes(cubes)
  amounts = [[], [], []]
  cubes.each do |cube|
    amount = cube.split[0].to_i
    color = cube.split[1]
    amounts[0].push(amount) if color == 'red'
    amounts[1].push(amount) if color == 'green'
    amounts[2].push(amount) if color == 'blue'
  end
  amounts.map(&:max)
end

def sum_impossible_games(input)
  sum = 0
  File.foreach(input).with_index do |line, index|
    sum += index + 1 unless game_impossible?(line.split(':')[1].gsub!(';', ',').split(','))
  end
  sum
end

def sum_possible_games(input)
  sum = 0
  File.foreach(input) do |line|
    cubes = line.split(':')[1].gsub!(';', ',').split(',')
    sum += biggest_cubes(cubes).reduce(:*)
  end
  sum
end

puts sum_impossible_games('inputs/2')
puts sum_possible_games('inputs/2')

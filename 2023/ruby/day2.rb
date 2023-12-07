#!/usr/bin/env ruby
# frozen_string_literal: true

def cube_too_big?(line)
  line.each do |cubes|
    amount = cubes.split[0].to_i
    color = cubes.split[1]

    case color
    when 'red'
      return true if amount > 12
    when 'green'
      return true if amount > 13
    when 'blue'
      return true if amount > 14
    end
  end
  false
end

def get_biggest_cube(cubes, color)
  biggest = 0
  cubes.each do |cube|
    amount = cube.split[0].to_i
    cube_color = cube.split[1]
    biggest = [biggest, amount].max if color == cube_color
  end
  biggest
end

def part1(input)
  i = 1
  sum = 0
  File.foreach(input) do |line|
    sum += i unless cube_too_big?(line.split(':')[1].gsub!(';', ',').split(','))
    i += 1
  end
  sum
end

def part2(input)
  sum = 0
  File.foreach(input) do |line|
    cubes = line.split(':')[1].gsub!(';', ',').split(',')
    sum += get_biggest_cube(cubes, 'red') * get_biggest_cube(cubes, 'green') * get_biggest_cube(cubes, 'blue')
  end
  sum
end

puts part1('inputs/2')
puts part2('inputs/2')

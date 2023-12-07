#!/usr/bin/env ruby
# frozen_string_literal: true

INPUT = 'inputs/6'

def times = File.readlines(INPUT)[0].split.drop(1).map(&:to_i)
def distances = File.readlines(INPUT)[1].split.drop(1).map(&:to_i)

def time = File.readlines(INPUT)[0].gsub('Time:', '').gsub(' ', '').to_i
def distance = File.readlines(INPUT)[1].gsub('Distance:', '').gsub(' ', '').to_i

# return an array containing ranges of every winning time for each race by zipping
def get_all_winning_times(times, distances)
  races = []
  times.zip(distances).each do |race|
    races.push(get_winning_times(race[0], race[1]))
  end
  races
end

# get the winning times
# this is the quadratic formula, but i fucked it up beyond recognition to satisfy rubocop...
def get_winning_times(time, distance)
  a = time**2
  b = Math.sqrt(a - 4 * -1.0 * -distance)
  c = 2 * -1.0

  ((-a + b) / c).ceil..((-a - b) / c).floor
end

def multiply_amount_winning_times
  sum = 1
  get_all_winning_times(times, distances).each do |times|
    sum *= times.count
  end
  sum
end

def amount_winning_times
  times = get_winning_times(time, distance)
  times.last - times.first - 1
end

# part 1 answer
puts multiply_amount_winning_times

# part 2 answer
puts amount_winning_times

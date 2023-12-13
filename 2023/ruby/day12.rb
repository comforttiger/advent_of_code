#!/usr/bin/env ruby
# frozen_string_literal: true

print 'enter for input, ex for example: '
INPUT = "inputs/12#{gets.chomp}".freeze
print 'part 1 or 2: '
PART = gets.chomp

def lines = File.readlines(INPUT, chomp: true)

def parse_line(line)
  format_one, format_two = line.split
  [format_one.chars, format_two.split(',').map(&:to_i)]
end

# recursive method. goes through each character until it reaches a ?, then
# does one recursion where the ? is ., another where its #.
# check to see if all numbers are satisfied and return 1. return 0 if we're at
# the end and it didnt work out. i think?
# rubocop:disable Metrics
def arrangements_amount(line, broken, consecutive = 0, found_broken = [])
  possible = 0
  found_broken = found_broken.dup
  line.each.with_index do |char, index|
    consecutive += 1 if char == '#'
    if char == '.' && consecutive.positive?
      found_broken.push consecutive
      consecutive = 0
    end
    if char == '?'
      line[index] = '#'
      possible += arrangements_amount(line[index..], broken, consecutive, found_broken)
      line[index] = '.'
      possible += arrangements_amount(line[index..], broken, consecutive, found_broken)
      break
    end
  end
  found_broken.push consecutive if consecutive.positive?
  possible += 1 if found_broken == broken
  possible
end
# rubocop:enable Metrics

def sum_arrangements_amounts(lines)
  sum = 0
  lines.each do |l|
    line, broken = parse_line(l)
    amount = arrangements_amount(line, broken)
    puts amount
    sum += amount
  end
  sum
end

puts sum_arrangements_amounts(lines)

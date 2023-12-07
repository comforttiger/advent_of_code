#!/usr/bin/env ruby
# frozen_string_literal: true

lines = File.readlines('inputs/3').map(&:chomp)

# rubocop:disable Metrics
def get_numbers(symbol_pos, line_pos, lines)
  start = line_pos
  finish = line_pos
  start = line_pos - 1 if line_pos.positive?
  finish = line_pos + 1 if line_pos < lines.length - 1
  numbers = []

  lines[start..finish].each do |line|
    number = String.new
    number_start = 0
    number_finish = 0
    line.split('').each_with_index do |char, char_index|
      if char =~ /[0-9]/
        number_start = char_index if number.empty?
        number_finish = char_index
        number.concat char
      elsif !number.empty? && (((number_start - symbol_pos).abs <= 1) || ((number_finish - symbol_pos).abs <= 1))
        numbers.push number.to_i
        number.clear
      else
        number.clear
      end
    end
    if !number.empty? && (((number_start - symbol_pos).abs <= 1) || ((number_finish - symbol_pos).abs <= 1))
      numbers.push number.to_i
      number.clear
    end
  end

  numbers
end
# rubocop:enable Metrics

def part1(lines)
  sum = 0
  lines.each_with_index do |line, lines_index|
    line.split('').each_with_index do |char, char_index|
      get_numbers(char_index, lines_index, lines).each { |n| sum += n } unless char =~ /[0-9]|[.]/
    end
  end
  sum
end

def part2(lines)
  sum = 0
  lines.each_with_index do |line, lines_index|
    line.split('').each_with_index do |char, char_index|
      if char =~ /[*]/
        numbers = get_numbers(char_index, lines_index, lines)
        sum += numbers[0] * numbers[1] if numbers.length == 2
      end
    end
  end
  sum
end

puts part1(lines)
puts part2(lines)

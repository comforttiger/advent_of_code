#!/usr/bin/env ruby
# frozen_string_literal: true

def part1(input) = puts(add_numbers(input, false))
def part2(input) = puts(add_numbers(input, true))

def add_numbers(input, part2)
  sum = 0
  File.foreach(input) do |line|
    line = replace_words line if part2

    numbers = []
    line.split('').each do |char|
      numbers.push char.to_i if char =~ /[0-9]/
    end

    sum += numbers[0] * 10 + numbers[-1]
  end

  sum
end

def replace_words(line)
  line
    .gsub('one', 'o1e')
    .gsub('two', 't2o')
    .gsub('three', 't3e')
    .gsub('four', 'f4r')
    .gsub('five', 'f5e')
    .gsub('six', 's6x')
    .gsub('seven', 's7n')
    .gsub('eight', 'e8t')
    .gsub('nine', 'n9e')
end

part2('inputs/1')

#!/usr/bin/env ruby
# frozen_string_literal: true

print 'enter for input, ex for example: '
INPUT = "inputs/9#{gets.chomp}".freeze
print 'part 1 or 2: '
PART = gets.chomp

def get_differences(values)
  all_differences = [values]
  all_differences.push(all_differences[-1].each_cons(2).map { _2 - _1 }) until all_differences[-1].all?(&:zero?)
  all_differences
end

def history_value(differences)
  number_below = 0
  (0..differences.length - 2).reverse_each do |i|
    number_below = differences[i][-1] + number_below if PART == '1'
    number_below = differences[i][0] - number_below if PART == '2'
  end
  number_below
end

def sum_history_values
  sum = 0
  File.foreach(INPUT) do |line|
    sum += history_value(get_differences(line.split.map(&:to_i)))
  end
  sum
end

puts sum_history_values

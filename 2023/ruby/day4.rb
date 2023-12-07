#!/usr/bin/env ruby
# frozen_string_literal: true

INPUT = 'inputs/4'

def winning_numbers(line) = line.split('|')[0].split.map(&:to_i)
def card_numbers(line) = line.split('|')[1].split.map(&:to_i)
def initial_card_amount = File.readlines(INPUT).length
def card_points(card) = winning_numbers(card).common_elements(card_numbers(card))

def multiply_cards_points
  sum = 0
  File.foreach(INPUT) do |card|
    winners = card_points card.split(':')[1]
    sum += 2**(winners - 1) if winners.positive?
  end
  sum
end

def accumulate_cards
  sum = initial_card_amount
  card_amounts = Array.new(initial_card_amount, 1)
  File.foreach(INPUT).with_index do |card, index|
    winners = card_points card.split(':')[1]
    repeat = card_amounts[index]
    (index..index + winners).each { |x| card_amounts[x] += repeat }
    sum += winners * repeat
  end
  sum
end

# adding a common_elements method to the array. im only doing this because it's silly.
class Array
  def common_elements(other)
    (self & other).length
  end
end

# part 1 answer
puts multiply_cards_points

# part 2 answer
puts accumulate_cards

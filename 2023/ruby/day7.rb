#!/usr/bin/env ruby
# frozen_string_literal: true

# part 1 hierarchy:
HIERARCHY = %w[2 3 4 5 6 7 8 9 T J Q K A].freeze

# part 2 hierarchy:
JOKER_HIERARCHY = %w[J 2 3 4 5 6 7 8 9 T Q K A].freeze

INPUT = 'inputs/7'

# true for part 2, false for part 1.
JOKER = true

# class that represents each hand of cards
class Hand
  include Comparable
  attr_reader :type, :cards, :bid

  def initialize(cards, bid)
    @cards = cards
    @bid = bid
    @type = if JOKER
              type_of(@cards, JOKER_HIERARCHY.drop(1))
            else
              type_of(@cards, HIERARCHY)
            end
  end

  def <=>(other)
    return 1 if @type > other.type
    return -1 if @type < other.type

    @cards.zip(other.cards).each do |pair|
      return 1 if pair[0] > pair[1]
      return -1 if pair[0] < pair[1]
    end
    0
  end
end

# class that represents the individual cards
class Card
  include Comparable
  attr_reader :value

  def initialize(value)
    @value = value
  end

  def <=>(other)
    return 0 if @value == other.value

    if (JOKER && JOKER_HIERARCHY.index(@value) > JOKER_HIERARCHY.index(other.value)) ||
       (!JOKER && HIERARCHY.index(@value) > HIERARCHY.index(other.value))
      return 1
    end

    -1
  end
end

# overwriting string for fun
class String
  def to_card
    Card.new(self)
  end
end

# return type (1-7)
def type_of(hand, hierarchy)
  tally_cards(card_counts(hand, hierarchy))
end

def card_counts(hand, hierarchy)
  cards_in_hand = Array.new(13, 0)
  cards_in_hand.pop if JOKER
  hand.each do |card|
    next if card.value == 'J' && JOKER

    cards_in_hand[hierarchy.index(card.value)] += 1
  end
  cards_in_hand.delete(0)
  return [5] if cards_in_hand.empty?

  cards_in_hand[cards_in_hand.index(cards_in_hand.max)] += 5 - cards_in_hand.reduce(:+)
  cards_in_hand
end

def tally_cards(cards)
  cards = cards.sort.reverse
  return cards[0] + 2 if cards[0] > 3
  return 5 if cards == [3, 2]
  return 4 if cards == [3, 1, 1]
  return 3 if cards == [2, 2, 1]
  return 2 if cards == [2, 1, 1, 1]

  1
end

# parse input file into array of hands
def parse
  hands = []
  File.foreach(INPUT) do |line|
    cards = line.split[0].split('').map(&:to_card)
    bid = line.split[1].to_i
    hands.push(Hand.new(cards, bid))
  end
  hands
end

# go through sorted hands array and get our winnings!!!
def winnings
  sum = 0
  parse.sort.each.with_index do |hand, index|
    sum += hand.bid * (index + 1)
  end
  sum
end

puts winnings

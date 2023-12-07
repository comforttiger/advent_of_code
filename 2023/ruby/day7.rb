#!/usr/bin/env ruby
# frozen_string_literal: true

# part 1 hierarchy:
HIERARCHY = %w[2 3 4 5 6 7 8 9 T J Q K A].freeze

# part 2 hierarchy:
JOKER_HIERARCHY = %w[J 2 3 4 5 6 7 8 9 T Q K A].freeze

INPUT = 'inputs/7'

# true for part 2, false for part 1.
JOKER = false

# class that represents each hand of cards
class Hand
  include Comparable
  attr_reader :type, :cards, :bid

  def initialize(cards, bid)
    @cards = cards
    @bid = bid
    @type = if JOKER
              type_of_joker_edition(@cards)
            else
              type_of(@cards)
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
def type_of(hand)
  cards_in_hand = Array.new(13)
  hand.each do |card|
    cards_in_hand[HIERARCHY.index(card.value)] = 0 unless cards_in_hand[HIERARCHY.index(card.value)]
    cards_in_hand[HIERARCHY.index(card.value)] += 1 if cards_in_hand[HIERARCHY.index(card.value)]
  end
  cards_in_hand.delete(nil)
  tally_cards(cards_in_hand)
end

# rubocop:disable Metrics
def type_of_joker_edition(hand)
  cards_in_hand = Array.new(12)
  jokers = 0
  hand.each do |card|
    if card.value == 'J'
      jokers += 1
      next
    end
    cards_in_hand[JOKER_HIERARCHY.index(card.value) - 1] = 0 unless cards_in_hand[JOKER_HIERARCHY.index(card.value) - 1]
    cards_in_hand[JOKER_HIERARCHY.index(card.value) - 1] += 1 if cards_in_hand[JOKER_HIERARCHY.index(card.value) - 1]
  end
  cards_in_hand.delete(nil)
  return 7 if jokers == 5

  cards_in_hand[cards_in_hand.index(cards_in_hand.max)] += jokers
  tally_cards(cards_in_hand)
end

def tally_cards(cards)
  case cards.tally
  when { 5 => 1 } # five of a kind
    7
  when { 4 => 1, 1 => 1 } # four of a kind
    6
  when { 3 => 1, 2 => 1 } # full house
    5
  when { 3 => 1, 1 => 2 } # three of a kind
    4
  when { 2 => 2, 1 => 1 } # two pair
    3
  when { 2 => 1, 1 => 3 } # one pair
    2
  else # high card
    1
  end
end
# rubocop:enable Metrics

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

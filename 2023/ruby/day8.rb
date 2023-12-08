#!/usr/bin/env ruby
# frozen_string_literal: true

# this makes it easy for me to choose between example or main input w/o editing any code
print 'enter for input file, ex for example '
INPUT = "inputs/8#{gets.chomp}".freeze
print 'part 1 or 2? '
PART = gets.chomp

# get first line of input and split it into separate instructions
def instructions = File.open(INPUT).first.chomp.split('')

# creates a hash of nodes
def nodes
  nodes = {}
  File.readlines(INPUT).drop(2).each do |line|
    node, left, right = line.gsub(/[(]|[)]|,|=/, '').split

    nodes[node] = { left:, right: }
  end
  nodes
end

# counts steps until node satisfies a condition.
# &condition lets us pass a block to this method, like {_1 == 'ZZZ' } for part 1
def count_steps(nodes, instructions, start, &condition)
  current_node = start
  instructions.cycle.with_index do |instruction, step|
    current_node = nodes[current_node][:left] if instruction == 'L'
    current_node = nodes[current_node][:right] if instruction == 'R'
    return step + 1 if condition.call(current_node)
  end
end

# counts steps once from AAA to ZZZ
def traverse(nodes, instructions)
  count_steps(nodes, instructions, 'AAA') { _1 == 'ZZZ' }
end

# counts how many steps it takes for each node ending in A to get to a node ending in Z.
# they will always get to a node ending in Z at a fixed interval (e.g. every 105 steps), and if we then get
# the least common multiple for all of these, thats when they all overlap. it kinda makes sense i guess,
# but i wouldnt have figured it out without reddit.
def traverse_multiple(nodes, instructions)
  nodes.keys.filter { _1.end_with?('A') }.map do |node|
    count_steps(nodes, instructions, node) { _1.end_with?('Z') }
  end.reduce(&:lcm)
end

puts traverse(nodes, instructions) if PART == '1'
puts traverse_multiple(nodes, instructions) if PART == '2'

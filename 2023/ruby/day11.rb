#!/usr/bin/env ruby
# frozen_string_literal: true

print 'enter for input, ex for example: '
INPUT = "inputs/11#{gets.chomp}".freeze
print 'part 1 or 2: '
PART = gets.chomp

def image = File.readlines(INPUT, chomp: true).map(&:chars)

def blank_columns(image)
  columns = []
  image = image.transpose
  image.each.with_index do |column, index|
    columns.push(index) unless column.include? '#'
  end
  columns
end

# rubocop:disable Metrics/MethodLength
def galaxy_coords(image, times)
  coords = []
  blank_columns = blank_columns(image)
  y_offset = 0
  image.each.with_index do |row, y|
    x_offset = 0
    y_offset += times unless row.include? '#'
    row.each.with_index do |char, x|
      x_offset += times if blank_columns.include? x
      coords.push([x + x_offset, y + y_offset]) if char == '#'
    end
  end
  coords
end
# rubocop:enable Metrics/MethodLength

def distances(galaxy_coords)
  distances = []
  galaxy_coords.combination(2) do |g1, g2|
    x1, y1 = g1
    x2, y2 = g2
    distances.push((x1 - x2).abs + (y1 - y2).abs)
  end
  distances
end

puts distances(galaxy_coords(image, 1)).reduce(:+) if PART == '1'
puts distances(galaxy_coords(image, 999_999)).reduce(:+) if PART == '2'

#!/usr/bin/env ruby
# frozen_string_literal: true

# return array of seeds
def get_seeds(input) = File.readlines(input)[0].split.drop(1).map(&:to_i)
def split_into_maps(input) = File.read(input).split('map:').drop(1)

def get_seeds_ranges(input)
  seeds = []
  ranges = File.readlines(input)[0].split.drop(1).map(&:to_i)
  start = 0
  ranges.each_with_index do |number, index|
    start = number if index.even?
    seeds.push((start..start + number - 1)) if index.odd?
  end
  seeds
end

# return array of destination numbers
def get_map_destinations(sources, map)
  destinations = sources.dup
  map.each do |line|
    s, d = get_ranges(line)
    sources.each do |x|
      destinations[destinations.index(x)] = d.first + (x - s.first) if s.cover?(x)
    end
  end
  destinations
end

# rubocop:disable Metrics
def get_map_destination_ranges(sources, map)
  destinations = []
  unchecked_ranges = sources
  check_next = []
  map.each do |line|
    s, d = get_ranges(line)
    unchecked_ranges.each do |range|
      overlaps = overlaps(range, s)
      if overlaps[0]
        destinations.push d.first + (s.first - overlaps[0].first).abs..d.last - (s.last - overlaps[0].last).abs
      end
      check_next.concat overlaps[1] if overlaps[1]
    end
    unchecked_ranges = check_next
    check_next = []
  end
  destinations.concat(unchecked_ranges)
end

def overlaps(range1, range2)
  return [nil, [range1.first..range1.last]] if range1.first > range2.last || range1.last < range2.first

  overlaps = [nil, []]
  overlaps[0] = [range1.first, range2.first].max..[range1.last, range2.last].min
  overlaps[1].push range1.first..range2.first - 1 if range1.first < range2.first
  overlaps[1].push range2.last + 1..range1.last if range1.last > range2.last

  overlaps
end
# rubocop:enable Metrics

# return two ranges, sources and destinations
def get_ranges(line)
  ranges = line.split
  destination_start = ranges[0].to_i
  source_start = ranges[1].to_i
  finish_offset = ranges[2].to_i

  sources = (source_start...source_start + finish_offset)
  destinations = (destination_start...destination_start + finish_offset)
  [sources, destinations]
end

# return 2d array. [map][line]
def parse(almanac)
  maps = []
  almanac.each do |map|
    lines = []
    map.each_line do |entry|
      next unless entry =~ /[0-9]/

      lines.push entry
    end
    maps.push lines
  end
  maps
end

def part1(input)
  sources = get_seeds(input)
  almanac = parse(split_into_maps(input))
  almanac.each do |map|
    sources = get_map_destinations(sources, map)
  end
  puts sources.min
end

def part2(input)
  sources = get_seeds_ranges(input)
  almanac = parse(split_into_maps(input))
  almanac.each do |map|
    sources = get_map_destination_ranges(sources, map)
  end
  puts smallest(sources)
end

def smallest(ranges)
  smallest = 2**63
  ranges.each do |range|
    smallest = [range.first, smallest].min
  end
  smallest
end

part2('inputs/5')

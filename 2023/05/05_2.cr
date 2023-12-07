require "big"

lines = File.read_lines("./input").map(&.strip).reject(&.empty?)

seed_tokens = lines.shift.scan(/\d+/).map(&.to_a).flatten.compact.map(&.to_big_i)

seed_ranges = seed_tokens.each_slice(2).to_a.map { |(from, to)| Range.new(from, from + to - 1) }

maps = [] of Hash(Range(BigInt, BigInt), Proc(BigInt, BigInt))

lines.each do |line|
  matches = line.scan(/(.+) map:/)
  if matches.any?
    key = matches.map(&.to_a).flatten.first
    maps << {} of Range(BigInt, BigInt) => Proc(BigInt, BigInt)
  else
    destination_start, source_start, length = line.scan(/\d+/).map(&.to_a).flatten.compact.map(&.to_big_i)

    maps.last[Range.new(source_start, source_start + length - 1)] = ->(number : BigInt) {
      delta = number - source_start
      destination_start + delta
    }
  end
end

min_value = Float64::INFINITY
seed_ranges.each_with_index do |seeds, seed_index|
  pp ["seed_ranges", "#{seed_index}/#{seed_ranges.size}", seeds]
  seeds.each do |seed|
    current_value = seed
    maps.each_with_index do |map, index|
      # if there's no range defined we assume the value itself (i.e. imlicit mapping)
      match = map.select { |range| range === current_value }
      next_value = nil
      if match.any?
        next_value = match.values.try(&.first).try(&.call(current_value))
      end
      if next_value.nil?
        next_value = current_value
      end

      # the last array is the final mapping
      if index == maps.size - 1
        min_value = [min_value, next_value].min
      else
        current_value = next_value
      end
    end
  end
end
puts min_value

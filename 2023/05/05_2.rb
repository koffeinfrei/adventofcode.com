lines = File.readlines('./input').map(&:strip).reject(&:empty?)

seed_tokens = lines.shift.scan(/\d+/).map(&:to_i)

seed_ranges = seed_tokens.each_slice(2).map { Range.new(_1, _1 + _2 - 1) }

maps = []

lines.each do |line|
  key = line.scan(/(.+) map:/).flatten.first
  if key
    maps << {}
  else
    destination_start, source_start, length = line.scan(/\d+/).map(&:to_i)

    maps.last[(source_start..(source_start + length - 1))] = ->(number) {
      delta = number - source_start
      destination_start + delta
    }
  end
end

final_values = []
seed_ranges.each_with_index do |seeds, seed_index|
  pp ['seed_ranges', "#{seed_index}/#{seed_ranges.length}", seeds]
  seeds.each do |seed|
    current_value = seed
    maps.each_with_index do |map, index|
      # pp ['maps', seed, "#{index}/#{maps.length}"]
      # if there's no range defined we assume the value itself (i.e. imlicit mapping)
      next_value = map.select { _1 === current_value }.values&.first&.call(current_value) || current_value

      # the last array is the final mapping
      if index == maps.length - 1
        final_values << next_value
      else
        current_value = next_value
      end
    end
  end
end
puts final_values.min

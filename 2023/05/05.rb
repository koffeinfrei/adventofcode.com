lines = File.readlines('./sample_input').map(&:strip).reject(&:empty?)

seeds = lines.shift.scan(/\d+/).map(&:to_i)

maps = []

lines.each do |line|
  key = line.scan(/(.+) map:/).flatten.first
  if key
    # an unspecified number should return itself
    maps << Hash.new { |hash, key| hash[key] = key }
  else
    destination_start, source_start, length = line.scan(/\d+/).map(&:to_i)

    length.times { maps.last[source_start + _1] = destination_start + _1 }
  end
end

final_values = []
seeds.each do |seed|
  current_value = seed
  maps.each_with_index do |map, index|
    next_value = map[current_value]

    # the last array is the final mapping
    if index == maps.length - 1
      final_values << next_value
    else
      current_value = next_value
    end
  end
end
puts final_values.min

lines = File.readlines('./input').map(&:strip).reject(&:empty?)

instructions = lines.shift.chars.map { ['L', 'R'].index(_1) }

map = lines.map { _1.scan(/(\w{3}) = \((\w{3}), (\w{3})\)/).flatten }.map { |(start, left, right)| [start, [left, right]] }.to_h

current_keys = map.keys.select { _1.end_with?('A') }
steps = 0

until current_keys.all? { _1.end_with?('Z') }
  instructions.each do |instruction|
    steps += 1
    current_keys.each.with_index do |current, index|
      current_keys[index] = map[current][instruction]
    end
    break if current_keys.all? { _1.end_with?('Z') }
  end
end

puts steps

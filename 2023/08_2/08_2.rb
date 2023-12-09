lines = File.readlines('./input').map(&:strip).reject(&:empty?)

instructions = lines.shift.chars.map { ['L', 'R'].index(_1) }

map = lines.map { _1.scan(/(\w{3}) = \((\w{3}), (\w{3})\)/).flatten }.map { |(start, left, right)| [start, [left, right]] }.to_h

current_keys = map.keys.select { _1.end_with?('A') }
steps = Array.new(current_keys.length, 0)

current_keys.each.with_index do |_, index|
  until current_keys[index].end_with?('Z')
    instructions.each do |instruction|
      steps[index] += 1
      current_keys[index] = map[current_keys[index]][instruction]
      break if current_keys[index].end_with?('Z')
    end
  end
end

puts steps.reduce(:lcm)

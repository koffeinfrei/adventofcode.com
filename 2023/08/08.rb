lines = File.readlines('./input').map(&:strip).reject(&:empty?)

instructions = lines.shift.chars.map { ['L', 'R'].index(_1) }

map = lines.map { _1.scan(/(\w{3}) = \((\w{3}), (\w{3})\)/).flatten }.map { |(start, left, right)| [start, [left, right]] }.to_h

current = 'AAA'
steps = 0

while current != 'ZZZ'
  instructions.each do |instruction|
    steps += 1
    current = map[current][instruction]
    break if current == 'ZZZ'
  end
end

puts steps

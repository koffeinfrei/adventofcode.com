lines = File.readlines('./input').map(&:strip).reject(&:empty?)
time = lines.first.scan(/\d+/).join.to_i
beatable_distance = lines.last.scan(/\d+/).join.to_i

count = 1.upto(time - 1).count do |hold_duration|
  speed = time - hold_duration
  distance = hold_duration * speed
  distance > beatable_distance
end

puts count

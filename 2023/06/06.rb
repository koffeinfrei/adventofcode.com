lines = File.readlines('./input').map(&:strip).reject(&:empty?)
times = lines.first.scan(/\d+/).map(&:to_i)
distances = lines.last.scan(/\d+/).map(&:to_i)

races = [times, distances].transpose

counts = races.map do |time, beatable_distance|
  count = 1.upto(time - 1).count do |hold_duration|
    speed = time - hold_duration
    distance = hold_duration * speed
    distance > beatable_distance
  end
end

puts counts.inject(:*)

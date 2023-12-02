lines = File.readlines('./input').map(&:strip)
calibration_values = lines.map do |line|
  numbers = line.scan(/\d/)
  "#{numbers.first}#{numbers.last}"
end

puts calibration_values.map(&:to_i).sum

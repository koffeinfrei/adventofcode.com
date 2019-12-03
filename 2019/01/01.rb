sum = File.readlines(File.join(__dir__, 'input')).map(&:to_i).inject(0) do |sum, current|
  sum + (current / 3 - 2)
end

puts sum

input = File.readlines(File.join(__dir__, 'input'))
sum = input.map(&:to_i).inject(0) do |sum, current|
  remainder = current

  loop do
    remainder = (remainder / 3 - 2)
    break if remainder <= 0
    sum += remainder
  end

  sum
end

puts sum

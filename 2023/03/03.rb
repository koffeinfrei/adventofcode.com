require 'matrix'

lines = File.readlines('./input').map(&:strip)

matrix = Matrix[*lines.map(&:chars)]

def min_index(index)
  [index, 0].max
end

numbers = []

lines.each_with_index do |line, line_index|
  line.scan(/\d+/) do |number|
    start_index = Regexp.last_match.offset(0).first
    end_index = start_index + number.length - 1

    adjacent_matrix = matrix.minor(
      min_index(line_index - 1)..line_index + 1,
      min_index(start_index - 1)..end_index + 1
    )

    if adjacent_matrix.to_a.flatten.compact.any?(/[^\.\d]/)
      numbers << number
    end
  end
end

puts numbers.map(&:to_i).sum

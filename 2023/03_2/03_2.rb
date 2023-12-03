require 'matrix'

lines = File.readlines('./input').map(&:strip)

matrix = Matrix[*lines.map(&:chars)]

def min_index(index)
  [index, 0].max
end

gears = {}

lines.each_with_index do |line, line_index|
  line.scan(/\d+/) do |number|
    start_index = Regexp.last_match.offset(0).first
    end_index = start_index + number.length - 1

    adjacent_matrix_start_x = min_index(line_index - 1)
    adjacent_matrix_start_y = min_index(start_index - 1)

    # Figure out if in the vicinity there's a `*`
    adjacent_matrix = matrix.minor(
      adjacent_matrix_start_x..line_index + 1,
      adjacent_matrix_start_y..end_index + 1
    )

    multiplier = adjacent_matrix.index('*')
    if multiplier
      # Get the global matrix index and group the numbers that surround the
      # same `*`
      matrix_index = [multiplier.first + adjacent_matrix_start_x, multiplier.last + adjacent_matrix_start_y]
      gears[matrix_index] ||= []
      gears[matrix_index] << number
    end
  end
end

puts gears.select { _2.length == 2 }.map { _2.map(&:to_i) }.map { _1.inject(:*) }.sum

lines = File.readlines('./input').map(&:strip)

points = lines
  .map do |line|
    _, winning, own = line
      .split(/: | \| /)
      .map { _1.split(' ') }

    matches = winning & own

    matches.inject(0) { |sum, _| sum.zero? ? 1 : sum * 2 }
  end

puts points.sum

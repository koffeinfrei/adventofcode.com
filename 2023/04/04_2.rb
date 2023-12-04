lines = File.readlines('./input').map(&:strip)

cards = Array.new(lines.length, 1)

points = lines
  .map.with_index do |line, index|
    _, winning, own = line
      .split(/: | \| /)
      .map { _1.split(' ') }

    matches = (winning & own).length
    copies = cards[index]

    (1..matches).each { cards[index + _1] += copies }
  end

puts cards.sum

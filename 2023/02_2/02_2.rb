lines = File.readlines('./input').map(&:strip)

games = lines
  .map do |line|
    key, game = line
      .gsub('Game ', '')
      .split(':')

    
    sets = game
      # Group all pairs of number and color
      .split(/[;,]/)
      .map(&:strip)
      .map { _1.split(' ') }
      .group_by { _2 }
      # Take all the numbers per group, and use the max value
      .map { [_1, _2.map(&:first).map(&:to_i).max] }
      .to_h

    [key.to_i, sets]
  end.to_h

puts games.map(&:last).map(&:values).map { _1.inject(:*) }.sum

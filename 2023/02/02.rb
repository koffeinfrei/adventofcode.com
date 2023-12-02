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

possible_games = games.select do |_, game|
  game.fetch('red', 0) <= 12 &&
    game.fetch('green', 0) <= 13 &&
    game.fetch('blue', 0) <= 14
end

pp possible_games.map(&:first).sum

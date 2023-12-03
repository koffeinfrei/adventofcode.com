puts File.readlines('./input').map(&:strip)
  .map { _1.scan(/\d/) }
  .map { "#{_1.first}#{_1.last}" }
  .map(&:to_i)
  .sum

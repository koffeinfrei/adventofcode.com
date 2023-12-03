TRANSLATIONS = {
  'one' => '1',
  'two' => '2',
  'three' => '3',
  'four' => '4',
  'five' => '5',
  'six' => '6',
  'seven' => '7',
  'eight' => '8',
  'nine' => '9'
}

puts File.readlines('./input').map(&:strip)
  .map { |line|
    line
      # include the words and digits
      # use a positive lookahead (`?=()`) to allow overlapping matches such as
      # "twone", which should match "two" and "one"
      .scan(/(?=(#{Regexp.union(TRANSLATIONS.keys + [/\d/]).source}))/)
      .flatten
      # translate the words to its corresponding digit, keep the digits
      .map { TRANSLATIONS.fetch(_1, _1) }
  }
  .map { "#{_1.first}#{_1.last}" }
  .map(&:to_i)
  .sum

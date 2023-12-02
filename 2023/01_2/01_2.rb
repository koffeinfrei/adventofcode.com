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

lines = File.readlines('./input').map(&:strip)
calibration_values = lines.map do |line|
  numbers = line
    # include the words and digits
    # use a positive lookahead (`?=()`) to allow overlapping matches such as
    # "twone", which should match "two" and "one"
    .scan(/(?=(#{Regexp.union(TRANSLATIONS.keys + [/\d/]).source}))/)
    .flatten
    # translate the words to its corresponding digit, keep the digits
    .map { TRANSLATIONS.fetch(_1, _1) }
  "#{numbers.first}#{numbers.last}"
end

puts calibration_values.map(&:to_i).sum

lines = File.readlines('./input').map(&:strip).reject(&:empty?)

hands = lines.map { _1.split(' ') }

def card_rank(char)
  %w[
    A
    K
    Q
    J
    T
    9
    8
    7
    6
    5
    4
    3
    2
  ].reverse.index(char) + 1
end

def type_rank(hand)
  chars = hand.chars

  groups = chars.group_by { _1 }.values

  # Five of a kind, e.g. "AAAAA"
  if groups.length == 1
    7
  # Four of a kind, e.g. "AA8AA"
  elsif groups.any? { _1.length == 4 }
    6
  # Full house, e.g. "23332"
  elsif groups.any? { _1.length == 3 } && groups.any? { _1.length == 2 }
    5
  # Three of a kind, e.g. "TTT98"
  elsif groups.any? { _1.length == 3 }
    4
  # Two pair, e.g. "23432"
  elsif groups.count { _1.length == 2 } == 2
    3
  # One pair, e.g. "A23A4"
  elsif groups.any? { _1.length == 2 }
    2
  # High card, e.g. "23456"
  elsif groups.length == 5
    1
  else
    raise "Unknown hand"
  end
end

sorted_hands = hands.sort do |a, b|
  a = a.first
  b = b.first

  a_type_rank = type_rank(a)
  b_type_rank = type_rank(b)

  if a_type_rank == b_type_rank
    a_chars = a.chars
    b_chars = b.chars
    5.times.each do |index|
      a_card_rank = card_rank(a_chars[index])
      b_card_rank = card_rank(b_chars[index])
      break a_card_rank <=> b_card_rank if a_card_rank != b_card_rank
    end
  else
    a_type_rank <=> b_type_rank
  end
end

# pp sorted_hands.map.with_index(1) { |hand, index| [hand, hand.last.to_i * index] }
puts sorted_hands.map.with_index(1) { |hand, index| hand.last.to_i * index }.sum

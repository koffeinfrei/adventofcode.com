lines = File.readlines('./input').map(&:strip)

histories = lines.map { [_1.scan(/-*\d+/).map(&:to_i)] }

histories.each do |history|
  # create a diff sequence until we have one with all zeros
  until history.last.all?(&:zero?)
    last = history.last
    history << []
    1.upto(last.length - 1).each do |index|
      history.last << last[index] - last[index - 1]
    end
  end

  # start extrapolating by adding another 0 to the last sequence...
  history.last << 0
  # ... and the adding the next number for each line above
  (history.length - 2).downto(0).each do |index|
    history[index].prepend(
      history[index][0] - history[index + 1][0]
    )
  end
end

puts histories.map(&:first).map(&:first).sum

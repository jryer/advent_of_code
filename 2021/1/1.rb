lines = File.readlines('input').map(&:to_i)

first_answer = lines.each_cons(2).count do |num|
  num[1].to_i > num[0].to_i
end

set_total = nil
second_answer = 0
lines.each_cons(3) do |num|
  before = set_total
  set_total = num.sum
  second_answer = second_answer+1 if before&&set_total>before
end

puts first_answer
puts second_answer

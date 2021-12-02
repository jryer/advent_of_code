lines = File.readlines('input').map(&:to_i)

def num_rising_groups(input:, group_size:)
  input.each_cons(group_size).count{ |a, *, b| b > a }
end

lines = File.readlines('input').map(&:to_i)
result = [2, 4].map { |n| num_rising_groups(input: lines, group_size: n) }

puts result

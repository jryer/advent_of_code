lines = File.readlines('input').map(&:to_s)
# #lines = ['forward 5','down 5','forward 8',' up 3','down 8','forward 2']

x = 0
y = 0
lines.each do |line|
  command, number = line.split(' ')
  if command == 'forward'
    x += number.to_i
  elsif command == 'up'
    y -= number.to_i
  elsif command=='down'
    y += number.to_i
  end


end

puts x*y


# Part 2
x = 0
y = 0
aim=0
lines.each do |line|
  command, number = line.split(' ')
  if command == 'forward'
    x += number.to_i
    y+=aim *number.to_i
  elsif command == 'up'
    aim -= number.to_i
  elsif command=='down'
    aim += number.to_i
  end
end

puts x*y

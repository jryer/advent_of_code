# fish is a hash, with the index representing an age and the value the number of fish of that age
fish = Hash.new(0)
File.readlines('input')[0].strip.split(',').map(&:to_i).each do |age|
    fish[age] += 1
end

(1..256).each do |day|
  new_fish = Hash.new(0)
  fish.each do |age, count| 
    if age==0
        new_fish[6] += count
        new_fish[8] += count
    else
        new_fish[age-1] += count
    end
  end
  fish = Marshal.load(Marshal.dump(new_fish))

  puts "Part 1: #{fish.values.sum}" if day == 80
end
puts "Part 2: #{fish.values.sum}"

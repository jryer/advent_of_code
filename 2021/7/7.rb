input_crabs = File.readlines('input')[0].strip.split(',').map(&:to_i).tally
max_crab = input_crabs.keys.max

crabs = Array.new(max_crab).map{|_x| 0}
input_crabs.each do |dist, num|
  crabs[dist] = num
end


# TODO faster with median / mode
fuel_cost = crabs.map.with_index do |_crabs_at_pos, pos_num|
    sum = 0
    inner_loop = crabs.each.with_index do |_v, to_add|
        sum += (pos_num - to_add).abs * crabs[to_add] 
    end

    sum
end
puts "Part 1: #{fuel_cost.min}"

fuel_cost_2 = crabs.map.with_index do |_crabs_at_pos, pos_num|
    sum = 0
    inner_loop = crabs.each.with_index do |_v, to_add|
        step = (pos_num - to_add).abs
        fuel_cost = step * (step+1)/2
        sum += fuel_cost* crabs[to_add] 
    end

    sum
end

puts "Part 2: #{fuel_cost_2.min}"

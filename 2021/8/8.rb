

parsed_input = File.readlines('input').map{|x| x.split(' | ').map{|y| y.strip.split(' ')}}

part_1 = 0
parsed_input.each do |line|
    input = line[0]
    output = line[1]

    output.each do |output_num|
        part_1 = part_1 + 1 if [2,  3, 4, 7].include?(output_num.length)     
        
    end

end

puts part_1

########


output_score = 0
parsed_input.each do |line|
    wires = [nil, nil, nil, nil, nil, nil, nil]

    input = line[0]
    output = line[1]

    all_words = input.append(*output).map{|x| x.split('').sort}.uniq
    
    wires[1] = all_words.find{|x| x.length==2}
    wires[4] = all_words.find{|x| x.length==4}
    wires[7] = all_words.find{|x| x.length==3}
    wires[8] = all_words.find{|x| x.length==7}

    six_length_words =  all_words.select{|x| x.length == 6}
    wires[6] = six_length_words.find{|x| (wires[1]-x).count == 1}


    six_length_words = six_length_words.select{|x| x!=wires[6]}


    five_length_words =  all_words.select{|x| x.length == 5}
    wires[3] = five_length_words.find{|x| (x-wires[1]).count == 3}

    five_length_words = five_length_words.select{|x| x!=wires[3]}

    wires[5] = five_length_words.find{|x| (wires[6] - x).count == 1}
    wires[2] = five_length_words.find{|x| x!=wires[5]}

    wires[0] = six_length_words.select{|x| (wires[3] - x).count == 1}
    wires[9] = six_length_words.select{|x| (wires[3] - x).count == 0}


    wires = wires.map(&:join)
    output.map{|x|  x.split('').sort.join }
    score = output.map{|x| wires.find_index{|y| y == x.split('').sort.join}}.join.to_i
    output_score += score
end
puts output_score

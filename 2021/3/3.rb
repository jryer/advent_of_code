lines = File.readlines("input").map { |x| x.to_s.strip }

total_lines = lines.size
num_bits = lines.first.size

sum_of_bits = Array.new(num_bits)

lines.each do |line|
  chars = line.strip.split("")
  chars.each_with_index do |x, j|
    sum_of_bits[j] ||= 0
    sum_of_bits[j] += x.to_i
  end
end

gamma = ""
episilon = ""
sum_of_bits.each do |i|
  num = (i.to_f / total_lines).round
  gamma += num.to_s
  episilon += (1 - num).to_s
end
puts gamma.to_i(2) * episilon.to_i(2)

####

oxy = lines.clone
co2 = lines.clone
bit = 0
while bit < num_bits
  avg_oxy = oxy.sum { |x| x[bit].to_i }.to_f / oxy.size
  avg_co2 = co2.sum { |x| x[bit].to_i }.to_f / co2.size

  keep_oxy = avg_oxy >= 0.5 ? 1 : 0
  keep_co2 = (avg_co2 >= 0.5 ? 0 : 1)

  oxy.filter! { |x| x[bit].to_i == keep_oxy } if oxy.size > 1
  co2.filter! { |x| x[bit].to_i == keep_co2 } if co2.size > 1
  bit += 1
end
oxy = oxy[0].to_i(2)
co2 = co2[0].to_i(2)
puts oxy * co2

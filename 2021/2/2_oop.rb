#Rewrote using OOP jus for fun
class Submarine
    def self.run(directions)
        new(directions).run
    end

    def initialize(directions)
        @directions = directions
        @x = 0
        @y = 0
        @aim = 0
    end


    def run
        @directions.each do |dir|
            cmd, num = dir.split(' ')
            send(cmd, num.to_i)
        end

        @x*@y
    end

    def forward; end
    def up; end
    def down; end
end


class Sub1 < Submarine
    def forward(num)
        @x += num
    end
    def up(num)
        @y -= num
    end
    def down(num)
        @y += num
    end
end

class Sub2 < Submarine
    def forward(num)
        @x += num
        @y += @aim * num
        @x += num
    end
    def up(num)
        @aim -= num
    end
    def down(num)
        @aim += num
    end
end

puts Sub1.run(lines)
puts Sub2.run(lines)
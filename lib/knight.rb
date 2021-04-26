
require_relative 'general_moves'

class Knight

    include GeneralMoves

    attr_reader :valid_moves

    def initialize(colour, position)
        @colour = colour
        @icon = determine_side(colour)
        @valid_moves = knight_valid_moves(position)
    end

    def determine_side(colour)
        case colour
        when "white"
            @icon = "\u2658".encode
        when "black"
            @icon = "\u265E".encode
        else
            # throw some error
        end
    end

    def knight_valid_moves(position)
        # first return cross shape first 2 elements
        # modify to take each element and push each position that's beside it, to attain the "L" move

        res = Array.new

        res.push(return_cross(position, "n")[1])
        res.push(return_cross(position, "e")[1])
        res.push(return_cross(position, "s")[1])
        res.push(return_cross(position, "w")[1])

        print res
        print "\n"

        res = find_adjacent_positions(res.compact)

        return res
    end

    # helper for knight_valid_moves
    def find_adjacent_positions(arr)
        valid_moves = Array.new
        arr.each.with_index do |pos, i|
            if i.even?
                letter_1 = pos[0] != "A" ? pos[0].ord - 1 : false
                letter_2 = pos[0] != "H" ? pos[0].ord + 1 : false
                valid_moves.push(letter_1.chr + pos[1]) unless !letter_1
                valid_moves.push(letter_2.chr + pos[1]) unless !letter_2
            else
                number_1 = pos[1] != "1" ? pos[1].ord - 1 : false
                number_2 = pos[1] != "8" ? pos[1].ord + 1 :false
                valid_moves.push(pos[0] + number_1.chr) unless !number_1
                valid_moves.push(pos[0] + number_2.chr) unless !number_2
            end
        end
        return valid_moves
    end

end

# some smoke test

knight = Knight.new("white", "A1")

print knight.valid_moves
print "\n"
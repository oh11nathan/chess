
require_relative 'general_moves'

class King

    include GeneralMoves

    attr_reader :valid_moves

    def initialize(colour, position)
        @colour = colour
        @icon = determine_side(colour)
        @valid_moves = king_valid_moves(position)

    end

    def determine_side(colour)
        case colour
        when "white"
            @icon = "\u2654".encode
        when "black"
            @icon = "\u265A".encode
        else
            # throw some error
        end
    end

    def king_valid_moves(position)
        res = Array.new

        res.push(return_diagonal(position, "nw")[0])
        res.push(return_diagonal(position, "ne")[0])
        res.push(return_diagonal(position, "se")[0])
        res.push(return_diagonal(position, "sw")[0])

        res.push(return_cross(position, "n")[0])
        res.push(return_cross(position, "e")[0])
        res.push(return_cross(position, "s")[0])
        res.push(return_cross(position, "w")[0])

        return res
    end

    def adjacent_moves(arr, position)
        # get node from board
        # create function to make all the 

    end

end

# some smoke test

king = King.new("black", "B2")

print king.valid_moves
print "\n"
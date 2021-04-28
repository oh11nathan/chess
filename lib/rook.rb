
require_relative 'general_moves'

class Rook

    include GeneralMoves

    attr_reader :valid_moves

    def initialize(colour, position)
        @colour = colour
        @icon = determine_side(colour)
        @valid_moves = rook_valid_moves(position)

    end

    def determine_side(colour)
        case colour
        when "white"
            @icon = "\u2656".encode
        when "black"
            @icon = "\u265C".encode
        else
            # throw some error
        end
    end

    # check each direction, forms a cross pattern
    # see general_moves.rb for return_cross source and helper functions
    def rook_valid_moves(position)
        pos = position.chars

        res = Array.new
        res.concat(return_cross(pos, "n"))
        res.concat(return_cross(pos, "e"))
        res.concat(return_cross(pos, "s"))
        res.concat(return_cross(pos, "w"))

        return res
    end

    def changed_position(new_position)
        @valid_moves = rook_valid_moves(new_position)
    end
    
end


# some smoke tests

# rook = Rook.new("black", "A2")
# rook = Rook.new("black", "E5")

# print rook.valid_moves
# print "\n"
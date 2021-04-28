
require_relative 'general_moves'

class Bishop

    include GeneralMoves
    # instance variables should include: icon, colour, position
    # maybe not position as the board can keep track of that
    attr_reader :valid_moves
    attr_reader :icon

    def initialize(colour, position)
        @colour = colour
        @icon = determine_side(colour)
        @valid_moves = bishop_valid_moves(position)
        # @position = pos
    end

    def determine_side(colour)
        case colour
        when "white"
            @icon = "\u2657".encode
        when "black"
            @icon = "\u265D".encode
        else
            # throw some error
        end
    end

    def bishop_valid_moves(position)
        pos = position.chars
        res = Array.new

        # check diagonals in each direction
        # see general_moves.rb for return_diagonal source and helper functions
        res.concat(return_diagonal(pos, "nw"))
        res.concat(return_diagonal(pos, "ne"))
        res.concat(return_diagonal(pos, "se"))
        res.concat(return_diagonal(pos, "sw"))

        return res
    end

    # to be called when the piece is moved successfully
    def changed_position(new_position)
        @valid_moves = bishop_valid_moves(new_position)
    end
    
end

# some smoke tests

# bishop = Bishop.new("white", "E5")
# print bishop.valid_moves
# print "\n"
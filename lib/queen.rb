
require_relative 'general_moves'

class Queen

    include GeneralMoves

    attr_reader :valid_moves

    def initialize(colour, position)
        @colour = colour
        @icon = determine_side(colour)
        @valid_moves = queen_valid_moves(position)
    end

    def determine_side(colour)
        case colour
        when "white"
            @icon = "\u2655".encode
        when "black"
            @icon = "\u265B".encode
        else
            # throw some error
        end
    end

    # all functionality achieved through general moves module
    def queen_valid_moves(position)
        res = Array.new

        res.concat(return_diagonal(position, "nw"))
        res.concat(return_diagonal(position, "ne"))
        res.concat(return_diagonal(position, "se"))
        res.concat(return_diagonal(position, "sw"))

        res.concat(return_cross(position, "n"))
        res.concat(return_cross(position, "e"))
        res.concat(return_cross(position, "s"))
        res.concat(return_cross(position, "w"))

        return res.compact
    end

    def changed_position(new_position)
        @valid_moves = queen_valid_moves(new_position)
    end

end

# some smoke tests
queen = Queen.new("black", "E5")
print queen.valid_moves
print "\n"
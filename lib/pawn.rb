
require_relative 'general_moves'

class Pawn

    include GeneralMoves

    attr_reader :valid_moves

    def initialize(colour, position)
        @colour = colour
        @icon = determine_side(colour)
        @valid_moves = pawn_valid_moves(position)
        @completed_one_move = false
    end

    def determine_side(colour)
        case colour
        when "white"
            @icon = "\u2659".encode
        when "black"
            @icon = "\u265F".encode
        else
            # throw some error
        end
    end

    def pawn_valid_moves(position)
        res = Array.new

        if @completed_one_move
            res.concat(return_cross(position, "n")[0])
        else
            res.concat(return_cross(position, "n").slice(0..1))
        end
        return res.compact
    end
    
    def changed_position(new_position)
        @valid_moves = pawn_valid_moves(new_position)
        self.completed_one_move?
    end

    def completed_one_move?
        if !@completed_one_move
            @completed_one_move = true
        end
    end

end

# some smoke test

pawn = Pawn.new("white", "A1")

print pawn.valid_moves
print "\n"

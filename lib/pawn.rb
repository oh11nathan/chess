
class Pawn

    def initialize(colour, position)
        @colour = colour
        @icon = determine_side(colour)
        @valid_moves = pawn_valid_moves(position)
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

    end
    
end
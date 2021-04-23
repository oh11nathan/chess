
class Rook

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

    def rook_valid_moves(position)
        
    end
    
end
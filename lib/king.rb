
class King

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

    end

end
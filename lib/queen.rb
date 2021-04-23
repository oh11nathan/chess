
class Queen

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

    def queen_valid_moves(position)

    end
end
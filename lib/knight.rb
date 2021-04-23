
class Knight

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

    end

end

class Bishop

    # instance variables should include: icon, colour, position
    # maybe not position as the board can keep track of that
    attr_reader :valid_moves

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
        res.concat(return_diagonal(pos, "nw"))
        res.concat(return_diagonal(pos, "ne"))
        res.concat(return_diagonal(pos, "se"))
        res.concat(return_diagonal(pos, "sw"))

        return res
    end

    # recursive function that handles each diagonal direction, would like to refactor at some point
    # looking at it I know that there is a better way, just don't know how yet
    # main problem is the fact that each direction has a specific base case
    def return_diagonal(pos, direction, valid_moves = Array.new)
        case direction
        when "nw"
            # check for boundry conditions for this case
            if pos.include?("A") || pos.include?("8")
                # push current position to some array and return
                return valid_moves
            else
                # move in nw direction
                new_pos = move_diagonally(pos, false, true)
                valid_moves.push(new_pos.join)
                res = return_diagonal(new_pos, "nw", valid_moves)
            end
        when "ne"
            if pos.include?("H") || pos.include?("8")
                return valid_moves
            else
                new_pos = move_diagonally(pos, true, true)
                valid_moves.push(new_pos.join)
                res = return_diagonal(new_pos, "ne", valid_moves)
            end
        when "se"
            if pos.include?("H") || pos.include?("1")
                return valid_moves
            else
                new_pos = move_diagonally(pos, true, false)
                valid_moves.push(new_pos.join)
                res = return_diagonal(new_pos, "se", valid_moves)
            end
        when "sw"
            if pos.include?("A") || pos.include?("1")
                return valid_moves
            else
                new_pos = move_diagonally(pos, false, false)
                valid_moves.push(new_pos.join)
                res = return_diagonal(new_pos, "sw", valid_moves)
            end
        end
        return res
    end

    def move_diagonally(pos, right, up)
        # right determines letters so if true +1, false -1 
        # up determines numbers so if true +1, false -1 
        new_pos = Array.new
        letter = right ? pos[0].ord + 1 : pos[0].ord - 1
        new_pos.push(letter.chr)

        num = up ? pos[1].ord + 1 : pos[1].ord - 1
        new_pos.push(num.chr)

        return new_pos
    end

    # to be called when the piece is moved successfully
    def changed_position(new_position)
        @valid_moves = bishop_valid_moves(new_position)
    end
    
end

# bishop = Bishop.new("white", "E5")
# puts bishop.valid_moves
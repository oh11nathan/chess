
# created this module because pieces such as the queen and king can utilize the same functionality 
# as rook and bishop pieces
# it didn't make sense to make these "genaric moves" a part of a "chess piece" parent class
# only certain pieces can move diagonally, side to side, up-down

module GeneralMoves

    # bishop functionality

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

    # rook functionality
    # basically the same implementation as bishop except in north, east, south directions
    def return_cross(pos, direction, valid_moves = Array.new)
        case direction
        when "n"
            if pos[1] == "8"
                return valid_moves
            else
                new_pos = move_up_down(pos, true)
                valid_moves.push(new_pos.join)
                res = return_cross(new_pos, "n", valid_moves)
            end
        when "e"
            if pos[0] == "H"
                return valid_moves
            else
                new_pos = move_left_right(pos, false)
                valid_moves.push(new_pos.join)
                res = return_cross(new_pos, "e", valid_moves)
            end
        when "s"
            if pos[1] == "1"
                return valid_moves
            else
                new_pos = move_up_down(pos, false)
                valid_moves.push(new_pos.join)
                res = return_cross(new_pos, "s", valid_moves)
            end
        when "w"
            if pos[0] == "A"
                return valid_moves
            else
                new_pos = move_left_right(pos, true)
                valid_moves.push(new_pos.join)
                res = return_cross(new_pos, "w", valid_moves)
            end
        end
        return res
    end

    def move_left_right(pos, left)
        # left determines if going right or left, if true go left, false go right
        # left --> -1, right --> +1
        new_pos = Array.new
        letter = left ? pos[0].ord - 1 : pos[0].ord + 1
        new_pos.push(letter.chr)
        new_pos.push(pos[1])

        return new_pos
    end

    def move_up_down(pos, up)
        # up determines if going up or down, if true go up, false go down
        # up --> +1, down --> -1
        new_pos = Array.new
        num = up ? pos[1].ord + 1 : pos[1].ord - 1
        new_pos.push(pos[0])
        new_pos.push(num.chr)

        return new_pos
    end

end
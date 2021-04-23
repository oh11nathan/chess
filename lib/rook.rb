
class Rook

    attr_reader :valid_moves

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
        pos = position.chars
        print "#{pos}"
        print "\n"

        res = Array.new
        res.concat(return_cross(pos, "n"))
        print "#{pos}"
        print "\n"
        res.concat(return_cross(pos, "e"))
        print "#{pos}"
        print "\n"
        res.concat(return_cross(pos, "s"))
        res.concat(return_cross(pos, "w"))
        return res
    end

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


rook = Rook.new("black", "A2")

print rook.valid_moves
print "\n"
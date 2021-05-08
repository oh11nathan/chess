
require_relative 'helper_graph'
require_relative 'pieces/bishop'
require_relative 'pieces/king'
require_relative 'pieces/knight'
require_relative 'pieces/pawn'
require_relative 'pieces/queen'
require_relative 'pieces/rook'

require_relative 'general_moves'

class Board

    include GeneralMoves

    attr_reader :board

    def initialize
        @board = Graph.new
        @board.add_node(Node.new("A1"))
        recursive_south(@board.nodes["A1"])
    end
    
    # imagine to start "A1" is the top left corner of a chess board
    # recursively creates the rest of the board given the initial node, moving in the South direction
    def recursive_south(node)
        # get the position of the node and separate into an array
        pos = node.position.chars
        # base case is hardcoded as ["H", "8"]
        # going south, then east for board creation --> check number first
        if pos[1] != "8"
            # recursive call going south
            # change number position, create new node with new position, add to board, move south
            num = pos[1].ord + 1
            s_node = Node.new(pos[0] + num.chr)
            @board.add_node(s_node)
            # handle north - south edges within this call
            @board.create_edge(node, s_node)
            recursive_south(@board.nodes[s_node.position])
        end
        # handle east - west edges in new function
        if pos[0] != "A"
            east_west_edges(node)
        end
        # recursive call moving east
        if pos[1] == "1" && pos[0] != "H"
            recursive_east(node)
        end

    end

    # recursively creates nodes moving in the East direction
    def recursive_east(node)
        # get the position of the node and separate into an array
        pos = node.position.chars
        # immediately want to create and add new node to board
        letter = pos[0].ord + 1
        new_node = Node.new(letter.chr + pos[1])
        @board.add_node(new_node)
        # now call recursive_south with newly created node
        recursive_south(@board.nodes[new_node.position])
    end

    # create an edge from the given node going in the west direction
    def east_west_edges(node)
        pos = node.position.chars
        letter = pos[0].ord - 1
        w_node = @board.nodes[letter.chr + pos[1]]
        @board.create_edge(node, w_node)
    end

    # iterative print function of the board
    def view
        pos = ["A", "8"]
        while pos[1] != "0" do
            while pos[0] != "I" do
                # handle board column legend
                if pos[0] == "A"
                    print pos[1]
                    print " "
                end
                print " "
                piece = @board.nodes[pos.join].piece
                if piece != nil
                    print piece.icon
                else 
                    # print @board.nodes[pos.join].position
                    print "\u25A2".encode
                end
                # print @board.nodes[pos.join].position
                print " "
                letter = pos[0].ord + 1
                pos[0] = letter.chr
            end
            print "\n"
            num = pos[1].ord - 1
            pos[1] = num.chr
            pos[0] = "A"
        end
        # handle board row legend
        letters = ("a".."h")
        print "  "
        letters.each do |let|
            print " "
            print let
            print " "
        end
        print "\n"
    end

    # function that will populate the board with the appropiate pieces, hardcoded
    # white pieces are rows 1 and 2, black is 7 and 8
    # rows 2 and 7 are pawns
    def populate_board
        black = "black"
        white = "white"

        white_pawns = ["A2", "B2", "C2", "D2", "E2", "F2", "G2", "H2"]
        black_pawns = ["A7", "B7", "C7", "D7", "E7", "F7", "G7", "H7"]

        # create white pawns
        white_pawns.each do |pos|
            @board.nodes[pos].piece = create_pawn(white, pos)
        end

        # create white pieces
        @board.nodes["E1"].piece = create_king(white, "E1")
        @board.nodes["D1"].piece = create_queen(white, "D1")
        @board.nodes["C1"].piece = create_bishop(white, "C1")
        @board.nodes["F1"].piece = create_bishop(white, "F1")
        @board.nodes["B1"].piece = create_knight(white, "B1")
        @board.nodes["G1"].piece = create_knight(white, "G1")
        @board.nodes["A1"].piece = create_rook(white, "A1")
        @board.nodes["H1"].piece = create_rook(white, "H1")

        # create black pawns
        black_pawns.each do |pos|
            @board.nodes[pos].piece = create_pawn(black, pos)
        end

        # create black pieces
        @board.nodes["E8"].piece = create_king(black, "E8")
        @board.nodes["D8"].piece = create_queen(black, "D8")
        @board.nodes["C8"].piece = create_bishop(black, "C8")
        @board.nodes["F8"].piece = create_bishop(black, "F8")
        @board.nodes["B8"].piece = create_knight(black, "B8")
        @board.nodes["G8"].piece = create_knight(black, "G8")
        @board.nodes["A8"].piece = create_rook(black, "A8")
        @board.nodes["H8"].piece = create_rook(black, "H8")

    end

    # possible for string parameter to determine the piece to be made?
    def create_bishop(colour, position)
        bishop = Bishop.new(colour, position)
        return bishop
    end
    
    def create_king(colour, position)
        king = King.new(colour, position)
        return king
    end

    def create_knight(colour, position)
        knight = Knight.new(colour, position)
        return knight
    end

    def create_pawn(colour, position)
        pawn = Pawn.new(colour, position)
        return pawn
    end

    def create_queen(colour, position)
        queen = Queen.new(colour, position)
        return queen
    end

    def create_rook(colour, position)
        rook = Rook.new(colour, position)
        return rook
    end 

    def move(pos1, pos2)
        # get thing at pos1, if nil cancel
        node1 = @board.nodes[pos1]
        piece1 = node1.piece

        valid_move = piece1 == nil ? false : piece1.valid_moves.include?(pos2)
        clear_path = validate_path(piece1, pos1, pos2)

        # puts valid_move
        if valid_move && clear_path
            # check if pos2 is occupied with ally piece, enemy piece, nil
            node2 = @board.nodes[pos2]
            finalize_move(node1, node2)
        else 
            # tell user to make a valid move!
            puts "YOURE BAD"
        end
    end

    def validate_path(piece, pos1, pos2)
        diag = ["nw", "ne", "se", "sw"]
        cross = ["n", "e", "s", "w"]

        dir = handle_direction(pos1, pos2)
        
        if diag.include?(dir)
            # diagonal direction
            path = return_diagonal(pos1, dir, Array.new, pos2.split(''))
        elsif cross.include?(dir)
            # cross direction
            path = return_cross(pos1.split(''), dir, Array.new, pos2.split(''))
        else
            # dir is nil and type check knight
        end

        # check every single piece except final to ensure clear path
        clear = true
        path.each do |pos|
            if @board.nodes[pos].piece != nil
                clear = false
            end
        end

        return clear
    end

    def handle_direction(pos_1, pos_2)
        pos1 = pos_1.chars
        pos2 = pos_2.chars

        if pos1[0] == pos2[0] # moving up / down
            res = pos1[1].to_i < pos2[1].to_i ? "n" : "s"
        elsif pos1[1] == pos2[1] # moving left / right
            res = pos1[0].ord < pos2[0].ord ? "w" : "e"
        elsif pos1[0].ord > pos2[0].ord && pos1[1].ord < pos2[1].ord # moving nw
            res = "nw"
        elsif pos1[0].ord < pos2[0].ord && pos1[1].ord < pos2[1].ord # moving ne
            res = "ne"
        elsif pos1[0].ord < pos2[0].ord && pos1[1].ord > pos2[1].ord # moving se
            res = "se"
        elsif pos1[0].ord > pos2[0].ord && pos1[1].ord > pos2[1].ord # moving sw
            res = "sw"
        else
            res = nil
        end
        return res
    end

    def finalize_move(node1, node2)
        piece1 = node1.piece
        if node2.piece == nil # moving to empty spot
            node2.piece = piece1
            piece1.changed_position(node2.position)
            node1.piece = nil
        elsif node2.piece.colour == piece1.colour # spot contains allied piece
            # tell user to make a valid move!
        else # spot contains enemy piece
            node2.piece = piece1
            node1.piece = nil
        end
    end

end

board = Board.new
# bishop = Bishop.new("white", "E5")

board.populate_board
board.view
board.move("A2", "A3")
board.move("A1", "A2")
board.move("A2", "A3")
board.view

# print bishop.valid_moves
# print "\n"
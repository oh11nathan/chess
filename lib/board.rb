
require_relative 'helper_graph'
require_relative 'bishop'
require_relative 'king'
require_relative 'knight'
require_relative 'pawn'
require_relative 'queen'
require_relative 'rook'

class Board

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
    end

    def move(pos1, pos2)
        # determine valid moves of piece contained within position
        # check if pos2 is considered a valid move
        # pos1 which contains node1 --> node1.val = nil
        # pos2 which contains nil/enemy piece now contains node1 --> node2.val = node1
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

end

board = Board.new
# bishop = Bishop.new("white", "E5")

board.populate_board
board.view
# print bishop.valid_moves
# print "\n"
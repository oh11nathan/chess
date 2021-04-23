
require_relative 'helper_graph'
# require_relative 'bishop'

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
                print @board.nodes[pos.join].position
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

end

board = Board.new
# bishop = Bishop.new("white", "E5")

board.view
# print bishop.valid_moves
# print "\n"
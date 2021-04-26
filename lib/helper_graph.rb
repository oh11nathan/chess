
# helper graph class for implementation purposes
# chess board is basically an unweighted, undirected graph
# will utilize adjacency lists

class Node

    attr_reader :position
    attr_reader :adj_nodes

    def initialize(val)
        @position = val
        @adj_nodes = Array.new
        # other variables needed: contains
    end

    # input will be another node object
    # WARNING: because this is undirected graph, if edge is added to node1 going to node 2, 
    # an edge must also be added to node2 going to node1
    def add_edge(node)
        @adj_nodes.push(node.position)
    end

end

class Graph

    attr_reader :nodes

    def initialize
        @nodes = Hash.new
    end

    def add_node(node)
        @nodes[node.position] = node
    end

    # input will be 2 node objects, the edge will be created to connect them
    def create_edge(node1, node2)
        @nodes[node1.position].add_edge(node2)
        @nodes[node2.position].add_edge(node1)
    end

end
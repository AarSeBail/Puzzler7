module Puzzler7

using LinearAlgebra

function add_edge(g, src, dst)
    g[src, dst] = 1
    g[dst, src] = 1
end

function add_complete_subgraph(g, v)
    for a in v
        for b in v
            if a != b
                add_edge(g, a, b)
            end
        end
    end
end

function solve_heptacle()
    g = zeros(Int, 21, 21)

    # Edge indices
    external = collect(1:7)
    middle = collect(8:14)
    internal = collect(15:21)

    # Construct graph
    for i in 1:7
        # Add edges between external vertices
        add_edge(g, external[i], external[(i % 7) + 1])

        # Add internal line
        line_vertices = [
            external[i], middle[i], internal[i],
            internal[i % 7 + 1], middle[(i + 1) % 7 + 1], external[(i + 2) % 7 + 1]
        ]
        add_complete_subgraph(g, line_vertices)
    end

    display(g)

    # There should be 112 edges
    println("$(sum(sum.(g)))")
    @assert sum(sum.(g)) == 112*2

    # Computing vertex-to-vertex 3-walks
    g = g^3

    # Trace
    total_triangles = tr(g)/6
    println("Found $total_triangles total quasi-triangles")

    degenerate_cases = 7*degenerate_triangles(6)
    println("Found $degenerate_cases degenerate cases")

    println("Found $(total_triangles-degenerate_cases) actual triangles")
end

function degenerate_triangles(vertex_count::Int)
    g = ones(Int, vertex_count, vertex_count)
    g = g - I
    g = g^3

    # Trace
    tr(g)/6
end

end # module Puzzler7

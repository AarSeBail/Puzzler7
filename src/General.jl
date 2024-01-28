module General

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

function solve(vertex_count::Int, line_list::Vector{Vector{Int}})
    g = zeros(Int, vertex_count, vertex_count)
    degenerate_cases = 0

    for line in line_list
        add_complete_subgraph(g, line)
        degenerate_cases += degenerate_triangles(length(line))
    end

    g = g^3
    total_triangles = tr(g)/6
    println("Found $total_triangles total quasi-triangles")

    println("Found $degenerate_cases degenerate cases")

    println("Found $(total_triangles-degenerate_cases) actual triangles")
    total_triangles-degenerate_cases
end

function degenerate_triangles(vertex_count::Int)
    g = ones(Int, vertex_count, vertex_count)
    g = g - I
    g = g^3
    tr(g)/6
end

end # module General
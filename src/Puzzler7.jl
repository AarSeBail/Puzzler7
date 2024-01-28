module Puzzler7

include("General.jl")

function solve()
    lines = Vector{Vector{Int}}()

    # Vertex indices
    external = collect(1:7)
    middle = collect(8:14)
    internal = collect(15:21)

    # Construct graph
    for i in 1:7
        # Add edges between external vertices
        push!(lines, [
            external[i],
            external[(i % 7) + 1]
        ])

        # Add internal line
        push!(lines, [
            external[i], middle[i], internal[i],
            internal[i % 7 + 1], middle[(i + 1) % 7 + 1], external[(i + 2) % 7 + 1]
        ])
    end

    General.solve(21, lines)
end

end # module Puzzler7

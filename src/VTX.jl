denominated_price(vtx::VTX) = false

"""$(TYPEDSIGNATURES)

Visualize VTX (Vortex Indicator) using 2 lwc_lines.
"""
function visualize(vtx::VTX, opts::Union{AbstractDict,Nothing}, df::DataFrame)
    plus_kwargs = Dict(
        :label_name => "+VI",
        :line_color => "#4CAF50",
        :line_width => 2
    )
    minus_kwargs = Dict(
        :label_name => "-VI",
        :line_color => "#F44336",
        :line_width => 2
    )
    if opts !== nothing
        if haskey(opts, :plus_vi)
            merge!(plus_kwargs, opts[:plus_vi])
        end
        if haskey(opts, :minus_vi)
            merge!(minus_kwargs, opts[:minus_vi])
        end
    end

    plus_values = replace_missing_with(0, df[!, :vtx_plus_vi])
    minus_values = replace_missing_with(0, df[!, :vtx_minus_vi])

    [
        lwc_line(
            df.ts,
            plus_values;
            plus_kwargs...
        ),
        lwc_line(
            df.ts,
            minus_values;
            minus_kwargs...
        )
    ]
end

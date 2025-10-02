denominated_price(phl::PivotsHL) = true

"""$(TYPEDSIGNATURES)

Visualize PivotsHL using 2 lwc_lines.
"""
function visualize(phl::PivotsHL, opts::Union{AbstractDict,Nothing}, df::DataFrame)
    high_kwargs = Dict(
        :label_name => "Pivot High",
        :line_color => "#F44336",
        :line_width => 2
    )
    low_kwargs = Dict(
        :label_name => "Pivot Low",
        :line_color => "#4CAF50",
        :line_width => 2
    )
    if opts !== nothing
        if haskey(opts, :high)
            merge!(high_kwargs, opts[:high])
        end
        if haskey(opts, :low)
            merge!(low_kwargs, opts[:low])
        end
    end

    high_values = replace_missing_with(0, df[!, :pivotshl_pivot_high])
    low_values = replace_missing_with(0, df[!, :pivotshl_pivot_low])

    [
        lwc_line(
            df.ts,
            high_values;
            high_kwargs...
        ),
        lwc_line(
            df.ts,
            low_values;
            low_kwargs...
        )
    ]
end

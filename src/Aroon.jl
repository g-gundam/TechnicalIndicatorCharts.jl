denominated_price(aroon::Aroon) = false

"""$(TYPEDSIGNATURES)

Visualize Aroon using 2 lwc_lines.
"""
function visualize(aroon::Aroon, opts::Union{AbstractDict,Nothing}, df::DataFrame)
    up_kwargs = Dict(
        :label_name => "Aroon Up",
        :line_color => "#4CAF50",
        :line_width => 2
    )
    down_kwargs = Dict(
        :label_name => "Aroon Down",
        :line_color => "#F44336",
        :line_width => 2
    )
    if opts !== nothing
        if haskey(opts, :up)
            merge!(up_kwargs, opts[:up])
        end
        if haskey(opts, :down)
            merge!(down_kwargs, opts[:down])
        end
    end

    up_values = replace_missing_with(0, df[!, :aroon_up])
    down_values = replace_missing_with(0, df[!, :aroon_down])

    [
        lwc_line(
            df.ts,
            up_values;
            up_kwargs...
        ),
        lwc_line(
            df.ts,
            down_values;
            down_kwargs...
        )
    ]
end

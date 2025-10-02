denominated_price(adx::ADX) = false

"""$(TYPEDSIGNATURES)

Visualize ADX using 3 lwc_lines.
"""
function visualize(adx::ADX, opts::Union{AbstractDict,Nothing}, df::DataFrame)
    adx_kwargs = Dict(
        :label_name => "ADX",
        :line_color => "#2962FF",
        :line_width => 2
    )
    plus_di_kwargs = Dict(
        :label_name => "+DI",
        :line_color => "#4CAF50",
        :line_width => 1
    )
    minus_di_kwargs = Dict(
        :label_name => "-DI",
        :line_color => "#F44336",
        :line_width => 1
    )
    if opts !== nothing
        if haskey(opts, :adx)
            merge!(adx_kwargs, opts[:adx])
        end
        if haskey(opts, :plus_di)
            merge!(plus_di_kwargs, opts[:plus_di])
        end
        if haskey(opts, :minus_di)
            merge!(minus_di_kwargs, opts[:minus_di])
        end
    end

    adx_values = replace_missing_with(0, df[!, :adx_adx])
    plus_di_values = replace_missing_with(0, df[!, :adx_plus_di])
    minus_di_values = replace_missing_with(0, df[!, :adx_minus_di])

    [
        lwc_line(
            df.ts,
            adx_values;
            adx_kwargs...
        ),
        lwc_line(
            df.ts,
            plus_di_values;
            plus_di_kwargs...
        ),
        lwc_line(
            df.ts,
            minus_di_values;
            minus_di_kwargs...
        )
    ]
end

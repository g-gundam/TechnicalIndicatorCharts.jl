denominated_price(stoch::Stoch) = false

"""$(TYPEDSIGNATURES)

Visualize Stochastic Oscillator using 2 lwc_lines.
"""
function visualize(stoch::Stoch, opts::Union{AbstractDict,Nothing}, df::DataFrame)
    k_kwargs = Dict(
        :label_name => "Stoch %K",
        :line_color => "#2962FF",
        :line_width => 2
    )
    d_kwargs = Dict(
        :label_name => "Stoch %D",
        :line_color => "#FF6D00",
        :line_width => 2
    )
    if opts !== nothing
        if haskey(opts, :k)
            merge!(k_kwargs, opts[:k])
        end
        if haskey(opts, :d)
            merge!(d_kwargs, opts[:d])
        end
    end

    k_values = replace_missing_with(0, df[!, :stoch_k])
    d_values = replace_missing_with(0, df[!, :stoch_d])

    [
        lwc_line(
            df.ts,
            k_values;
            k_kwargs...
        ),
        lwc_line(
            df.ts,
            d_values;
            d_kwargs...
        )
    ]
end

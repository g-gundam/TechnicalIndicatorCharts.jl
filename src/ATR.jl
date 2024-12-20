denominated_price(atr::ATR) = false

"""$(TYPEDSIGNATURES)

Visualize ATR using 1 lwc_line.
"""
function visualize(atr::ATR, opts::Union{AbstractDict,Nothing}, df::DataFrame)
    name = indicator_fields(atr)[1]
    kwargs = Dict(
        :label_name => "ATR $(atr.period)",
        :line_color => "#1B9AAA",
        :line_width => 3
    )
    if opts !== nothing
        merge!(kwargs, opts)
    end
    atr = replace_missing_with(0, df[!, name])
    return lwc_line(
        df.ts,
        atr;
        kwargs...
    )
end

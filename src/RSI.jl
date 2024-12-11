denominated_price(rsi::RSI) = false

"""$(TYPEDSIGNATURES)

Visualize RSI using 1 lwc_line.
"""
function visualize(rsi::RSI, opts, df::DataFrame)
    start = rsi.period + 1
    name = indicator_fields(rsi)[1]
    defaults = Dict(
        :label_name => "RSI $(rsi.period)",
        :line_color => "#B84A62",
        :line_width => 3
    )
    kwargs = merge(defaults, Dict(opts))
    rsi = replace_missing_with(0, df[!, name])
    return lwc_line(
        df.ts,
        rsi;
        kwargs...
    )
end

denominated_price(ema::EMA) = true

"""$(TYPEDSIGNATURES)

Visualize EMA using 1 lwc_line.
"""
function visualize(ema::EMA, opts, df::DataFrame)
    start = ema.period
    name = indicator_fields(ema)[1]
    defaults = Dict(
        :label_name => "EMA $(ema.period)",
        :line_color => "#B84A62",
        :line_width => 2
    )
    kwargs = merge(defaults, Dict(opts))
    return lwc_line(
        df.ts[start:end],
        [df[!, name][start:end]...];
        kwargs...
    )
end

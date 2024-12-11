denominated_price(hma::HMA) = true

"""$(TYPEDSIGNATURES)

Visualize HMA using 1 lwc_line.
"""
function visualize(hma::HMA, opts, df::DataFrame)
    start = hma.period
    name = indicator_fields(hma)[1]
    defaults = Dict(
        :label_name => "HMA $(hma.period)",
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

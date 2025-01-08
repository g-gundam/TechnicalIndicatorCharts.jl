denominated_price(tsi::TSI) = false

"""$(TYPEDSIGNATURES)

Visualize True Strength Index (TSI) using 1 lwc_line.
Note that on TradingView, TSI includes a second signal line that is not included here.
"""
function visualize(tsi::TSI, opts::Union{AbstractDict,Nothing}, df::DataFrame)
    name = indicator_fields(tsi)[1]
    kwargs = Dict(
        :label_name => "TSI $(tsi.fast_ma.period)/$(tsi.slow_ma.period)",
        :line_color => "#B84A62",
        :line_width => 3
    )
    if opts !== nothing
        merge!(kwargs, opts)
    end
    tsi = replace_missing_with(0, df[!, name])
    return lwc_line(
        df.ts,
        tsi;
        kwargs...
    )
end

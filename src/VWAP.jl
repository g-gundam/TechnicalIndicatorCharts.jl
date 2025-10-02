denominated_price(vwap::VWAP) = true

"""$(TYPEDSIGNATURES)

Visualize VWAP (Volume Weighted Average Price) using 1 lwc_line.
"""
function visualize(vwap::VWAP, opts::Union{AbstractDict,Nothing}, df::DataFrame)
    name = indicator_fields(vwap)[1]
    kwargs = Dict(
        :label_name => "VWAP",
        :line_color => "#00BCD4",
        :line_width => 2
    )
    if opts !== nothing
        merge!(kwargs, opts)
    end
    values = replace_missing_with(0, df[!, name])
    return lwc_line(
        df.ts,
        values;
        kwargs...
    )
end

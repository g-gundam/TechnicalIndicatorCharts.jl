denominated_price(rsi::RSI) = false

"""$(TYPEDSIGNATURES)

Visualize RSI using 1 lwc_line.
"""
function visualize(rsi::RSI, opts::Union{AbstractDict,Nothing}, df::DataFrame)
    name = indicator_fields(rsi)[1]
    kwargs = Dict(
        :label_name => "RSI $(rsi.period)",
        :line_color => "#B84A62",
        :line_width => 3
    )
    if opts !== nothing
        merge!(kwargs, opts)
    end
    rsi = replace_missing_with(0, df[!, name])
    return lwc_line(
        df.ts,
        rsi;
        kwargs...
    )
end

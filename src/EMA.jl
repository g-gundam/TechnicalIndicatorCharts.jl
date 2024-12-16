denominated_price(ema::EMA) = true

"""$(TYPEDSIGNATURES)

Visualize EMA using 1 lwc_line.
"""
function visualize(ema::EMA, opts::Union{AbstractDict,Nothing}, df::DataFrame)
    start = ema.period
    name = indicator_fields(ema)[1]
    kwargs = Dict(
        :label_name => "EMA $(ema.period)",
        :line_color => "#058ED9",
        :line_width => 2
    )
    if opts !== nothing
        merge!(kwargs, opts)
    end
    return lwc_line(
        df.ts[start:end],
        [df[!, name][start:end]...];
        kwargs...
    )
end

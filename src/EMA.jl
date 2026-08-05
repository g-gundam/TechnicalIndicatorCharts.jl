denominated_price(ema::EMA) = true

"""$(TYPEDSIGNATURES)

Return the default visualization config for EMA.
"""
function config(ema::EMA)
    [lwc_line,
     Dict(
         :label_name => "EMA $(ema.period)",
         :line_color => "#058ED9",
         :line_width => 2
     )]
end

"""$(TYPEDSIGNATURES)

Visualize EMA using 1 lwc_line.
"""
function visualize(ema::EMA, opts::Union{AbstractDict,Nothing}, df::DataFrame)
    start = ema.period
    name = indicator_fields(ema)[1]
    (fn, kwargs) = config(ema)
    if opts !== nothing
        merge!(kwargs, opts)
    end
    return lwc_line(
        df.ts[start:end],
        [df[!, name][start:end]...];
        kwargs...
    )
end

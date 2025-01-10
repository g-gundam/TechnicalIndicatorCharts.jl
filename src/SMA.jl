denominated_price(sma::SMA) = true

function config(sma::SMA)
    [lwc_line,
     Dict(
         :label_name => "SMA $(sma.period)",
         :line_color => "#B84A62",
         :line_width => 2
     )]
end

"""$(TYPEDSIGNATURES)

Return an lwc_line for visualizing an SMA indicator.
"""
function visualize(sma::SMA, opts::Union{AbstractDict,Nothing}, df::DataFrame)
    start = sma.period
    name = indicator_fields(sma)[1]
    (fn, kwargs) = config(sma)
    if opts !== nothing
        merge!(kwargs, opts)
    end
    return lwc_line(
        df.ts[start:end],
        [df[!, name][start:end]...];
        kwargs...
    )
end

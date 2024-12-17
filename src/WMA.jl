denominated_price(wma::WMA) = true

"""$(TYPEDSIGNATURES)

Visualize WMA using 1 lwc_line.
"""
function visualize(wma::WMA, opts::Union{AbstractDict,Nothing}, df::DataFrame)
    start = wma.period
    name = indicator_fields(wma)[1]
    kwargs = Dict(
        :label_name => "WMA $(wma.period)",
        :line_color => "#EAC435",
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

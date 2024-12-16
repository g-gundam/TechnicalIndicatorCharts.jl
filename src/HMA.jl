denominated_price(hma::HMA) = true

"""$(TYPEDSIGNATURES)

Visualize HMA using 1 lwc_line.
"""
function visualize(hma::HMA, opts::Union{AbstractDict,Nothing}, df::DataFrame)
    start = hma.period
    name = indicator_fields(hma)[1]
    kwargs = Dict(
        :label_name => "HMA $(hma.period)",
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

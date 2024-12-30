denominated_price(SMMA::SMMA) = true

"""$(TYPEDSIGNATURES)

Return an lwc_line for visualizing an SMMA indicator.
"""
function visualize(SMMA::SMMA, opts::Union{AbstractDict,Nothing}, df::DataFrame)
    start = SMMA.period
    name = indicator_fields(SMMA)[1]
    kwargs = Dict(
        :label_name => "SMMA $(SMMA.period)",
        :line_color => "#B84A62",
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

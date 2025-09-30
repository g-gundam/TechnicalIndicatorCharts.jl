denominated_price(vwma::VWMA) = true

"""$(TYPEDSIGNATURES)

Visualize VWMA (Volume Weighted Moving Average) using 1 lwc_line.
"""
function visualize(vwma::VWMA, opts::Union{AbstractDict,Nothing}, df::DataFrame)
    name = indicator_fields(vwma)[1]
    kwargs = Dict(
        :label_name => "VWMA $(vwma.period)",
        :line_color => "#8BC34A",
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

denominated_price(md::MeanDev) = false

"""$(TYPEDSIGNATURES)

Visualize MeanDev using 1 lwc_line.
"""
function visualize(md::MeanDev, opts::Union{AbstractDict,Nothing}, df::DataFrame)
    name = indicator_fields(md)[1]
    kwargs = Dict(
        :label_name => "Mean Dev $(md.period)",
        :line_color => "#4682B4",
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

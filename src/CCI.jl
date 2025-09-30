denominated_price(cci::CCI) = false

"""$(TYPEDSIGNATURES)

Visualize CCI (Commodity Channel Index) using 1 lwc_line.
"""
function visualize(cci::CCI, opts::Union{AbstractDict,Nothing}, df::DataFrame)
    name = indicator_fields(cci)[1]
    kwargs = Dict(
        :label_name => "CCI $(cci.period)",
        :line_color => "#9C27B0",
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

denominated_price(cc::CoppockCurve) = false

"""$(TYPEDSIGNATURES)

Visualize CoppockCurve using 1 lwc_line.
"""
function visualize(cc::CoppockCurve, opts::Union{AbstractDict,Nothing}, df::DataFrame)
    name = indicator_fields(cc)[1]
    kwargs = Dict(
        :label_name => "Coppock Curve",
        :line_color => "#8B4513",
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

denominated_price(roc::ROC) = false

"""$(TYPEDSIGNATURES)

Visualize ROC using 1 lwc_line.
"""
function visualize(roc::ROC, opts::Union{AbstractDict,Nothing}, df::DataFrame)
    name = indicator_fields(roc)[1]
    kwargs = Dict(
        :label_name => "ROC $(roc.period)",
        :line_color => "#FF6B6B",
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

denominated_price(sobv::SOBV) = false

"""$(TYPEDSIGNATURES)

Visualize SOBV (Smoothed On Balance Volume) using 1 lwc_line.
"""
function visualize(sobv::SOBV, opts::Union{AbstractDict,Nothing}, df::DataFrame)
    name = indicator_fields(sobv)[1]
    kwargs = Dict(
        :label_name => "SOBV",
        :line_color => "#FF9800",
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

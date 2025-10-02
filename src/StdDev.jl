denominated_price(sd::StdDev) = false

"""$(TYPEDSIGNATURES)

Visualize StdDev using 1 lwc_line.
"""
function visualize(sd::StdDev, opts::Union{AbstractDict,Nothing}, df::DataFrame)
    name = indicator_fields(sd)[1]
    kwargs = Dict(
        :label_name => "Std Dev $(sd.period)",
        :line_color => "#20B2AA",
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

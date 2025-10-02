denominated_price(mi::MassIndex) = false

"""$(TYPEDSIGNATURES)

Visualize MassIndex using 1 lwc_line.
"""
function visualize(mi::MassIndex, opts::Union{AbstractDict,Nothing}, df::DataFrame)
    name = indicator_fields(mi)[1]
    kwargs = Dict(
        :label_name => "Mass Index",
        :line_color => "#3F51B5",
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

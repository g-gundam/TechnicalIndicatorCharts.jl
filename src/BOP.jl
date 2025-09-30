denominated_price(bop::BOP) = false

"""$(TYPEDSIGNATURES)

Visualize BOP (Balance of Power) using 1 lwc_line.
"""
function visualize(bop::BOP, opts::Union{AbstractDict,Nothing}, df::DataFrame)
    name = indicator_fields(bop)[1]
    kwargs = Dict(
        :label_name => "BOP",
        :line_color => "#FF5722",
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

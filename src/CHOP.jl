denominated_price(chop::CHOP) = false

"""$(TYPEDSIGNATURES)

Visualize CHOP (Choppiness Index) using 1 lwc_line.
"""
function visualize(chop::CHOP, opts::Union{AbstractDict,Nothing}, df::DataFrame)
    name = indicator_fields(chop)[1]
    kwargs = Dict(
        :label_name => "CHOP $(chop.period)",
        :line_color => "#795548",
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

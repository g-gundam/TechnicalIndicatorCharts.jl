denominated_price(stc::STC) = false

"""$(TYPEDSIGNATURES)

Visualize STC using 1 lwc_line.
"""
function visualize(stc::STC, opts::Union{AbstractDict,Nothing}, df::DataFrame)
    name = indicator_fields(stc)[1]
    kwargs = Dict(
        :label_name => "STC",
        :line_color => "#DC143C",
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

denominated_price(fi::ForceIndex) = false

"""$(TYPEDSIGNATURES)

Visualize ForceIndex using 1 lwc_line.
"""
function visualize(fi::ForceIndex, opts::Union{AbstractDict,Nothing}, df::DataFrame)
    name = indicator_fields(fi)[1]
    kwargs = Dict(
        :label_name => "Force Index",
        :line_color => "#E91E63",
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

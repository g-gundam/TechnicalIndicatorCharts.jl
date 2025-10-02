denominated_price(ad::AccuDist) = false

"""$(TYPEDSIGNATURES)

Visualize AccuDist (Accumulation/Distribution) using 1 lwc_line.
"""
function visualize(ad::AccuDist, opts::Union{AbstractDict,Nothing}, df::DataFrame)
    name = indicator_fields(ad)[1]
    kwargs = Dict(
        :label_name => "A/D",
        :line_color => "#4CAF50",
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

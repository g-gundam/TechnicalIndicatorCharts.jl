denominated_price(kvo::KVO) = false

"""$(TYPEDSIGNATURES)

Visualize KVO (Klinger Volume Oscillator) using 1 lwc_line.
"""
function visualize(kvo::KVO, opts::Union{AbstractDict,Nothing}, df::DataFrame)
    name = indicator_fields(kvo)[1]
    kwargs = Dict(
        :label_name => "KVO",
        :line_color => "#673AB7",
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

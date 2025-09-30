denominated_price(uo::UO) = false

"""$(TYPEDSIGNATURES)

Visualize UO (Ultimate Oscillator) using 1 lwc_line.
"""
function visualize(uo::UO, opts::Union{AbstractDict,Nothing}, df::DataFrame)
    name = indicator_fields(uo)[1]
    kwargs = Dict(
        :label_name => "UO",
        :line_color => "#CDDC39",
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

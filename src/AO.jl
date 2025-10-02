denominated_price(ao::AO) = false

"""$(TYPEDSIGNATURES)

Visualize AO (Awesome Oscillator) using 1 lwc_line.
"""
function visualize(ao::AO, opts::Union{AbstractDict,Nothing}, df::DataFrame)
    name = indicator_fields(ao)[1]
    kwargs = Dict(
        :label_name => "AO",
        :line_color => "#00BCD4",
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

denominated_price(co::ChaikinOsc) = false

"""$(TYPEDSIGNATURES)

Visualize ChaikinOsc (Chaikin Oscillator) using 1 lwc_line.
"""
function visualize(co::ChaikinOsc, opts::Union{AbstractDict,Nothing}, df::DataFrame)
    name = indicator_fields(co)[1]
    kwargs = Dict(
        :label_name => "Chaikin Osc",
        :line_color => "#009688",
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

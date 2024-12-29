denominated_price(obv::OBV) = false

"""$(TYPEDSIGNATURES)

Visualize On Balance Volume (OBV) using 1 lwc_line.
"""
function visualize(obv::OBV, opts::Union{AbstractDict,Nothing}, df::DataFrame)
    name = indicator_fields(obv)[1]
    kwargs = Dict(
        :label_name => "OBV",
        :line_color => "#2962ff",
        :line_width => 2
    )
    if opts !== nothing
        merge!(kwargs, opts)
    end
    obv = replace_missing_with(0, df[!, name])
    return lwc_line(
        df.ts,
        obv;
        kwargs...
    )
end

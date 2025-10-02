denominated_price(emv::EMV) = false

"""$(TYPEDSIGNATURES)

Visualize EMV (Ease of Movement) using 1 lwc_line.
"""
function visualize(emv::EMV, opts::Union{AbstractDict,Nothing}, df::DataFrame)
    name = indicator_fields(emv)[1]
    kwargs = Dict(
        :label_name => "EMV",
        :line_color => "#607D8B",
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

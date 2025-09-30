denominated_price(trix::TRIX) = false

"""$(TYPEDSIGNATURES)

Visualize TRIX using 1 lwc_line.
"""
function visualize(trix::TRIX, opts::Union{AbstractDict,Nothing}, df::DataFrame)
    name = indicator_fields(trix)[1]
    kwargs = Dict(
        :label_name => "TRIX $(trix.period)",
        :line_color => "#32CD32",
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

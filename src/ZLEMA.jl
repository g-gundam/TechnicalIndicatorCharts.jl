denominated_price(zlema::ZLEMA) = true

"""$(TYPEDSIGNATURES)

Visualize ZLEMA using 1 lwc_line.
"""
function visualize(zlema::ZLEMA, opts::Union{AbstractDict,Nothing}, df::DataFrame)
    start = zlema.period
    name = indicator_fields(zlema)[1]
    kwargs = Dict(
        :label_name => "ZLEMA $(zlema.period)",
        :line_color => "#FFD700",
        :line_width => 2
    )
    if opts !== nothing
        merge!(kwargs, opts)
    end
    return lwc_line(
        df.ts[start:end],
        replace_missing_with(0, df[!, name][start:end]);
        kwargs...
    )
end

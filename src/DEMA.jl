denominated_price(dema::DEMA) = true

"""$(TYPEDSIGNATURES)

Visualize DEMA using 1 lwc_line.
"""
function visualize(dema::DEMA, opts::Union{AbstractDict,Nothing}, df::DataFrame)
    name = indicator_fields(dema)[1]
    start = findfirst(!ismissing, df[!, name])
    kwargs = Dict(
        :label_name => "DEMA $(dema.period)",
        :line_color => "#058ED9",
        :line_width => 2
    )
    if opts !== nothing
        merge!(kwargs, opts)
    end
    return lwc_line(
        df.ts[start:end],
        [df[!, name][start:end]...];
        kwargs...
    )
end

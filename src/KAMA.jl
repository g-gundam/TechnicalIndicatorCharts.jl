denominated_price(kama::KAMA) = true

"""$(TYPEDSIGNATURES)

Visualize KAMA using 1 lwc_line.
"""
function visualize(kama::KAMA, opts::Union{AbstractDict,Nothing}, df::DataFrame)
    start = kama.period
    name = indicator_fields(kama)[1]
    kwargs = Dict(
        :label_name => "KAMA $(kama.period)",
        :line_color => "#FFA500",
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

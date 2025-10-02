denominated_price(st::SuperTrend) = true

"""$(TYPEDSIGNATURES)

Visualize SuperTrend using 1 lwc_line.
"""
function visualize(st::SuperTrend, opts::Union{AbstractDict,Nothing}, df::DataFrame)
    kwargs = Dict(
        :label_name => "SuperTrend",
        :line_color => "#9C27B0",
        :line_width => 2
    )
    if opts !== nothing
        merge!(kwargs, opts)
    end

    values = replace_missing_with(0, df[!, :supertrend_super_trend])

    lwc_line(
        df.ts,
        values;
        kwargs...
    )
end

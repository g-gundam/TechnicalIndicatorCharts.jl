denominated_price(bb::BB)   = true

"""$(TYPEDSIGNATURES)

Visualize Bollinger Bands using 3 lwc_lines.
"""
function visualize(bb::BB, opts, df::DataFrame)
    start = bb.period
    upper_defaults = Dict(
        :label_name => "BB upper",
        :line_color => "#4C5454",
        :line_width => 3
    )
    upper_kwargs = merge(upper_defaults, opts[:upper])
    central_defaults = Dict(
        :label_name => "BB central",
        :line_color => "#FF715B",
        :line_width => 1
    )
    central_kwargs = merge(central_defaults, opts[:central])
    lower_defaults = Dict(
        :label_name => "BB lower",
        :line_color => "#4C5454",
        :line_width => 2
    )
    lower_kwargs = merge(lower_defaults, opts[:lower])
    # [2024-07-12 Fri 08:08] This is the first visualization to combine multiple LWCCharts into one.
    [
        lwc_line(
            df.ts[start:end],
            [df[!, :bb_upper][start:end]...];
            upper_kwargs...
        ),
        lwc_line(
            df.ts[start:end],
            [df[!, :bb_central][start:end]...];
            central_kwargs...
        ),
        lwc_line(
            df.ts[start:end],
            [df[!, :bb_lower][start:end]...];
            lower_kwargs...
        ),
    ]
end

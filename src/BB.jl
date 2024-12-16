denominated_price(bb::BB)   = true

"""$(TYPEDSIGNATURES)

Visualize Bollinger Bands using 3 lwc_lines.
"""
function visualize(bb::BB, opts::Union{AbstractDict,Nothing}, df::DataFrame)
    start = bb.period
    upper_kwargs = Dict(
        :label_name => "BB upper",
        :line_color => "#4C5454",
        :line_width => 3
    )
    central_kwargs = Dict(
        :label_name => "BB central",
        :line_color => "#FF715B",
        :line_width => 1
    )
    lower_kwargs = Dict(
        :label_name => "BB lower",
        :line_color => "#4C5454",
        :line_width => 2
    )
    if opts !== nothing
        if haskey(opts, :upper)
            merge!(upper_kwargs, opts[:upper])
        end
        if haskey(opts, :central)
            merge!(central_kwargs, opts[:central])
        end
        if haskey(opts, :lower)
            merge!(lower_kwargs, opts[:lower])
        end
    end
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

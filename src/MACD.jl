denominated_price(macd::MACD) = false

"""$(TYPEDSIGNATURES)

Visualize MACD using 2 lwc_lines and 1 histogram.
"""
function visualize(macd::MACD, opts::Union{AbstractDict,Nothing}, df::DataFrame)
    macd_kwargs = Dict(
        :label_name => "MACD",
        :line_color => "#2962FF",
        :line_width => 2
    )
    signal_kwargs = Dict(
        :label_name => "Signal",
        :line_color => "#FF6D00",
        :line_width => 2
    )
    histogram_kwargs = Dict(
        :label_name => "Histogram",
        :color => "#26A69A"
    )
    if opts !== nothing
        if haskey(opts, :macd)
            merge!(macd_kwargs, opts[:macd])
        end
        if haskey(opts, :signal)
            merge!(signal_kwargs, opts[:signal])
        end
        if haskey(opts, :histogram)
            merge!(histogram_kwargs, opts[:histogram])
        end
    end

    macd_values = replace_missing_with(0, df[!, :macd_macd])
    signal_values = replace_missing_with(0, df[!, :macd_signal])
    #histogram_values = replace_missing_with(0, df[!, :macd_histogram])
    histogram_values = map(df.ts, df.macd_histogram) do ts, h
        val = if ismissing(h) 0.0 else h end
        kwargs = if val < 0
            Dict(:color => "#DB7F8E")
        else
            Dict(:color => histogram_kwargs[:color])
        end
        LWCSimpleChartItem(ts, val; kwargs...)
    end

    [
        lwc_line(
            df.ts,
            macd_values;
            macd_kwargs...
        ),
        lwc_line(
            df.ts,
            signal_values;
            signal_kwargs...
        ),
        lwc_histogram(
            histogram_values;
            histogram_kwargs...
        )
    ]
end

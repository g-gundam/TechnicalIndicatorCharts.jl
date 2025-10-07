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
        :label_name     => "Histogram",
        :color          => "#26A69A",
        :color_negative => "#DB7F8E"
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
    histogram_values = map(df.ts, df.macd_histogram) do ts, h
        val = if ismissing(h) 0.0 else h end
        kwargs = if val < 0
            # negative red
            Dict(:color => histogram_kwargs[:color_negative])
        else
            # postivie green
            Dict(:color => histogram_kwargs[:color])
        end
        LWCSimpleChartItem(ts, val; kwargs...)
    end
    # remove :color_negative before passing to lwc_histogram
    new_histogram_kwargs = @chain histogram_kwargs pairs filter(kv -> kv[1] != :color_negative, _)

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
            new_histogram_kwargs...
        )
    ]
end

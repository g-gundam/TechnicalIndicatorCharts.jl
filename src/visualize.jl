# - If an indicator is denominated in price,     it gets plotted along with price in the same panel.
# - If an indicator is not denominated in price, it gets plotted in its own panel.
denominated_price(any::Any) = false # If we don't know, assume false.
denominated_price(sma::SMA) = true
denominated_price(ema::EMA) = true
denominated_price(rsi::RSI) = false
denominated_price(bb::BB)   = true
denominated_price(srsi::StochRSI) = false


"""    visualize(any::Any)

This is a visualize method that's a catch-all for indicators
that haven't had a visualize method made for them yet.  For now,
it returns an empty panel.
"""
function visualize(unimplemented::Any, opts, df::DataFrame)
    @warn "Unimplemented Visualization" typeof(unimplemented)
    missing
end

"""    visualize(sma::SMA)

Return an lwc_line for visualizing an SMA indicator.
"""
function visualize(sma::SMA, opts, df::DataFrame)
    start = sma.period
    name = indicator_fields(sma)[1]
    defaults = Dict(
        :label_name => "SMA",
        :line_color => "#B84A62",
        :line_width => 2
    )
    kwargs = merge(defaults, Dict(opts))
    return lwc_line(
        df.ts[start:end],
        [df[!, name][start:end]...];
        kwargs...
    )
end

function visualize(ema::EMA, opts, df::DataFrame)
    start = ema.period
    name = indicator_fields(ema)[1]
    defaults = Dict(
        :label_name => "EMA",
        :line_color => "#B84A62",
        :line_width => 2
    )
    kwargs = merge(defaults, Dict(opts))
    return lwc_line(
        df.ts[start:end],
        [df[!, name][start:end]...];
        kwargs...
    )
end

function visualize(rsi::RSI, opts, df::DataFrame)
    start = rsi.period + 1
    name = indicator_fields(rsi)[1]
    defaults = Dict(
        :label_name => "RSI",
        :line_color => "#B84A62",
        :line_width => 3
    )
    kwargs = merge(defaults, Dict(opts))
    return lwc_line(
        df.ts[start:end],
        [df[!, name][start:end]...];
        kwargs...
    )
end

function visualize(srsi::StochRSI, opts, df::DataFrame)
    start = srsi.stoch_period
    k_defaults = Dict(
        :label_name => "K",
        :line_color => "#2962FF",
        :line_width => 1
    )
    k_kwargs = merge(k_defaults, opts[:k])
    d_defaults = Dict(
        :label_name => "D",
        :line_color => "#FF6D00",
        :line_width => 1
    )
    d_kwargs = merge(d_defaults, opts[:d])
    [
        lwc_line(
            df.ts[start:end],
            [df[!, :stochrsi_k][start:end]...];
            k_kwargs...
        ),
        lwc_line(
            df.ts[start:end],
            [df[!, :stochrsi_d][start:end]...];
            d_kwargs...
        )
    ]
end

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

function visualize(df::DataFrame, opts)
    candles = map(r -> LWCCandleChartItem(r.ts, r.o, r.h, r.l, r.c), eachrow(df))
    lwc_candlestick(
        candles;
        opts...
    )
end

"""    visualize(chart::Chart)

Return an LWCLayout that visualizes all the components in chart appropriately.
"""
function visualize(chart::Chart)
    opts = Dict(
        :label_name     => "$(chart.name) $(abbrev(chart.tf))",
        :up_color       => "#52a49a",
        :down_color     => "#de5e57",
        :border_visible => false,
        :price_scale_id => LWC_LEFT,
    )
    candlesticks = visualize(chart.df, opts)
    plots = visualize.(chart.indicators, chart.visuals, Ref(chart.df))
    denom = denominated_price.(chart.indicators)
    plots_price = []
    plots_other = []
    for (p, d) in zip(plots, denom) # If there's a better way, let me know.
        ismissing(p) && continue
        if d == 1
            if typeof(p) <: Vector
                push!(plots_price, p...)
            else
                push!(plots_price, p)
            end
        else
            if typeof(p) <: Vector
                push!(plots_other, p...)
            else
                push!(plots_other, p)
            end
        end
    end
    return lwc_layout(
        # indicators denominated in price all go in one panel along with the candlesticks.
        lwc_panel(
            candlesticks,
            plots_price...
        ),
        # indicators that are not denominated in price get their own panel.
        lwc_panel.(plots_other)...;
        
    )
end

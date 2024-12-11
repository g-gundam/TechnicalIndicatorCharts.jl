# - If an indicator is denominated in price,     it gets plotted along with price in the same panel.
# - If an indicator is not denominated in price, it gets plotted in its own panel.
denominated_price(any::Any) = false # If we don't know, assume false.
denominated_price(sma::SMA) = true
denominated_price(ema::EMA) = true
denominated_price(hma::HMA) = true
denominated_price(rsi::RSI) = false
denominated_price(bb::BB)   = true
denominated_price(srsi::StochRSI) = false


"""$(TYPEDSIGNATURES)

This is a visualize method that's a catch-all for indicators
that haven't had a visualize method made for them yet.  For now,
it returns `missing`.
"""
function visualize(unimplemented::Any, opts, df::DataFrame)
    @warn "Unimplemented Visualization" typeof(unimplemented)
    missing
end

"""$(TYPEDSIGNATURES)

Return an lwc_line for visualizing an SMA indicator.
"""
function visualize(sma::SMA, opts, df::DataFrame)
    start = sma.period
    name = indicator_fields(sma)[1]
    defaults = Dict(
        :label_name => "SMA $(sma.period)",
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

"""$(TYPEDSIGNATURES)

Visualize EMA using 1 lwc_line.
"""
function visualize(ema::EMA, opts, df::DataFrame)
    start = ema.period
    name = indicator_fields(ema)[1]
    defaults = Dict(
        :label_name => "EMA $(ema.period)",
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

"""$(TYPEDSIGNATURES)

Visualize HMA using 1 lwc_line.
"""
function visualize(hma::HMA, opts, df::DataFrame)
    start = hma.period
    name = indicator_fields(hma)[1]
    defaults = Dict(
        :label_name => "HMA $(hma.period)",
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

"""$(TYPEDSIGNATURES)

Visualize RSI using 1 lwc_line.
"""
function visualize(rsi::RSI, opts, df::DataFrame)
    start = rsi.period + 1
    name = indicator_fields(rsi)[1]
    defaults = Dict(
        :label_name => "RSI $(rsi.period)",
        :line_color => "#B84A62",
        :line_width => 3
    )
    kwargs = merge(defaults, Dict(opts))
    rsi = replace_missing_with(0, df[!, name])
    return lwc_line(
        df.ts,
        rsi;
        kwargs...
    )
end

# TODO: There's probably a fancy way to wrap the collection in a type
# so that copying the data via map could be avoided.
function replace_missing_with(val, collection)
    map(n -> if ismissing(n) val else n end, collection)
end

"""$(TYPEDSIGNATURES)

Visualize StochRSI using 2 lwc_lines.
"""
function visualize(srsi::StochRSI, opts, df::DataFrame)
    k_defaults = Dict(
        :label_name => "StochRSI K",
        :line_color => "#2962FF",
        :line_width => 1,
        :line_type  => LWC_CURVED
    )
    k_kwargs = merge(k_defaults, opts[:k])
    k_start = findfirst(!ismissing, df[!, :stochrsi_k])
    d_defaults = Dict(
        :label_name => "StochRSI D",
        :line_color => "#FF6D00",
        :line_width => 1,
        :line_type  => LWC_CURVED,
    )
    d_kwargs = merge(d_defaults, opts[:d])
    d_start = findfirst(!ismissing, df[!, :stochrsi_d])
    #@info "start" k_start d_start
    k = replace_missing_with(0, df[!, :stochrsi_k])
    #k = Padded(df[!, :stochrsi_k])
    d = replace_missing_with(0, df[!, :stochrsi_d])
    #d = Padded(df[!, :stochrsi_d])
    [
        lwc_line(
            df.ts,
            k;
            k_kwargs...
        ),
        lwc_line(
            df.ts,
            d;
            d_kwargs...
        )
    ]
end

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

"""$(TYPEDSIGNATURES)

Visualize a DataFrame using lwc_candlestick.
"""
function visualize(df::DataFrame, opts)
    candles = map(r -> LWCCandleChartItem(r.ts, r.o, r.h, r.l, r.c), eachrow(df))
    lwc_candlestick(
        candles;
        opts...
    )
end

"""$(TYPEDSIGNATURES)

Wrap a Vector of LWCCharts in a panel.
"""
function make_panel(plots::Vector)
    lwc_panel(plots...)
end

"""$(TYPEDSIGNATURES)

Wrap a single LWCChart in a panel.
"""
function make_panel(chart::LWCChart)
    lwc_panel(chart)
end

"""$(TYPEDSIGNATURES)

Return an LWCLayout that visualizes all the components in chart appropriately.
"""
function visualize(chart::Chart;
                   min_height=550,
                   mode::LWC_PRICE_SCALE_MODE=LWC_LOGARITHMIC,
                   up_color="#42a49a",
                   down_color="#de5e57")
    opts = Dict(
        :label_name     => "$(chart.name) $(abbrev(chart.tf))",
        :up_color       => up_color,
        :down_color     => down_color,
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
            # denominated in price -- I couldn't use polymorphism here.
            if typeof(p) <: Vector
                push!(plots_price, p...)
            else
                push!(plots_price, p)
            end
        else
            # not denominated in price
            push!(plots_other, p)
        end
    end
    @debug "plots_other" plots_other
    return lwc_layout(
        # indicators denominated in price all go in one panel along with the candlesticks.
        lwc_panel(
            candlesticks,
            plots_price...;
            mode
        ),
        # indicators that are not denominated in price get their own panel.
        make_panel.(plots_other)...;
        min_height
    )
end

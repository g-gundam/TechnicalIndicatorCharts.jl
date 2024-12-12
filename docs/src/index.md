# TechnicalIndicatorCharts

A library for 
visualizing [OnlineTechnicalIndicators.jl](https://github.com/femtotrader/OnlineTechnicalIndicators.jl) 
using [LightweightCharts.jl](https://github.com/bhftbootcamp/LightweightCharts.jl)

## First, what is a chart?

A Chart is a mutable struct that has:

- a name (typically of the asset like "BTCUSD" or "AAPL")
- a timeframe (which controls how much time each candle on the chart represents)
- a DataFrame to hold OHLCV values and indicator values
- a Vector of `OnlineTechnicalIndicator`s to display on the chart.
- another Vector of display configuration for each indicator.

If you were to go to [TradingView](https://tradingview.com/) and look at a chart, 
imagine what kind of data structure would be required to represent it in memory.
That's what the `Chart` struct aims to be.

## Constructing a Chart

Charts are constructed using the `chart(name, timeframe; indicators, visuals)` function.

```julia
using OnlineTechnicalIndicators
using LightweightCharts
using TechnicalIndicatorCharts

# If you just want candles, you can omit `indicators` and `visuals`.
just_candles_1m = chart("BTCUSD", Minute(1))
```


## Updating a Chart

## Visualizing a Chart


----

That's all there is to it.

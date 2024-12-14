# TechnicalIndicatorCharts

A library for 
visualizing [OnlineTechnicalIndicators.jl](https://github.com/femtotrader/OnlineTechnicalIndicators.jl) 
using [LightweightCharts.jl](https://github.com/bhftbootcamp/LightweightCharts.jl)

## What is a Chart?

A Chart is a mutable struct that has:

- a name (typically of the asset like "BTCUSD" or "AAPL")
- a timeframe (which controls how much time each candle on the chart represents)
- a DataFrame to hold OHLCV values and indicator values
- a Vector of `OnlineTechnicalIndicator`s to display on the chart.
- another Vector of display configuration for each indicator.

If you were to go to [TradingView](https://tradingview.com/) and look at a chart, 
imagine what kind of data structure would be required to represent it in memory.
That's what the `Chart` struct aims to be.

## Creating a Chart

```julia
using OnlineTechnicalIndicators
using TechnicalIndicatorCharts

golden_cross_chart = Chart(
    "AAPL", Week(1);
    indicators = [
        SMA{Float64}(;period=50),         # Setup indicators
        SMA{Float64}(;period=200)
    ],
    visuals = [
        Dict(
            :label_name => "SMA 50",      # Describe how to draw indicators
            :line_color => "#E072A4",
            :line_width => 2
        ),
        Dict(
            :label_name => "SMA 200",
            :line_color => "#3D3B8E",
            :line_width => 5
        )
    ]
)
```

## Feeding Your Chart Data

Adding new data to the chart is done with the `update!(chart, candle)` function.

```julia
using MarketData

for row in eachrow(AAPL)
    c = Candle(
      ts=DateTime(row.timestamp),
      o=row.Open,
      h=row.High,
      l=row.Low,
      c=row.Close,
      v=row.Volume
    )
    update!(golden_cross_chart, c)
end
```

Notice that `update!` took daily candles from `AAPL` and aggregated them into weekly candles.

> The `update!` function was designed to consume low timeframe candles to incrementally build higher timeframe charts.  Imagine unfinished 1m candles from a websocket being consumed to generate multiple higher-timeframe views of a single market.  The hope was that this would facilitate realtime, multi-timeframe analysis.

## Visualization

The `visualize` function will take a chart and generate something that `lwc_show` from [LightweightCharts.jl](https://github.com/bhftbootcamp/LightweightCharts.jl) can display.

```julia
using LightweightCharts

lwc_show(visualize(golden_cross_chart))
# Or
golden_cross_chart |> visualize |> lwc_show
```

![aapl](https://raw.githubusercontent.com/g-gundam/TechnicalIndicatorCharts.jl/refs/heads/main/lwc_show.png)

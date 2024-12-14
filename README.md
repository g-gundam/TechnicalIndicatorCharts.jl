# TechnicalIndicatorCharts

[![Dev](https://img.shields.io/badge/docs-dev-blue.svg)](https://g-gundam.github.io/TechnicalIndicatorCharts.jl/dev/)
[![Build Status](https://github.com/g-gundam/TechnicalIndicatorCharts.jl/actions/workflows/CI.yml/badge.svg?branch=main)](https://github.com/g-gundam/TechnicalIndicatorCharts.jl/actions/workflows/CI.yml?query=branch%3Amain)
[![Coverage](https://codecov.io/gh/g-gundam/TechnicalIndicatorCharts.jl/branch/main/graph/badge.svg)](https://codecov.io/gh/g-gundam/TechnicalIndicatorCharts.jl)

The purpose of this library is to bring
[OnlineTechnicalIndicators.jl](https://github.com/femtotrader/OnlineTechnicalIndicators.jl) and
[LightweightCharts.jl](https://github.com/bhftbootcamp/LightweightCharts.jl) together.

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

> The `update!` function was designed to consume low timeframe candles to incrementally build higher timeframe charts.  Imagine unfinished 1m candles from a websocket being consumed to generate multiple higher-timeframe charts for the same market.  The hope was that this would facilitate realtime, multi-timeframe analysis.

## Visualization

The `visualize` function will take a chart and generate something that `lwc_show` from [LightweightCharts.jl](https://github.com/bhftbootcamp/LightweightCharts.jl) can display.

```julia
using LightweightCharts

lwc_show(visualize(golden_cross_chart))
# Or
golden_cross_chart |> visualize |> lwc_show
```

![aapl](https://raw.githubusercontent.com/g-gundam/TechnicalIndicatorCharts.jl/refs/heads/main/lwc_show.png)

## Supported Indicators

- [ ] AccuDist
- [ ] ADX
- [ ] ALMA
- [ ] AO
- [ ] Aroon
- [ ] ATR
- [x] BB
- [ ] BOP
- [ ] CCI
- [ ] ChaikinOsc
- [ ] ChandeKrollStop
- [ ] CHOP
- [ ] CoppockCurve
- [ ] DEMA
- [ ] DonchianChannels
- [ ] DPO
- [x] EMA
- [ ] EMV
- [ ] ForceIndex
- [x] HMA
- [ ] KAMA
- [ ] KeltnerChannels
- [ ] KST
- [ ] KVO
- [ ] MACD
- [ ] MassIndex
- [ ] McGinleyDynamic
- [ ] MeanDev
- [ ] OBV
- [ ] ParabolicSAR
- [ ] PivotsHL
- [ ] ROC
- [x] RSI
- [ ] SFX
- [x] SMA
- [ ] SMMA
- [ ] SOBV
- [ ] STC
- [ ] StdDev
- [ ] Stoch
- [x] StochRSI
- [ ] SuperTrend
- [ ] T3
- [ ] TEMA
- [ ] TRIX
- [ ] TrueRange
- [ ] TSI
- [ ] TTM
- [ ] UO
- [ ] VTX
- [ ] VWAP
- [ ] VWMA
- [ ] WMA
- [ ] ZLEMA

See Also:  [Indicators support - OnlineTechnicalIndicators.jl](https://femtotrader.github.io/OnlineTechnicalIndicators.jl/dev/indicators_support/)

Help Wanted:  [Visualization Function Writers](https://g-gundam.github.io/TechnicalIndicatorCharts.jl/dev/indicators/)

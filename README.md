# TechnicalIndicatorCharts

[![Dev](https://img.shields.io/badge/docs-dev-blue.svg)](https://g-gundam.github.io/TechnicalIndicatorCharts.jl/dev/)
[![Build Status](https://github.com/g-gundam/TechnicalIndicatorCharts.jl/actions/workflows/CI.yml/badge.svg?branch=main)](https://github.com/g-gundam/TechnicalIndicatorCharts.jl/actions/workflows/CI.yml?query=branch%3Amain)
[![Coverage](https://codecov.io/gh/g-gundam/TechnicalIndicatorCharts.jl/branch/main/graph/badge.svg)](https://codecov.io/gh/g-gundam/TechnicalIndicatorCharts.jl)

Visualize
[OnlineTechnicalIndicators.jl](https://github.com/femtotrader/OnlineTechnicalIndicators.jl) using
[LightweightCharts.jl](https://github.com/bhftbootcamp/LightweightCharts.jl).

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

- [x] [AccuDist](https://www.tradingview.com/support/solutions/43000501770-accumulation-distribution-adl/)
- [x] [ADX](https://www.tradingview.com/support/solutions/43000589099-average-directional-index-adx/)
- [x] [ALMA](https://www.tradingview.com/support/solutions/43000594683-arnaud-legoux-moving-average/)
- [x] [AO](https://www.tradingview.com/support/solutions/43000501826-awesome-oscillator-ao/)
- [x] [Aroon](https://www.tradingview.com/support/solutions/43000501801-aroon/)
- [x] [ATR](https://www.tradingview.com/support/solutions/43000501823-average-true-range-atr/)
- [x] [BB](https://www.tradingview.com/support/solutions/43000501840-bollinger-bands-bb/)
- [x] [BOP](https://www.tradingview.com/support/solutions/43000589100-balance-of-power-bop/)
- [x] [CCI](https://www.tradingview.com/support/solutions/43000502001-commodity-channel-index-cci/)
- [x] [ChaikinOsc](https://www.tradingview.com/support/solutions/43000501979-chaikin-oscillator/)
- [x] [ChandeKrollStop](https://www.tradingview.com/support/solutions/43000589105-chande-kroll-stop/)
- [x] [CHOP](https://www.tradingview.com/support/solutions/43000589111-chop-zone/)
- [x] [CoppockCurve](https://www.tradingview.com/support/solutions/43000589114-coppock-curve/)
- [x] [DEMA](https://www.tradingview.com/support/solutions/43000589132-double-exponential-moving-average-ema/)
- [x] [DonchianChannels](https://www.tradingview.com/support/solutions/43000502253-donchian-channels-dc/)
- [x] [DPO](https://www.tradingview.com/support/solutions/43000502246-detrended-price-oscillator-dpo/)
- [x] [EMA](https://www.tradingview.com/support/solutions/43000592270-exponential-moving-average/)
- [x] [EMV](https://www.tradingview.com/support/solutions/43000502256-ease-of-movement-eom/)
- [x] [ForceIndex](https://www.tradingview.com/support/solutions/43000502259-elder-s-force-index-efi/)
- [x] [HMA](https://www.tradingview.com/support/solutions/43000589149-hull-moving-average/)
- [x] [KAMA](https://www.tradingview.com/script/YoVbxCeX-Kaufman-s-Adaptive-Moving-Average-KAMA/)
- [x] [KeltnerChannels](https://www.tradingview.com/support/solutions/43000502266-keltner-channels-kc/)
- [x] [KST](https://www.tradingview.com/support/solutions/43000502329-know-sure-thing-kst/)
- [x] [KVO](https://www.tradingview.com/support/solutions/43000589157-klinger-oscillator/)
- [x] [MACD](https://www.tradingview.com/support/solutions/43000502344-macd-moving-average-convergence-divergence/)
- [x] [MassIndex](https://www.tradingview.com/support/solutions/43000589169-mass-index/)
- [x] [McGinleyDynamic](https://www.tradingview.com/support/solutions/43000589175-mcginley-dynamic/)
- [x] MeanDev
- [ ] NATR
- [x] [OBV](https://www.tradingview.com/support/solutions/43000502593-on-balance-volume-obv/)
- [x] [ParabolicSAR](https://www.tradingview.com/support/solutions/43000502597-parabolic-sar-sar/)
- [x] [PivotsHL](https://www.tradingview.com/support/solutions/43000589195-pivot-points-high-low/)
- [x] [ROC](https://www.tradingview.com/support/solutions/43000502343-rate-of-change-roc/)
- [x] [RSI](https://www.tradingview.com/support/solutions/43000502338-relative-strength-index-rsi/)
- [ ] SFX
- [x] [SMA](https://www.tradingview.com/support/solutions/43000696841-simple-moving-average/)
- [x] [SMMA](https://www.tradingview.com/support/solutions/43000591343-smoothed-moving-average/)
- [x] SOBV
- [x] STC
- [x] StdDev
- [x] [Stoch](https://www.tradingview.com/support/solutions/43000502332-stochastic-stoch/)
- [x] [StochRSI](https://www.tradingview.com/support/solutions/43000502333-stochastic-rsi-stoch-rsi/)
- [x] [SuperTrend](https://www.tradingview.com/support/solutions/43000634738-supertrend/)
- [x] [T3](https://www.tradingview.com/script/hvVCxPmR-Tillson-T3-Moving-Average-improved/)
- [x] [TEMA](https://www.tradingview.com/support/solutions/43000591346-triple-ema/)
- [x] [TRIX](https://www.tradingview.com/support/solutions/43000502331-trix/)
- [ ] TrueRange
- [x] [TSI](https://www.tradingview.com/support/solutions/43000592290-true-strength-index/)
- [x] TTM
- [x] [UO](https://www.tradingview.com/support/solutions/43000502328-ultimate-oscillator-uo/)
- [x] [VTX](https://www.tradingview.com/support/solutions/43000591352-vortex-indicator/)
- [x] [VWAP](https://www.tradingview.com/support/solutions/43000502018-volume-weighted-average-price-vwap/)
- [x] [VWMA](https://www.tradingview.com/support/solutions/43000592293-volume-weighted-moving-average-vwma/)
- [x] [WMA](https://www.tradingview.com/support/solutions/43000594680-weighted-moving-average/)
- [x] ZLEMA

See Also:  [Indicators support - OnlineTechnicalIndicators.jl](https://femtotrader.github.io/OnlineTechnicalIndicators.jl/dev/indicators_support/)

Help Wanted:  [Visualization Function Writers](https://g-gundam.github.io/TechnicalIndicatorCharts.jl/dev/indicators/)

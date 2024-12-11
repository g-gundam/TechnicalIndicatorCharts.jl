# TechnicalIndicatorCharts

[![Dev](https://img.shields.io/badge/docs-dev-blue.svg)](https://g-gundam.github.io/TechnicalIndicatorCharts.jl/dev/)
[![Build Status](https://github.com/g-gundam/TechnicalIndicatorCharts.jl/actions/workflows/CI.yml/badge.svg?branch=main)](https://github.com/g-gundam/TechnicalIndicatorCharts.jl/actions/workflows/CI.yml?query=branch%3Amain)
[![Coverage](https://codecov.io/gh/g-gundam/TechnicalIndicatorCharts.jl/branch/main/graph/badge.svg)](https://codecov.io/gh/g-gundam/TechnicalIndicatorCharts.jl)

The purpose of this library is to bring
[OnlineTechnicalIndicators.jl](https://github.com/femtotrader/OnlineTechnicalIndicators.jl) and
[LightweightCharts.jl](https://github.com/bhftbootcamp/LightweightCharts.jl) together.

## Example

```julia-repl
julia> using TechnicalIndicatorCharts, LightweightCharts

julia> golden_cross = chart(
    "BTCUSD", Hour(4);
    indicators = [
        SMA{Float64}(;period=50),
        SMA{Float64}(;period=200)
    ],
    visuals = [
        Dict(
            :label_name => "SMA 50",
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

## Data

Adding new data to the chart is done with the `update!(chart, candle)` function.

```julia-repl
# TODO
```

## Visualization

```julia-repl
TODO
```

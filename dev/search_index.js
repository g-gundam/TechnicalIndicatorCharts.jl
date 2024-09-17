var documenterSearchIndex = {"docs":
[{"location":"","page":"Home","title":"Home","text":"CurrentModule = TechnicalIndicatorCharts","category":"page"},{"location":"#TechnicalIndicatorCharts","page":"Home","title":"TechnicalIndicatorCharts","text":"","category":"section"},{"location":"","page":"Home","title":"Home","text":"Documentation for TechnicalIndicatorCharts.","category":"page"},{"location":"","page":"Home","title":"Home","text":"","category":"page"},{"location":"","page":"Home","title":"Home","text":"Modules = [TechnicalIndicatorCharts]","category":"page"},{"location":"#TechnicalIndicatorCharts.abbrev-Tuple{Dates.Period}","page":"Home","title":"TechnicalIndicatorCharts.abbrev","text":"abbrev(p::Period)\n\nReturn an abbreviated string representation of the given period.\n\nExample\n\nabbrev(Hour(4)) # \"4h\"\nabbrev(Day(1))  # \"1d\"\n\n\n\n\n\n","category":"method"},{"location":"#TechnicalIndicatorCharts.chart-Tuple{Any, Any}","page":"Home","title":"TechnicalIndicatorCharts.chart","text":"  chart(name, tf; indicators, visuals)\n\nConstruct a Chart instance configured with the given indicators and visual parameters.\n\nExample\n\njulia> golden_cross = chart(\n    \"BTCUSD\", Hour(4);\n    indicators = [\n        SMA{Float64}(;period=50),\n        SMA{Float64}(;period=200)\n    ],\n    visuals = [\n        Dict(\n            :label_name => \"SMA 50\",\n            :line_color => \"#E072A4\",\n            :line_width => 2\n        ),\n        Dict(\n            :label_name => \"SMA 200\",\n            :line_color => \"#3D3B8E\",\n            :line_width => 5\n        )\n    ]\n)\n\n\n\n\n\n","category":"method"},{"location":"#TechnicalIndicatorCharts.extract_value-Tuple{Any}","page":"Home","title":"TechnicalIndicatorCharts.extract_value","text":"extract_value(value)\n\n\nExtract values out of an indicators value struct.  This is only intended to be used for indicators that emit multiple values per tick.\n\n\n\n\n\n","category":"method"},{"location":"#TechnicalIndicatorCharts.indicator_fields-Tuple{OnlineTechnicalIndicators.TechnicalIndicatorSingleOutput}","page":"Home","title":"TechnicalIndicatorCharts.indicator_fields","text":"Return a tuple of symbol names to be used for the output of ind.\n\n\n\n\n\n","category":"method"},{"location":"#TechnicalIndicatorCharts.indicator_fields_values-Tuple{OnlineTechnicalIndicators.TechnicalIndicatorMultiOutput}","page":"Home","title":"TechnicalIndicatorCharts.indicator_fields_values","text":"indicator_fields_values(ind)\n\n\nExtract values from an indicator instance.\n\n\n\n\n\n","category":"method"},{"location":"#TechnicalIndicatorCharts.ismultiinput-Tuple{OnlineTechnicalIndicators.TechnicalIndicator}","page":"Home","title":"TechnicalIndicatorCharts.ismultiinput","text":"This is a wrapper around OnlineTechnicalIndicators.ismultiinput that takes any instance of a TechnicalIndicator and digs out its unparametrized type before running the original ismultiinput method.\n\n\n\n\n\n","category":"method"},{"location":"#TechnicalIndicatorCharts.ismultioutput-Tuple{OnlineTechnicalIndicators.TechnicalIndicator}","page":"Home","title":"TechnicalIndicatorCharts.ismultioutput","text":"This is a wrapper around OnlineTechnicalIndicators.ismultioutput that takes any instance of a TechnicalIndicator and digs out its unparametrized type before running the original ismultioutput method.\n\n\n\n\n\n","category":"method"},{"location":"#TechnicalIndicatorCharts.make_panel-Tuple{LightweightCharts.LWCChart}","page":"Home","title":"TechnicalIndicatorCharts.make_panel","text":"make_panel(\n    chart::LightweightCharts.LWCChart\n) -> LightweightCharts.LWCPanel\n\n\nWrap a single LWCChart in a panel.\n\n\n\n\n\n","category":"method"},{"location":"#TechnicalIndicatorCharts.make_panel-Tuple{Vector}","page":"Home","title":"TechnicalIndicatorCharts.make_panel","text":"make_panel(plots::Vector) -> LightweightCharts.LWCPanel\n\n\nWrap a Vector of LWCCharts in a panel.\n\n\n\n\n\n","category":"method"},{"location":"#TechnicalIndicatorCharts.merge_candle!-Tuple{Union{Missing, Candle}, Union{Candle, DataFrames.DataFrameRow}}","page":"Home","title":"TechnicalIndicatorCharts.merge_candle!","text":"merge_candle!(last_candle, c)\n\n\nIf last candle is not provided, construct a new candle with the given OHLCV data. If last candle is provided, mutate last_candle such that it's HLCV are updated. When tw candles are passed in, it's assumed they have the same timestamp.\n\n\n\n\n\n","category":"method"},{"location":"#TechnicalIndicatorCharts.push_new_candle!-Tuple{Chart, Candle}","page":"Home","title":"TechnicalIndicatorCharts.push_new_candle!","text":"push_new_candle!(chart, c)\n\n\nThis is meant to be called on timeframe boundaries to onto the chart's dataframe.  It also does indicator calculation at this time.\n\n\n\n\n\n","category":"method"},{"location":"#TechnicalIndicatorCharts.random_candles-Tuple{Any, Any}","page":"Home","title":"TechnicalIndicatorCharts.random_candles","text":"random_candles(tf, n; start)\n\nThis belongs somewhere in ~/hak/trading, but it can live here for now.\n\n\n\n\n\n","category":"method"},{"location":"#TechnicalIndicatorCharts.update!-Tuple{Chart, Candle}","page":"Home","title":"TechnicalIndicatorCharts.update!","text":"update!(chart, c)\n\n\nUpdate a chart with a candle.\n\n\n\n\n\n","category":"method"},{"location":"#TechnicalIndicatorCharts.update_last_candle!-Tuple{Chart, Candle}","page":"Home","title":"TechnicalIndicatorCharts.update_last_candle!","text":"update_last_candle!(chart, c)\n\n\nThis updates the HLCV values of the last row of the chart's DataFrame when we're not at a chart.tf boundary.\n\n\n\n\n\n","category":"method"},{"location":"#TechnicalIndicatorCharts.visualize-Tuple{Any, Any, DataFrames.DataFrame}","page":"Home","title":"TechnicalIndicatorCharts.visualize","text":"visualize(\n    unimplemented,\n    opts,\n    df::DataFrames.DataFrame\n) -> LightweightCharts.LWCChart\n\n\nThis is a visualize method that's a catch-all for indicators that haven't had a visualize method made for them yet.  For now, it returns missing.\n\n\n\n\n\n","category":"method"},{"location":"#TechnicalIndicatorCharts.visualize-Tuple{Chart}","page":"Home","title":"TechnicalIndicatorCharts.visualize","text":"visualize(\n    chart::Chart;\n    min_height,\n    mode\n) -> LightweightCharts.LWCLayout\n\n\nReturn an LWCLayout that visualizes all the components in chart appropriately.\n\n\n\n\n\n","category":"method"},{"location":"#TechnicalIndicatorCharts.visualize-Tuple{DataFrames.DataFrame, Any}","page":"Home","title":"TechnicalIndicatorCharts.visualize","text":"visualize(\n    df::DataFrames.DataFrame,\n    opts\n) -> LightweightCharts.LWCChart\n\n\nVisualize a DataFrame using lwc_candlestick.\n\n\n\n\n\n","category":"method"},{"location":"#TechnicalIndicatorCharts.visualize-Tuple{OnlineTechnicalIndicators.BB, Any, DataFrames.DataFrame}","page":"Home","title":"TechnicalIndicatorCharts.visualize","text":"visualize(\n    bb::OnlineTechnicalIndicators.BB,\n    opts,\n    df::DataFrames.DataFrame\n) -> Vector{LightweightCharts.LWCChart}\n\n\nVisualize Bollinger Bands using 3 lwc_lines.\n\n\n\n\n\n","category":"method"},{"location":"#TechnicalIndicatorCharts.visualize-Tuple{OnlineTechnicalIndicators.EMA, Any, DataFrames.DataFrame}","page":"Home","title":"TechnicalIndicatorCharts.visualize","text":"visualize(\n    ema::OnlineTechnicalIndicators.EMA,\n    opts,\n    df::DataFrames.DataFrame\n) -> LightweightCharts.LWCChart\n\n\nVisualize EMA using 1 lwc_line.\n\n\n\n\n\n","category":"method"},{"location":"#TechnicalIndicatorCharts.visualize-Tuple{OnlineTechnicalIndicators.HMA, Any, DataFrames.DataFrame}","page":"Home","title":"TechnicalIndicatorCharts.visualize","text":"visualize(\n    hma::OnlineTechnicalIndicators.HMA,\n    opts,\n    df::DataFrames.DataFrame\n) -> LightweightCharts.LWCChart\n\n\nVisualize HMA using 1 lwc_line.\n\n\n\n\n\n","category":"method"},{"location":"#TechnicalIndicatorCharts.visualize-Tuple{OnlineTechnicalIndicators.RSI, Any, DataFrames.DataFrame}","page":"Home","title":"TechnicalIndicatorCharts.visualize","text":"visualize(\n    rsi::OnlineTechnicalIndicators.RSI,\n    opts,\n    df::DataFrames.DataFrame\n) -> LightweightCharts.LWCChart\n\n\nVisualize RSI using 1 lwc_line.\n\n\n\n\n\n","category":"method"},{"location":"#TechnicalIndicatorCharts.visualize-Tuple{OnlineTechnicalIndicators.SMA, Any, DataFrames.DataFrame}","page":"Home","title":"TechnicalIndicatorCharts.visualize","text":"visualize(\n    sma::OnlineTechnicalIndicators.SMA,\n    opts,\n    df::DataFrames.DataFrame\n) -> LightweightCharts.LWCChart\n\n\nReturn an lwc_line for visualizing an SMA indicator.\n\n\n\n\n\n","category":"method"},{"location":"#TechnicalIndicatorCharts.visualize-Tuple{OnlineTechnicalIndicators.StochRSI, Any, DataFrames.DataFrame}","page":"Home","title":"TechnicalIndicatorCharts.visualize","text":"visualize(\n    srsi::OnlineTechnicalIndicators.StochRSI,\n    opts,\n    df::DataFrames.DataFrame\n) -> Vector{LightweightCharts.LWCChart}\n\n\nVisualize StochRSI using 2 lwc_lines.\n\n\n\n\n\n","category":"method"}]
}

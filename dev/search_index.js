var documenterSearchIndex = {"docs":
[{"location":"api/","page":"API","title":"API","text":"CurrentModule = TechnicalIndicatorCharts","category":"page"},{"location":"api/#TechnicalIndicatorCharts","page":"API","title":"TechnicalIndicatorCharts","text":"","category":"section"},{"location":"api/","page":"API","title":"API","text":"Documentation for TechnicalIndicatorCharts.","category":"page"},{"location":"api/","page":"API","title":"API","text":"","category":"page"},{"location":"api/","page":"API","title":"API","text":"Modules = [TechnicalIndicatorCharts]","category":"page"},{"location":"api/#TechnicalIndicatorCharts.Chart","page":"API","title":"TechnicalIndicatorCharts.Chart","text":"Summary\n\nA Chart is a mutable struct that has:\n\na name (typically of the asset like \"BTCUSD\" or \"AAPL\")\na timeframe (which controls how much time each candle on the chart represents)\na DataFrame to hold OHLCV values and indicator values\na Vector of OnlineTechnicalIndicators to display on the chart.\nanother Vector of display configuration for each indicator.\n\nIf you were to go to TradingView and look at a chart, imagine what kind of data structure would be required to represent it in memory. That's what the Chart struct aims to be.\n\nFields\n\nname::AbstractString\ntf::Dates.Period\nindicators::AbstractVector{OnlineTechnicalIndicators.TechnicalIndicator}\nvisuals::AbstractVector\ndf::DataFrames.DataFrame\nts::Union{Missing, Dates.DateTime}\ncandle::Union{Missing, Candle}\n\nConstructors\n\nChart(name, tf; indicators=[], visuals=[])\n\nExamples\n\njulia> just_candles = Chart(\"ETHUSD\", Minute(1))\n\njulia> golden_cross = Chart(\n           \"BTCUSD\", Hour(4);\n           indicators = [\n               SMA{Float64}(;period=50),\n               SMA{Float64}(;period=200)\n           ],\n           visuals = [\n               Dict(\n                   :label_name => \"SMA 50\",\n                   :line_color => \"#E072A4\",\n                   :line_width => 2\n               ),\n               Dict(\n                   :label_name => \"SMA 200\",\n                   :line_color => \"#3D3B8E\",\n                   :line_width => 5\n               )\n           ]\n       )\n\njulia> default_visuals = Chart(\n           \"BNBUSDT\", Hour(4);\n           indicators = [BB{Float64}(), StochRSI{Float64}()],\n           visuals    = [nothing,       nothing]  # To use defaults, pass in `nothing`.\n       )\n\n\n\n\n\n","category":"type"},{"location":"api/#TechnicalIndicatorCharts.abbrev-Tuple{Dates.Period}","page":"API","title":"TechnicalIndicatorCharts.abbrev","text":"abbrev(p::Period)\n\nReturn an abbreviated string representation of the given period.\n\nExample\n\nabbrev(Hour(4)) # \"4h\"\nabbrev(Day(1))  # \"1d\"\n\n\n\n\n\n","category":"method"},{"location":"api/#TechnicalIndicatorCharts.extract_value-Tuple{Any}","page":"API","title":"TechnicalIndicatorCharts.extract_value","text":"extract_value(value) -> Vector{Any}\n\n\nExtract values out of an indicators value struct.  This is only intended to be used for indicators that emit multiple values per tick.\n\n\n\n\n\n","category":"method"},{"location":"api/#TechnicalIndicatorCharts.indicator_fields-Tuple{OnlineTechnicalIndicators.TechnicalIndicatorSingleOutput}","page":"API","title":"TechnicalIndicatorCharts.indicator_fields","text":"Return a tuple of symbol names to be used for the output of ind.\n\n\n\n\n\n","category":"method"},{"location":"api/#TechnicalIndicatorCharts.indicator_fields_values-Tuple{OnlineTechnicalIndicators.TechnicalIndicatorMultiOutput}","page":"API","title":"TechnicalIndicatorCharts.indicator_fields_values","text":"indicator_fields_values(\n    ind::OnlineTechnicalIndicators.TechnicalIndicatorMultiOutput\n) -> Any\n\n\nExtract values from an indicator instance.\n\n\n\n\n\n","category":"method"},{"location":"api/#TechnicalIndicatorCharts.ismultiinput-Tuple{OnlineTechnicalIndicators.TechnicalIndicator}","page":"API","title":"TechnicalIndicatorCharts.ismultiinput","text":"This is a wrapper around OnlineTechnicalIndicators.ismultiinput that takes any instance of a TechnicalIndicator and digs out its unparametrized type before running the original ismultiinput method.\n\n\n\n\n\n","category":"method"},{"location":"api/#TechnicalIndicatorCharts.ismultioutput-Tuple{OnlineTechnicalIndicators.TechnicalIndicator}","page":"API","title":"TechnicalIndicatorCharts.ismultioutput","text":"This is a wrapper around OnlineTechnicalIndicators.ismultioutput that takes any instance of a TechnicalIndicator and digs out its unparametrized type before running the original ismultioutput method.\n\n\n\n\n\n","category":"method"},{"location":"api/#TechnicalIndicatorCharts.make_panel-Tuple{AbstractVector}","page":"API","title":"TechnicalIndicatorCharts.make_panel","text":"make_panel(\n    plots::AbstractVector\n) -> LightweightCharts.LWCPanel\n\n\nWrap a Vector of LWCCharts in a panel.\n\n\n\n\n\n","category":"method"},{"location":"api/#TechnicalIndicatorCharts.make_panel-Tuple{LightweightCharts.LWCChart}","page":"API","title":"TechnicalIndicatorCharts.make_panel","text":"make_panel(\n    chart::LightweightCharts.LWCChart\n) -> LightweightCharts.LWCPanel\n\n\nWrap a single LWCChart in a panel.\n\n\n\n\n\n","category":"method"},{"location":"api/#TechnicalIndicatorCharts.merge_candle!-Tuple{Union{Missing, Candle}, Union{Candle, DataFrames.DataFrameRow}}","page":"API","title":"TechnicalIndicatorCharts.merge_candle!","text":"merge_candle!(\n    last_candle::Union{Missing, Candle},\n    c::Union{Candle, DataFrames.DataFrameRow}\n) -> Candle\n\n\nIf last candle is not provided, construct a new candle with the given OHLCV data. If last candle is provided, mutate last_candle such that it's HLCV are updated. When tw candles are passed in, it's assumed they have the same timestamp.\n\n\n\n\n\n","category":"method"},{"location":"api/#TechnicalIndicatorCharts.push_new_candle!-Tuple{Chart, Candle}","page":"API","title":"TechnicalIndicatorCharts.push_new_candle!","text":"push_new_candle!(\n    chart::Chart,\n    c::Candle\n) -> DataFrames.DataFrame\n\n\nThis is meant to be called on timeframe boundaries to onto the chart's dataframe.  It also does indicator calculation at this time.\n\n\n\n\n\n","category":"method"},{"location":"api/#TechnicalIndicatorCharts.update!-Tuple{Chart, Candle}","page":"API","title":"TechnicalIndicatorCharts.update!","text":"update!(chart::Chart, c::Candle) -> Union{Nothing, Candle}\n\n\nUpdate a chart with a candle. When a candle is completed, return it. Otherwise, return nothing on update.\n\n\n\n\n\n","category":"method"},{"location":"api/#TechnicalIndicatorCharts.update_last_candle!-Tuple{Chart, Candle}","page":"API","title":"TechnicalIndicatorCharts.update_last_candle!","text":"update_last_candle!(chart::Chart, c::Candle) -> Float64\n\n\nThis updates the HLCV values of the last row of the chart's DataFrame when we're not at a chart.tf boundary.\n\n\n\n\n\n","category":"method"},{"location":"api/#TechnicalIndicatorCharts.visualize-Tuple{Any, Any, DataFrames.DataFrame}","page":"API","title":"TechnicalIndicatorCharts.visualize","text":"visualize(\n    unimplemented,\n    opts,\n    df::DataFrames.DataFrame\n) -> LightweightCharts.LWCChart\n\n\nThis is a visualize method that's a catch-all for indicators that haven't had a visualize method made for them yet.  For now, it returns missing.\n\n\n\n\n\n","category":"method"},{"location":"api/#TechnicalIndicatorCharts.visualize-Tuple{Chart}","page":"API","title":"TechnicalIndicatorCharts.visualize","text":"visualize(\n    chart::Chart;\n    min_height,\n    mode,\n    up_color,\n    down_color,\n    copyright\n) -> LightweightCharts.LWCLayout\n\n\nReturn an LWCLayout that visualizes all the components in chart appropriately.\n\n\n\n\n\n","category":"method"},{"location":"api/#TechnicalIndicatorCharts.visualize-Tuple{DataFrames.DataFrame, Any}","page":"API","title":"TechnicalIndicatorCharts.visualize","text":"visualize(\n    df::DataFrames.DataFrame,\n    opts\n) -> LightweightCharts.LWCChart\n\n\nVisualize a DataFrame using lwc_candlestick.\n\n\n\n\n\n","category":"method"},{"location":"api/#TechnicalIndicatorCharts.visualize-Tuple{OnlineTechnicalIndicators.ATR, Union{Nothing, AbstractDict}, DataFrames.DataFrame}","page":"API","title":"TechnicalIndicatorCharts.visualize","text":"visualize(\n    atr::OnlineTechnicalIndicators.ATR,\n    opts::Union{Nothing, AbstractDict},\n    df::DataFrames.DataFrame\n) -> LightweightCharts.LWCChart\n\n\nVisualize ATR using 1 lwc_line.\n\n\n\n\n\n","category":"method"},{"location":"api/#TechnicalIndicatorCharts.visualize-Tuple{OnlineTechnicalIndicators.BB, Union{Nothing, AbstractDict}, DataFrames.DataFrame}","page":"API","title":"TechnicalIndicatorCharts.visualize","text":"visualize(\n    bb::OnlineTechnicalIndicators.BB,\n    opts::Union{Nothing, AbstractDict},\n    df::DataFrames.DataFrame\n) -> Vector{LightweightCharts.LWCChart}\n\n\nVisualize Bollinger Bands using 3 lwc_lines.\n\n\n\n\n\n","category":"method"},{"location":"api/#TechnicalIndicatorCharts.visualize-Tuple{OnlineTechnicalIndicators.DEMA, Union{Nothing, AbstractDict}, DataFrames.DataFrame}","page":"API","title":"TechnicalIndicatorCharts.visualize","text":"visualize(\n    dema::OnlineTechnicalIndicators.DEMA,\n    opts::Union{Nothing, AbstractDict},\n    df::DataFrames.DataFrame\n) -> LightweightCharts.LWCChart\n\n\nVisualize DEMA using 1 lwc_line.\n\n\n\n\n\n","category":"method"},{"location":"api/#TechnicalIndicatorCharts.visualize-Tuple{OnlineTechnicalIndicators.EMA, Union{Nothing, AbstractDict}, DataFrames.DataFrame}","page":"API","title":"TechnicalIndicatorCharts.visualize","text":"visualize(\n    ema::OnlineTechnicalIndicators.EMA,\n    opts::Union{Nothing, AbstractDict},\n    df::DataFrames.DataFrame\n) -> LightweightCharts.LWCChart\n\n\nVisualize EMA using 1 lwc_line.\n\n\n\n\n\n","category":"method"},{"location":"api/#TechnicalIndicatorCharts.visualize-Tuple{OnlineTechnicalIndicators.HMA, Union{Nothing, AbstractDict}, DataFrames.DataFrame}","page":"API","title":"TechnicalIndicatorCharts.visualize","text":"visualize(\n    hma::OnlineTechnicalIndicators.HMA,\n    opts::Union{Nothing, AbstractDict},\n    df::DataFrames.DataFrame\n) -> LightweightCharts.LWCChart\n\n\nVisualize HMA using 1 lwc_line.\n\n\n\n\n\n","category":"method"},{"location":"api/#TechnicalIndicatorCharts.visualize-Tuple{OnlineTechnicalIndicators.RSI, Union{Nothing, AbstractDict}, DataFrames.DataFrame}","page":"API","title":"TechnicalIndicatorCharts.visualize","text":"visualize(\n    rsi::OnlineTechnicalIndicators.RSI,\n    opts::Union{Nothing, AbstractDict},\n    df::DataFrames.DataFrame\n) -> LightweightCharts.LWCChart\n\n\nVisualize RSI using 1 lwc_line.\n\n\n\n\n\n","category":"method"},{"location":"api/#TechnicalIndicatorCharts.visualize-Tuple{OnlineTechnicalIndicators.SMA, Union{Nothing, AbstractDict}, DataFrames.DataFrame}","page":"API","title":"TechnicalIndicatorCharts.visualize","text":"visualize(\n    sma::OnlineTechnicalIndicators.SMA,\n    opts::Union{Nothing, AbstractDict},\n    df::DataFrames.DataFrame\n) -> LightweightCharts.LWCChart\n\n\nReturn an lwc_line for visualizing an SMA indicator.\n\n\n\n\n\n","category":"method"},{"location":"api/#TechnicalIndicatorCharts.visualize-Tuple{OnlineTechnicalIndicators.StochRSI, Union{Nothing, AbstractDict}, DataFrames.DataFrame}","page":"API","title":"TechnicalIndicatorCharts.visualize","text":"visualize(\n    srsi::OnlineTechnicalIndicators.StochRSI,\n    opts::Union{Nothing, AbstractDict},\n    df::DataFrames.DataFrame\n) -> Vector{LightweightCharts.LWCChart}\n\n\nVisualize StochRSI using 2 lwc_lines.\n\n\n\n\n\n","category":"method"},{"location":"api/#TechnicalIndicatorCharts.visualize-Tuple{OnlineTechnicalIndicators.WMA, Union{Nothing, AbstractDict}, DataFrames.DataFrame}","page":"API","title":"TechnicalIndicatorCharts.visualize","text":"visualize(\n    wma::OnlineTechnicalIndicators.WMA,\n    opts::Union{Nothing, AbstractDict},\n    df::DataFrames.DataFrame\n) -> LightweightCharts.LWCChart\n\n\nVisualize WMA using 1 lwc_line.\n\n\n\n\n\n","category":"method"},{"location":"indicators/#First,-an-Apology","page":"Indicators","title":"First, an Apology","text":"","category":"section"},{"location":"indicators/","page":"Indicators","title":"Indicators","text":"There is a very high chance that the indicator you want to visualize has not been implemented yet.  So far, I've only implemented the few indicators that I personally use.  Fortunately, new indicator visualizations are easy to implement.","category":"page"},{"location":"indicators/#How-to-Implement-a-New-Indicator-Visualization","page":"Indicators","title":"How to Implement a New Indicator Visualization","text":"","category":"section"},{"location":"indicators/#Implement-a-denominated_price-function.","page":"Indicators","title":"Implement a denominated_price function.","text":"","category":"section"},{"location":"indicators/","page":"Indicators","title":"Indicators","text":"Is the output of the indicator a price value?","category":"page"},{"location":"indicators/","page":"Indicators","title":"Indicators","text":"Moving averages are the best example of this.  It takes a price as an input and generates a price value as an output, so demominated_price should return true.","category":"page"},{"location":"indicators/","page":"Indicators","title":"Indicators","text":"What about the opposite case?","category":"page"},{"location":"indicators/","page":"Indicators","title":"Indicators","text":"Oscillators typically answer false for this. Think of RSI that takes close prices as input but its output is a value between 0 and 100 regardless of how high or low the price is.  The domain and range are different for the RSI function (and many other oscillators) so denominated_price should return false.","category":"page"},{"location":"indicators/","page":"Indicators","title":"Indicators","text":"denominated_price(sma::SMA) = true\ndenominated_price(rsi::RSI) = false","category":"page"},{"location":"indicators/#Implement-a-visualize-function.","page":"Indicators","title":"Implement a visualize function.","text":"","category":"section"},{"location":"indicators/","page":"Indicators","title":"Indicators","text":"A visualize function takes 3 parameters.","category":"page"},{"location":"indicators/","page":"Indicators","title":"Indicators","text":"An indicator instance\nA Dict of visualization options\nBy convention, nothing is also allowed, and that means to use the defaults.\nA DataFrame containing all the values generated for the Chart","category":"page"},{"location":"indicators/","page":"Indicators","title":"Indicators","text":"Here's what SMA looks like.  It's one of the simplest indicators to visualize, because it's a single line.","category":"page"},{"location":"indicators/","page":"Indicators","title":"Indicators","text":"\"\"\"$(TYPEDSIGNATURES)\n\nReturn an lwc_line for visualizing an SMA indicator.\n\"\"\"\nfunction visualize(sma::SMA, opts::Union{AbstractDict,Nothing}, df::DataFrame)\n    start = sma.period\n    name = indicator_fields(sma)[1]\n    kwargs = Dict(\n        :label_name => \"SMA $(sma.period)\",\n        :line_color => \"#B84A62\",\n        :line_width => 2\n    )\n    if opts !== nothing                 # (opts == nothing) means use the defaults\n        merge!(kwargs, opts)\n    end\n    return lwc_line(                    # the end goal is to return an lwc visual\n        df.ts[start:end],\n        [df[!, name][start:end]...];\n        kwargs...\n    )\nend","category":"page"},{"location":"indicators/","page":"Indicators","title":"Indicators","text":"If you need to return more than one line, return them in a vector. A good example of this is BB.jl which returns 3 lwc_lines.","category":"page"},{"location":"indicators/","page":"Indicators","title":"Indicators","text":"You're also not limited to lwc_line.  You can use any visualization function supported by LightweightCharts.jl.","category":"page"},{"location":"indicators/#Examples","page":"Indicators","title":"Examples","text":"","category":"section"},{"location":"indicators/","page":"Indicators","title":"Indicators","text":"All indicator visualizations fall into one of these four categories.","category":"page"},{"location":"indicators/","page":"Indicators","title":"Indicators","text":" Denominated in Price Not Denominated in Price\nSingle Visual Element EMA, HMA, SMA RSI\nMultiple Visual Elements BB StochRSI","category":"page"},{"location":"indicators/","page":"Indicators","title":"Indicators","text":"When implementing a new visualization, feel free to look at the source for these and use them as a starting point for your own work.","category":"page"},{"location":"indicators/#Finally","page":"Indicators","title":"Finally","text":"","category":"section"},{"location":"indicators/","page":"Indicators","title":"Indicators","text":"Add an include for your newly implemented indicator at the bottom of src/TechnicalIndicatorCharts.jl.\nAdd a test for your indicator.  A basic test that makes sure it doesn't crash when visualize is run is enough.\nMark that the indicator is done in the README.md for this project.","category":"page"},{"location":"indicators/#Thanks","page":"Indicators","title":"Thanks","text":"","category":"section"},{"location":"indicators/","page":"Indicators","title":"Indicators","text":"Thanks to all future indicator visualization authors.","category":"page"},{"location":"#TechnicalIndicatorCharts","page":"Home","title":"TechnicalIndicatorCharts","text":"","category":"section"},{"location":"","page":"Home","title":"Home","text":"A library for  visualizing OnlineTechnicalIndicators.jl  using LightweightCharts.jl","category":"page"},{"location":"#What-is-a-Chart?","page":"Home","title":"What is a Chart?","text":"","category":"section"},{"location":"","page":"Home","title":"Home","text":"A Chart is a mutable struct that has:","category":"page"},{"location":"","page":"Home","title":"Home","text":"a name (typically of the asset like \"BTCUSD\" or \"AAPL\")\na timeframe (which controls how much time each candle on the chart represents)\na DataFrame to hold OHLCV values and indicator values\na Vector of OnlineTechnicalIndicators to display on the chart.\nanother Vector of display configuration for each indicator.","category":"page"},{"location":"","page":"Home","title":"Home","text":"If you were to go to TradingView and look at a chart,  imagine what kind of data structure would be required to represent it in memory. That's what the Chart struct aims to be.","category":"page"},{"location":"#Creating-a-Chart","page":"Home","title":"Creating a Chart","text":"","category":"section"},{"location":"","page":"Home","title":"Home","text":"using OnlineTechnicalIndicators\nusing TechnicalIndicatorCharts\n\ngolden_cross_chart = Chart(\n    \"AAPL\", Week(1);\n    indicators = [\n        SMA{Float64}(;period=50),         # Setup indicators\n        SMA{Float64}(;period=200)\n    ],\n    visuals = [\n        Dict(\n            :label_name => \"SMA 50\",      # Describe how to draw indicators\n            :line_color => \"#E072A4\",\n            :line_width => 2\n        ),\n        Dict(\n            :label_name => \"SMA 200\",\n            :line_color => \"#3D3B8E\",\n            :line_width => 5\n        )\n    ]\n)","category":"page"},{"location":"#Feeding-Your-Chart-Data","page":"Home","title":"Feeding Your Chart Data","text":"","category":"section"},{"location":"","page":"Home","title":"Home","text":"Adding new data to the chart is done with the update!(chart, candle) function.","category":"page"},{"location":"","page":"Home","title":"Home","text":"using MarketData\n\nfor row in eachrow(AAPL)\n    c = Candle(\n        ts=DateTime(row.timestamp),\n        o=row.Open,\n        h=row.High,\n        l=row.Low,\n        c=row.Close,\n        v=row.Volume\n    )\n    update!(golden_cross_chart, c)\nend","category":"page"},{"location":"","page":"Home","title":"Home","text":"Notice that update! took daily candles from AAPL and aggregated them into weekly candles.","category":"page"},{"location":"","page":"Home","title":"Home","text":"The update! function was designed to consume low timeframe candles to incrementally build higher timeframe charts.  Imagine unfinished 1m candles from a websocket being consumed to generate multiple higher-timeframe views of a single market.  The hope was that this would facilitate realtime, multi-timeframe analysis.","category":"page"},{"location":"#Visualization","page":"Home","title":"Visualization","text":"","category":"section"},{"location":"","page":"Home","title":"Home","text":"The visualize function will take a chart and generate something that lwc_show from LightweightCharts.jl can display.","category":"page"},{"location":"","page":"Home","title":"Home","text":"using LightweightCharts\n\nlwc_show(visualize(golden_cross_chart))\n# Or\ngolden_cross_chart |> visualize |> lwc_show","category":"page"},{"location":"","page":"Home","title":"Home","text":"(Image: aapl)","category":"page"}]
}

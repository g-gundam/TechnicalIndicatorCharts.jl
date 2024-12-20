module TechnicalIndicatorCharts

using Dates
using NanoDates
using Chain
using DataFrames
using DataFramesMeta
using OnlineTechnicalIndicators
using OnlineTechnicalIndicators: TechnicalIndicator
using LightweightCharts
using LightweightCharts.Charts: LWC_PRICE_SCALE_MODE
using DocStringExtensions

# Write your package code here.
# structs
# - exported

@kwdef mutable struct Candle
    ts::DateTime
    o::Float64
    h::Float64
    l::Float64
    c::Float64
    v::Float64
end

"""
# Summary

A Chart is a mutable struct that has:

- a name (typically of the asset like "BTCUSD" or "AAPL")
- a timeframe (which controls how much time each candle on the chart represents)
- a DataFrame to hold OHLCV values and indicator values
- a Vector of `OnlineTechnicalIndicator`s to display on the chart.
- another Vector of display configuration for each indicator.

If you were to go to [TradingView](https://tradingview.com/) and look at a chart,
imagine what kind of data structure would be required to represent it in memory.
That's what the `Chart` struct aims to be.

# Fields
$(TYPEDFIELDS)

# Constructors
```julia
Chart(name, tf; indicators=[], visuals=[])
```

# Examples

```julia-repl
julia> just_candles = Chart("ETHUSD", Minute(1))

julia> golden_cross = Chart(
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

julia> default_visuals = Chart(
           "BNBUSDT", Hour(4);
           indicators = [BB{Float64}(), StochRSI{Float64}()],
           visuals    = [nothing,       nothing]  # To use defaults, pass in `nothing`.
       )
```
"""
mutable struct Chart
    # This is the user-facing data.
    name::AbstractString                     # name
    tf::Period                               # time frame
    indicators::AbstractVector{TechnicalIndicator}
                                             # indicators to add to the dataframe
    visuals::AbstractVector                  # visualization parameters for each indicator
    df::DataFrame                            # dataframe

    # There is also some internal data that I use to keep track of computations in progress.
    ts::Union{DateTime,Missing}
    candle::Union{Candle,Missing}

    function Chart(name::AbstractString, tf::Period; indicators=[], visuals::AbstractVector=Vector{Union{AbstractDict,Nothing}}())
        df = DataFrame(df_fields(indicators))
        ts = missing
        candle = missing
        new(name, tf, indicators, visuals, df, ts, candle)
    end
end

export Candle
export Chart


# helpers
abbrev(ns::Nanosecond)  = "$(ns.value)ns"
abbrev(us::Microsecond) = "$(us.value)us"
abbrev(ms::Millisecond) = "$(ms.value)ms"
abbrev(s::Second)       = "$(s.value)s"
abbrev(m::Minute)       = "$(m.value)m"
abbrev(h::Hour)         = "$(h.value)h"
abbrev(d::Day)          = "$(d.value)d"
abbrev(w::Week)         = "$(w.value)w"
abbrev(M::Month)        = "$(M.value)M"
abbrev(Q::Quarter)      = "$(Q.value)Q"
abbrev(Y::Year)         = "$(Y.value)Y"
function abbrev(canon::Dates.CompoundPeriod; minimum=Minute)
    @chain canon.periods begin
        filter(p -> typeof(p) >= minimum, _)
        map(abbrev, _)
        join(" ")
    end
end

"""    abbrev(p::Period)

Return an abbreviated string representation of the given period.

# Example

```julia
abbrev(Hour(4)) # "4h"
abbrev(Day(1))  # "1d"
```
"""
abbrev(p::Period)

"""
This is a wrapper around `OnlineTechnicalIndicators.ismultiinput` that takes
any instance of a TechnicalIndicator and digs out its unparametrized type before running
the original ismultiinput method.
"""
function ismultiinput(i::TechnicalIndicator)
    t = typeof(i)
    OnlineTechnicalIndicators.ismultiinput(t.name.wrapper)
end

"""
This is a wrapper around `OnlineTechnicalIndicators.ismultioutput` that takes
any instance of a TechnicalIndicator and digs out its unparametrized type before running
the original ismultioutput method.
"""
function ismultioutput(i::TechnicalIndicator)
    t = typeof(i)
    OnlineTechnicalIndicators.ismultioutput(t.name.wrapper)
end

struct Padded{T<:AbstractVector} <: AbstractVector{T}
    a::T
end

function Base.getindex(p::Padded, i::Int)
    if ismissing(p.a[i])
        0.0
    else
        p.a[i]
    end
end


# data calculation
# - export update!
"""
Return a tuple of symbol names to be used for the output of `ind`.
"""
function indicator_fields(ind::OnlineTechnicalIndicators.TechnicalIndicatorSingleOutput)
    name = @chain ind begin
        typeof
        string
        replace(_, r"\{.*}$" => "")
        replace(_, r"OnlineTechnicalIndicators." => "")
        lowercase
    end
    if hasproperty(ind, :period)
        return (Symbol("$(name)$(string(ind.period))"),)
    else
        return (Symbol(name),)
    end
end

function indicator_fields(ind::OnlineTechnicalIndicators.TechnicalIndicatorMultiOutput)
    name = @chain ind begin
        typeof
        string
        replace(_, r"\{.*}$" => "")
        replace(_, r"OnlineTechnicalIndicators." => "")
        lowercase
    end
    fnames = @chain ind begin
        typeof
        fieldtypes
        (ts -> ts[1])(_)
        getproperty(_, :b)
        fieldnames
        map(n -> Symbol("$(name)_$(string(n))"), _)
    end
end

function indicator_fields_count(ind::OnlineTechnicalIndicators.TechnicalIndicatorMultiOutput)
    @chain ind typeof fieldtypes (ts -> ts[1])(_) getproperty(_, :b) fieldcount
end

"""$(TYPEDSIGNATURES)

Extract values from an indicator instance.
"""
function indicator_fields_values(ind::OnlineTechnicalIndicators.TechnicalIndicatorMultiOutput)
    fields = @chain ind typeof fieldtypes (ts -> ts[1])(_) getproperty(_, :b) fieldnames
    if typeof(ind.value).parameters[1] == Missing
        repeat([missing], length(fields))
    else
        #@info fields typeof(ind.value) ind.value
        map((k) -> getproperty(ind.value, k), fields)
    end
end

function df_fields(indicators)
    base = (:ts, :o, :h, :l, :c, :v)
    fs = indicator_fields.(indicators) |> Iterators.flatten |> collect
    combined = Iterators.flatten([base, fs]) |> collect
    map(k -> ifelse(k == :ts, k=>DateTime[], k=>Union{Missing,Float64}[]), combined)
end

"""$(TYPEDSIGNATURES)

Extract values out of an indicators value struct.  This is only intended to be used
for indicators that emit multiple values per tick.
"""
function extract_value(value)
    # - value is a Value struct like BBVal, but I couldn't find a supertype that encompassed all indicator values.
    # - That's why no type was specified in the method params.
    fnames = @chain value begin
        typeof
        fieldnames
    end
    res = []
    for f in fnames
        push!(res, getproperty(value, f))
    end
    res
end

"""$(TYPEDSIGNATURES)

If last candle is not provided, construct a new candle with the given OHLCV data.
If last candle is provided, mutate last_candle such that it's HLCV are updated.
When tw candles are passed in, it's assumed they have the same timestamp.
"""
function merge_candle!(last_candle::Union{Missing, Candle}, c::Union{Candle,DataFrameRow})
    if ismissing(last_candle)
        return Candle(ts=c.ts, o=c.o, h=c.h, l=c.l, c=c.c, v=c.v)
    else
        last_candle.h = max(last_candle.h, c.h)
        last_candle.l = min(last_candle.l, c.l)
        last_candle.c = c.c
        last_candle.v = c.v
        return last_candle
    end
end

function flatten_indicator_values(vs)
    Iterators.flatmap(x -> ifelse(ismissing(x), (missing,), x), vs)
end

"""$(TYPEDSIGNATURES)

This is meant to be called on timeframe boundaries to onto the chart's
dataframe.  It also does indicator calculation at this time.
"""
function push_new_candle!(chart::Chart, c::Candle)
    vs = map(chart.indicators) do ind
        # what kind of inputs does this indicator want?
        if ismultiinput(ind)
            # feed it a whole candle instead
            ohlcv = OHLCV(
                c.o,
                c.h,
                c.l,
                c.c;
                volume=c.v,
                time=c.ts
            )
            fit!(ind, ohlcv)
        else
            fit!(ind, c.c)
        end
        if ismultioutput(ind)
            if ismissing(ind.value)
                return repeat([missing], indicator_fields_count(ind))
            else
                return indicator_fields_values(ind)
            end
        else
            return ind.value
        end
    end
    fvs = flatten_indicator_values(vs)
    push!(chart.df, (
        c.ts,
        c.o,
        c.h,
        c.l,
        c.c,
        c.v,
        fvs...
    ))
end

"""$(TYPEDSIGNATURES)

This updates the HLCV values of the last row of the chart's DataFrame
when we're not at a chart.tf boundary.
"""
function update_last_candle!(chart::Chart, c::Candle)
    row = last(chart.df)
    row.h = c.h
    row.l = c.l
    row.c = c.c
    row.v = c.v
end

"""$(TYPEDSIGNATURES)

Update a chart with a candle.
When a candle is completed, return it.
Otherwise, return nothing on update.
"""
function update!(chart::Chart, c::Candle)
    # aggregation when tf > Minute(1)
    # fit! on series after candle close only
    if ismissing(chart.ts)
        # initial case
        chart.ts = floor(c.ts, chart.tf)
        chart.candle = merge_candle!(missing, c)
        push_new_candle!(chart, c)
        return
    end

    if chart.ts != floor(c.ts, chart.tf)
        # timeframe boundary case
        chart.ts = floor(c.ts, chart.tf)
        chart.candle = Candle(c.ts, c.o, c.h, c.l, c.c, c.v) # clone tf boundary candle to start fresh candle aggregation
        push_new_candle!(chart, c)
        return Candle(c.ts, c.o, c.h, c.l, c.c, c.v) # clone it again to return the most recent completed candle
    else
        # normal case
        chart.candle = merge_candle!(chart.candle, c)
        update_last_candle!(chart, chart.candle)
        return
    end
end

# This translates a DataFrameRow to a Candle before sending it to
# the original update! function.
function update!(chart::Chart, dfr::DataFrameRow)
    c = Candle(
        ts=dfr.ts,
        o=dfr.o,
        h=dfr.h,
        l=dfr.l,
        c=dfr.c,
        v=dfr.v
    )
    update!(chart, c)
end

export update!
export indicator_fields
export indicator_fields_values

# for ease of debugging, I'm temporarily export these.
# export df_fields
# export extract_value
# export merge_candle!
# export flatten_indicator_values
# export push_new_candle!
# export update_last_candle!


# visualization

# - If an indicator is denominated in price,     it gets plotted along with price in the same panel.
# - If an indicator is not denominated in price, it gets plotted in its own panel.
denominated_price(any::Any) = false # If we don't know, assume false.

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
function make_panel(plots::AbstractVector)
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
                   down_color="#de5e57",
                   copyright=false)
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
            if typeof(p) <: AbstractVector
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
            mode,
            copyright
        ),
        # indicators that are not denominated in price get their own panel.
        make_panel.(plots_other)...;
        min_height
    )
end

include("BB.jl")
include("DEMA.jl")
include("EMA.jl")
include("HMA.jl")
include("RSI.jl")
include("SMA.jl")
include("StochRSI.jl")
include("WMA.jl")

export visualize

end

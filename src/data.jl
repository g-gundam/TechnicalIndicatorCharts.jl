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


function df_fields(indicators)
    base = (:ts, :o, :h, :l, :c, :v)
    fs = indicator_fields.(indicators) |> Iterators.flatten |> collect
    combined = Iterators.flatten([base, fs]) |> collect
    map(k -> ifelse(k == :ts, k=>DateTime[], k=>Union{Missing,Float64}[]), combined)
end

function extract_value(value)
    # - value is a Value like BBVal, but I couldn't find a supertype that encompassed all indicator values.
    # - it's only intended to be used indicators that emit multiple values per tick.
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

"""    merge_candle!(last_candle, c)

If last candle is not provided, construct a new candle with the given OHLCV data.
If last candle is provided, mutate last_candle such that it's HLCV are updated.
It's assumed that last_candle and c have the same timestamp.
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

"""
This is meant to be called on timeframe boundaries to onto the chart's
dataframe.  It also does indicator calculation at this time.
"""
function push_new_candle!(chart::Chart, c::Candle)
    vs = map(chart.indicators) do ind
        # what kind of inputs does this indicator want?
        if ismultiinput(ind)
            # TODO - feed it a whole candle instead
            fit!(ind, c.c)
        else
            fit!(ind, c.c)
        end
        if ismultioutput(ind)
            if ismissing(ind.value)
                return repeat([missing], indicator_fields_count(ind))
            else
                return [ind.value.lower, ind.value.central, ind.value.upper]
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

"""
This is for internal housekeeping inside chart.candle.
This happens when we're away from a chart.tf boundary.
This doesn't go into a DataFrame.
"""
function update_last_candle!(chart::Chart, c::Candle)
    row = last(chart.df)
    row.h = c.h
    row.l = c.l
    row.c = c.c
    row.v = c.v
end

# I need a way to feed it candles and indicators
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
        chart.candle = merge_candle!(missing, c)
        push_new_candle!(chart, c)
    else
        # normal case
        chart.candle = merge_candle!(chart.candle, c)
        update_last_candle!(chart, c)
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

"""      chart(name, tf; indicators, visuals)

Construct a Chart instance configured with the given indicators and visual parameters.

# Example

```julia-repl
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

"""
function chart(name, tf; indicators::Vector=[], visuals::Vector{<:Dict}=[])
    df = DataFrame(df_fields(indicators))
    ts = missing
    candle = missing
    return Chart(;name, tf, df, indicators, visuals, ts, candle)
end

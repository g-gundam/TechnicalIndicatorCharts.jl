using OnlineTechnicalIndicators
using OnlineTechnicalIndicators: OPEN_TMPL, HIGH_TMPL, LOW_TMPL, CLOSE_TMPL, VOLUME_TMPL
using Dates

"""    sample_candles(start::DateTime)

Generate a vector of Candle structs using sample data from OnlineTechnicalIndicators.
"""
function sample_candles(start=DateTime("2024-12-25T00:00:00"))
    candles = []
    ts = start
    for i in eachindex(OPEN_TMPL)
        c = Candle(
            ts=ts,
            o=OPEN_TMPL[i],
            h=HIGH_TMPL[i],
            l=LOW_TMPL[i],
            c=CLOSE_TMPL[i],
            v=VOLUME_TMPL[i]
        )
        push!(candles, c)
        ts += Minute(1)
    end
    candles
end

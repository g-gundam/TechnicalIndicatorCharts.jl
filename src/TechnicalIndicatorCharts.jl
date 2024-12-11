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

@kwdef mutable struct Chart
    # This is the user-facing data.
    name::AbstractString                     # name
    tf::Period                               # time frame
    indicators::Vector{TechnicalIndicator}   # indicators to add to the dataframe
    visuals::Vector                          # visualization parameters for each indicator
    df::DataFrame                            # dataframe

    # There is also some internal data that I use to keep track of computations in progress.
    ts::Union{DateTime,Missing}
    candle::Union{Candle,Missing}
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
include("./data.jl")
export update!
export chart
export indicator_fields
export indicator_fields_values

# for ease of debugging, I'm temporarily export these.
export df_fields
export extract_value
export merge_candle!
export flatten_indicator_values
export push_new_candle!
export update_last_candle!


# visualization
# - a function for each indicator
# - exported
include("./visualize.jl")
export visualize

end

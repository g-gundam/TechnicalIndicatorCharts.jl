module TechnicalIndicatorCharts

using Dates
using NanoDates
using Chain
using DataFrames
using DataFramesMeta
using OnlineTechnicalIndicators
using OnlineTechnicalIndicators: TechnicalIndicator
using LightweightCharts

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
# - abbrev
# - private
include("./helpers.jl")

# data calculation
# - export update!
include("./data.jl")
export update!
export chart
export indicator_fields
export indicator_fields_values

# visualization
# - a function for each indicator
# - exported
include("./visualize.jl")
export visualize

end

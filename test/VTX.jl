using TechnicalIndicatorCharts

@testset "VTX" begin
    if !isdefined(Main, :sample_candles)
        include("helper/main.jl")
    end
    chart = Chart(
        "TEST", Minute(1),
        indicators=[VTX{OHLCV{DateTime,Float64,Float64}}(;period=14)],
        visuals=[nothing]
    )
    candles = sample_candles()
    for c in candles
        update!(chart, c)
    end
    @test visualize(chart) isa Any
    # If it gets this far, we can instantiate, update, and visualize.
end

using TechnicalIndicatorCharts

@testset "McGinleyDynamic" begin
    if !isdefined(Main, :sample_candles)
        include("helper/main.jl")
    end
    chart = Chart(
        "TEST", Minute(1),
        indicators=[McGinleyDynamic{Float64}(;period=8)],
        visuals=[nothing]
    )
    candles = sample_candles()
    for c in candles
        update!(chart, c)
    end
    @test visualize(chart) isa Any
    # If it gets this far, we can instantiate, update, and visualize.
end

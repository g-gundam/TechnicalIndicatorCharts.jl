using TechnicalIndicatorCharts

@testset "RSI" begin
    include("helper/main.jl")
    chart = Chart(
        "TEST", Minute(1),
        indicators=[RSI{Float64}(;period=5)],
        visuals=[nothing]
    )
    candles = sample_candles()
    for c in candles
        update!(chart, c)
    end
    @test visualize(chart) isa Any
    # If it gets this far, we can instantiate, update, and visualize.
end

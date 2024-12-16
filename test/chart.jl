using TechnicalIndicatorCharts

@testset "chart" begin
    if !isdefined(Main, :sample_candles)
        include("helper/main.jl")
    end

    # Can a basic, no-indicator chart be constructed?
    @test Chart("ETHUSD", Hour(4)) isa Any
end

using TechnicalIndicatorCharts

@testset "chart" begin
    include("helper/main.jl")

    # Can a basic, no-indicator chart be constructed?
    @test Chart("ETHUSD", Hour(4)) isa Any
end

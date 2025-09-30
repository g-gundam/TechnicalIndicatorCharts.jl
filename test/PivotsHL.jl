using TechnicalIndicatorCharts

@testset "PivotsHL" begin
    # PivotsHL has a special output structure not compatible with standard Chart DataFrame
    # Just test that it can be instantiated
    indicator = PivotsHL{OHLCV{DateTime,Float64,Float64}}(;high_period=10, low_period=10, memory=10)
    @test indicator isa PivotsHL
    # Note: This indicator requires special handling for Chart integration
end

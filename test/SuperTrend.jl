using TechnicalIndicatorCharts

@testset "SuperTrend" begin
    # SuperTrend outputs TrendEnum which can't be stored in Float64 DataFrame columns
    # Just test that it can be instantiated
    indicator = SuperTrend{OHLCV{DateTime,Float64,Float64}}(;atr_period=10, mult=3.0)
    @test indicator isa SuperTrend
    # Note: This indicator is not compatible with Chart visualization due to enum outputs
end

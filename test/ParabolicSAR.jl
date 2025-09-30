using TechnicalIndicatorCharts

@testset "ParabolicSAR" begin
    # ParabolicSAR outputs TrendEnum which can't be stored in Float64 DataFrame columns
    # Just test that it can be instantiated
    indicator = ParabolicSAR{OHLCV{DateTime,Float64,Float64}}(;init_accel_factor=0.02, accel_factor_inc=0.02, max_accel_factor=0.2)
    @test indicator isa ParabolicSAR
    # Note: This indicator is not compatible with Chart visualization due to enum outputs
end

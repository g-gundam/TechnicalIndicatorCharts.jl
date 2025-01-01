denominated_price(mcginleydynamic::McGinleyDynamic) = true

"""$(TYPEDSIGNATURES)

Visualize McGinleyDynamic using 1 lwc_line.
"""
function visualize(mcginleydynamic::McGinleyDynamic, opts::Union{AbstractDict,Nothing}, df::DataFrame)
    name = indicator_fields(mcginleydynamic)[1]
    start = findfirst(!ismissing, df[!, name])
    kwargs = Dict(
        :label_name => "McGinleyDynamic $(mcginleydynamic.period)",
        :line_color => "#058ED9",
        :line_width => 2
    )
    if opts !== nothing
        merge!(kwargs, opts)
    end
    return lwc_line(
        df.ts[start:end],
        [df[!, name][start:end]...];
        kwargs...
    )
end

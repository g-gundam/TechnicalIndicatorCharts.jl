denominated_price(alma::ALMA) = true

"""$(TYPEDSIGNATURES)

Visualize ALMA using 1 lwc_line.
"""
function visualize(alma::ALMA, opts::Union{AbstractDict,Nothing}, df::DataFrame)
    name = indicator_fields(alma)[1]
    start = findfirst(!ismissing, df[!, name])
    kwargs = Dict(
        :label_name => "ALMA $(alma.period)",
        :line_color => "#5B9CF6",
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

denominated_price(t3::T3) = true

"""$(TYPEDSIGNATURES)

Visualize T3 using 1 lwc_line.
"""
function visualize(t3::T3, opts::Union{AbstractDict,Nothing}, df::DataFrame)
    start = t3.period
    name = indicator_fields(t3)[1]
    kwargs = Dict(
        :label_name => "T3 $(t3.period)",
        :line_color => "#FF69B4",
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

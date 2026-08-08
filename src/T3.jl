denominated_price(t3::T3) = true

"""$(TYPEDSIGNATURES)

Return the default visualization config for T3.
"""
function config(t3::T3)
    [lwc_line,
     Dict(
         :label_name => "T3 $(t3.period)",
         :line_color => "#FF69B4",
         :line_width => 2
     )]
end

"""$(TYPEDSIGNATURES)

Visualize T3 using 1 lwc_line.
"""
function visualize(t3::T3, opts::Union{AbstractDict,Nothing}, df::DataFrame)
    start = t3.period
    name = indicator_fields(t3)[1]
    (fn, kwargs) = config(t3)
    if opts !== nothing
        merge!(kwargs, opts)
    end
    return lwc_line(
        df.ts[start:end],
        replace_missing_with(0, df[!, name][start:end]);
        kwargs...
    )
end

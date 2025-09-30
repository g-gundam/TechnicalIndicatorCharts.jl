denominated_price(tema::TEMA) = true

"""$(TYPEDSIGNATURES)

Visualize TEMA using 1 lwc_line.
"""
function visualize(tema::TEMA, opts::Union{AbstractDict,Nothing}, df::DataFrame)
    start = tema.period
    name = indicator_fields(tema)[1]
    kwargs = Dict(
        :label_name => "TEMA $(tema.period)",
        :line_color => "#00CED1",
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

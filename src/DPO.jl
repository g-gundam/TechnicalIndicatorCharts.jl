denominated_price(dpo::DPO) = true

"""$(TYPEDSIGNATURES)

Visualize DPO using 1 lwc_line.
"""
function visualize(dpo::DPO, opts::Union{AbstractDict,Nothing}, df::DataFrame)
    start = dpo.period
    name = indicator_fields(dpo)[1]
    kwargs = Dict(
        :label_name => "DPO $(dpo.period)",
        :line_color => "#9B59B6",
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

denominated_price(psar::ParabolicSAR) = true

"""$(TYPEDSIGNATURES)

Visualize Parabolic SAR using 1 lwc_line.
"""
function visualize(psar::ParabolicSAR, opts::Union{AbstractDict,Nothing}, df::DataFrame)
    sar_kwargs = Dict(
        :label_name => "SAR",
        :line_color => "#FF6D00",
        :line_width => 2
    )
    if opts !== nothing
        if haskey(opts, :sar)
            merge!(sar_kwargs, opts[:sar])
        end
    end

    sar_values = replace_missing_with(0, df[!, :parabolicsar_sar])

    lwc_line(
        df.ts,
        sar_values;
        sar_kwargs...
    )
end

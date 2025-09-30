denominated_price(kst::KST) = false

"""$(TYPEDSIGNATURES)

Visualize KST using 2 lwc_lines.
"""
function visualize(kst::KST, opts::Union{AbstractDict,Nothing}, df::DataFrame)
    kst_kwargs = Dict(
        :label_name => "KST",
        :line_color => "#2962FF",
        :line_width => 2
    )
    signal_kwargs = Dict(
        :label_name => "Signal",
        :line_color => "#FF6D00",
        :line_width => 2
    )
    if opts !== nothing
        if haskey(opts, :kst)
            merge!(kst_kwargs, opts[:kst])
        end
        if haskey(opts, :signal)
            merge!(signal_kwargs, opts[:signal])
        end
    end

    kst_values = replace_missing_with(0, df[!, :kst_kst])
    signal_values = replace_missing_with(0, df[!, :kst_signal])

    [
        lwc_line(
            df.ts,
            kst_values;
            kst_kwargs...
        ),
        lwc_line(
            df.ts,
            signal_values;
            signal_kwargs...
        )
    ]
end

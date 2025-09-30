denominated_price(ttm::TTM) = false

"""$(TYPEDSIGNATURES)

Visualize TTM Squeeze using 2 lwc_lines.
"""
function visualize(ttm::TTM, opts::Union{AbstractDict,Nothing}, df::DataFrame)
    squeeze_kwargs = Dict(
        :label_name => "TTM Squeeze",
        :line_color => "#FF6D00",
        :line_width => 2
    )
    histogram_kwargs = Dict(
        :label_name => "TTM Histogram",
        :line_color => "#2962FF",
        :line_width => 1
    )
    if opts !== nothing
        if haskey(opts, :squeeze)
            merge!(squeeze_kwargs, opts[:squeeze])
        end
        if haskey(opts, :histogram)
            merge!(histogram_kwargs, opts[:histogram])
        end
    end

    squeeze_values = replace_missing_with(0, df[!, :ttm_squeeze])
    histogram_values = replace_missing_with(0, df[!, :ttm_histogram])

    [
        lwc_line(
            df.ts,
            squeeze_values;
            squeeze_kwargs...
        ),
        lwc_line(
            df.ts,
            histogram_values;
            histogram_kwargs...
        )
    ]
end

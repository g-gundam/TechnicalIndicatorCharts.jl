denominated_price(srsi::StochRSI) = false

# TODO: There's probably a fancy way to wrap the collection in a type
# so that copying the data via map could be avoided.
function replace_missing_with(val, collection)
    map(n -> if ismissing(n) val else n end, collection)
end

"""$(TYPEDSIGNATURES)

Visualize StochRSI using 2 lwc_lines.
"""
function visualize(srsi::StochRSI, opts, df::DataFrame)
    k_defaults = Dict(
        :label_name => "StochRSI K",
        :line_color => "#2962FF",
        :line_width => 1,
        :line_type  => LWC_CURVED
    )
    k_kwargs = merge(k_defaults, opts[:k])
    #k_start = findfirst(!ismissing, df[!, :stochrsi_k])
    d_defaults = Dict(
        :label_name => "StochRSI D",
        :line_color => "#FF6D00",
        :line_width => 1,
        :line_type  => LWC_CURVED,
    )
    d_kwargs = merge(d_defaults, opts[:d])
    #d_start = findfirst(!ismissing, df[!, :stochrsi_d])
    #@info "start" k_start d_start
    k = replace_missing_with(0, df[!, :stochrsi_k])
    #k = Padded(df[!, :stochrsi_k])
    d = replace_missing_with(0, df[!, :stochrsi_d])
    #d = Padded(df[!, :stochrsi_d])
    [
        lwc_line(
            df.ts,
            k;
            k_kwargs...
        ),
        lwc_line(
            df.ts,
            d;
            d_kwargs...
        )
    ]
end

denominated_price(cks::ChandeKrollStop) = true

"""$(TYPEDSIGNATURES)

Visualize ChandeKrollStop using 2 lwc_lines.
"""
function visualize(cks::ChandeKrollStop, opts::Union{AbstractDict,Nothing}, df::DataFrame)
    long_kwargs = Dict(
        :label_name => "Long Stop",
        :line_color => "#4CAF50",
        :line_width => 2
    )
    short_kwargs = Dict(
        :label_name => "Short Stop",
        :line_color => "#F44336",
        :line_width => 2
    )
    if opts !== nothing
        if haskey(opts, :long_stop)
            merge!(long_kwargs, opts[:long_stop])
        end
        if haskey(opts, :short_stop)
            merge!(short_kwargs, opts[:short_stop])
        end
    end

    long_values = replace_missing_with(0, df[!, :chandekrollstop_long_stop])
    short_values = replace_missing_with(0, df[!, :chandekrollstop_short_stop])

    [
        lwc_line(
            df.ts,
            long_values;
            long_kwargs...
        ),
        lwc_line(
            df.ts,
            short_values;
            short_kwargs...
        )
    ]
end

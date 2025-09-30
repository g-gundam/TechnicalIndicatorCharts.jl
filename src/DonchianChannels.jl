denominated_price(dc::DonchianChannels) = true

"""$(TYPEDSIGNATURES)

Visualize Donchian Channels using 3 lwc_lines.
"""
function visualize(dc::DonchianChannels, opts::Union{AbstractDict,Nothing}, df::DataFrame)
    upper_kwargs = Dict(
        :label_name => "DC Upper",
        :line_color => "#2962FF",
        :line_width => 2
    )
    middle_kwargs = Dict(
        :label_name => "DC Middle",
        :line_color => "#FF6D00",
        :line_width => 1
    )
    lower_kwargs = Dict(
        :label_name => "DC Lower",
        :line_color => "#2962FF",
        :line_width => 2
    )
    if opts !== nothing
        if haskey(opts, :upper)
            merge!(upper_kwargs, opts[:upper])
        end
        if haskey(opts, :middle)
            merge!(middle_kwargs, opts[:middle])
        end
        if haskey(opts, :lower)
            merge!(lower_kwargs, opts[:lower])
        end
    end

    upper_values = replace_missing_with(0, df[!, :donchianchannels_upper])
    middle_values = replace_missing_with(0, df[!, :donchianchannels_middle])
    lower_values = replace_missing_with(0, df[!, :donchianchannels_lower])

    [
        lwc_line(
            df.ts,
            upper_values;
            upper_kwargs...
        ),
        lwc_line(
            df.ts,
            middle_values;
            middle_kwargs...
        ),
        lwc_line(
            df.ts,
            lower_values;
            lower_kwargs...
        )
    ]
end

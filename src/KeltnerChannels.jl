denominated_price(keltnerchannels::KeltnerChannels)   = true

"""$(TYPEDSIGNATURES)

Visualize Keltner Channels (KC) using 3 lwc_lines.
"""
function visualize(keltnerchannels::KeltnerChannels, opts::Union{AbstractDict,Nothing}, df::DataFrame)
    start = findfirst(!ismissing, df[!, :keltnerchannels_central])
    upper_kwargs = Dict(
        :label_name => "KeltnerChannels upper",
        :line_color => "#2962FF",
        :line_width => 3
    )
    central_kwargs = Dict(
        :label_name => "KeltnerChannels central",
        :line_color => "#2962FF",
        :line_width => 1
    )
    lower_kwargs = Dict(
        :label_name => "KeltnerChannels lower",
        :line_color => "#2962FF",
        :line_width => 2
    )
    if opts !== nothing
        if haskey(opts, :upper)
            merge!(upper_kwargs, opts[:upper])
        end
        if haskey(opts, :central)
            merge!(central_kwargs, opts[:central])
        end
        if haskey(opts, :lower)
            merge!(lower_kwargs, opts[:lower])
        end
    end
    # [2024-07-12 Fri 08:08] This is the first visualization to combine multiple LWCCharts into one.
    [
        lwc_line(
            df.ts[start:end],
            [df[!, :keltnerchannels_upper][start:end]...];
            upper_kwargs...
        ),
        lwc_line(
            df.ts[start:end],
            [df[!, :keltnerchannels_central][start:end]...];
            central_kwargs...
        ),
        lwc_line(
            df.ts[start:end],
            [df[!, :keltnerchannels_lower][start:end]...];
            lower_kwargs...
        ),
    ]
end

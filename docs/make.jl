using TechnicalIndicatorCharts
using Documenter

DocMeta.setdocmeta!(TechnicalIndicatorCharts, :DocTestSetup, :(using TechnicalIndicatorCharts); recursive=true)

makedocs(;
    modules=[TechnicalIndicatorCharts],
    authors="contributors",
    sitename="TechnicalIndicatorCharts.jl",
    format=Documenter.HTML(;
        canonical="https://g-gundam.github.io/TechnicalIndicatorCharts.jl",
        edit_link="main",
        assets=String[],
    ),
    pages=[
        "Home"       => "index.md",
        "Indicators" => "indicators.md",
        "API"        => "api.md"
    ],
)

deploydocs(;
    repo="github.com/g-gundam/TechnicalIndicatorCharts.jl",
    devbranch="main",
    versions="v.#.#.#",
)

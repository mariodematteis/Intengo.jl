using Documenter, Intengo

makedocs(
    sitename = "Intengo.jl",
    format = Documenter.HTML(prettyurls = !("local" in ARGS))
)

deploydocs(
    repo    = "github.com/BopaxDev/Intengo.jl.git",
    target  = "build",
    deps    = nothing,
    make    = nothing
)
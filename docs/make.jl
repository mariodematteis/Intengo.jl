using Documenter, Intengo

makedocs(
    modules = [ Intengo ],
    doctest = true,
    format = :html,
    sitename = "Intengo.jl",
    authors = "Mario Nicolò De Matteis",
    linkcheck = false,
    pages = [
        "Home" => "index.md"
    ],
    html_prettyurls = !("local" in ARGS),
)

deploydocs(
    repo    = "github.com/BopaxDev/Intengo.jl.git",
    target  = "build",
    deps    = nothing,
    make    = nothing
)
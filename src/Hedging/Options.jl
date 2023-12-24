using Distributions

include("../Pricing/Options.jl")

function Δ(type:: String, 𝖲₀::Union{Float64, Int}, K::Union{Float64, Int}, r::Union{Float64, Int}, σ::Union{Float64, Int}, t::Union{Float64, Int}; q::Union{Float64, Int} = 0)::Union{Float64, nothing}
    if type == "EuropeanCall"
        return cdf(Normal(), 𝖽₁(𝖲₀, K, r, σ, t, q))
    elseif type == "EuropeanPut"
        return cdf(Normal(), 𝖽₁(𝖲₀, K, r, σ, t, q)) - 1
    else
        nothing
    end
end
using Distributions
using DifferentialEquations

function LogNormalStockPrices(𝖲₀::Union{Float64,Int}, μ::Union{Float64,Int}, σ::Union{Float64,Int}, P::Int, S::Int)
    dW = rand(Normal(0, sqrt(1 / S)), P, S)
    return transpose(𝖲₀ .* exp.(cumsum(((μ / S) - ((σ / sqrt(S))^2 / 2)) .+ (σ * dW), dims=2)))
end
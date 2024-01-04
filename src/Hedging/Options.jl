using Distributions

include("../Pricing/Options.jl")


"""
    Δ(type::String, 𝖲₀::Union{Float64, Int}, K::Union{Float64, Int}, r::Union{Float64, Int}, σ::Union{Float64, Int}, T::Union{Float64, Int}; q::Union{Float64, Int} = 0)

Computing Delta of European Call or Put Option
"""
function Δ(type::String, 𝖲₀::Union{Float64, Int}, K::Union{Float64, Int}, r::Union{Float64, Int}, σ::Union{Float64, Int}, T::Union{Float64, Int}; q::Union{Float64, Int} = 0)::Union{Float64, Nothing}
    if type == "EuropeanCall"
        return cdf(Normal(), 𝖽₁(𝖲₀, K, r, σ, T, q))
    elseif type == "EuropeanPut"
        return cdf(Normal(), 𝖽₁(𝖲₀, K, r, σ, T, q)) - 1
    else
        nothing
    end
end


"""
    Θ(type::String, 𝖲₀::Union{Float64, Int}, K::Union{Float64, Int}, r::Union{Float64, Int}, σ::Union{Float64, Int}, T::Union{Float64, Int}; q::Union{Float64, Int} = 0)

Computing Theta of European Call or Put Option
"""
function Θ(type::String, 𝖲₀::Union{Float64, Int}, K::Union{Float64, Int}, r::Union{Float64, Int}, σ::Union{Float64, Int}, T::Union{Float64, Int}; q::Union{Float64, Int} = 0)::Union{Float64, Nothing}
    if type == "EuropeanCall"
        return - (𝖲₀ * pdf(Normal(), 𝖽₁(𝖲₀, K, r, σ, T, q)) * σ) / (2 * sqrt(T)) - r * K * exp(- r * T) * cdf(Normal(), 𝖽₂(𝖲₀, K, r, σ, T, q))
    elseif type == "EuropeanPut"
        return - (𝖲₀ * pdf(Normal(), 𝖽₁(𝖲₀, K, r, σ, T, q)) * σ) / (2 * sqrt(T)) + r * K * exp(- r * T) * cdf(Normal(), - 𝖽₂(𝖲₀, K, r, σ, T, q))
    else
        nothing
    end
end


"""
    Γ(𝖲₀::Union{Float64, Int}, K::Union{Float64, Int}, r::Union{Float64, Int}, σ::Union{Float64, Int}, T::Union{Float64, Int}; q::Union{Float64, Int} = 0)

Computing Γ of European Call or Put Option
"""
function Γ(𝖲₀::Union{Float64, Int}, K::Union{Float64, Int}, r::Union{Float64, Int}, σ::Union{Float64, Int}, T::Union{Float64, Int}; q::Union{Float64, Int} = 0)::Union{Float64, Nothing}
    return pdf(Normal(), 𝖽₁(𝖲₀, K, r, σ, T, q)) / (𝖲₀ * σ * sqrt(T))
end


"""
    ν(𝖲₀::Union{Float64, Int}, K::Union{Float64, Int}, r::Union{Float64, Int}, σ::Union{Float64, Int}, T::Union{Float64, Int}; q::Union{Float64, Int} = 0)

Computing Vega of European Call or Put Option
"""
function ν(𝖲₀::Union{Float64, Int}, K::Union{Float64, Int}, r::Union{Float64, Int}, σ::Union{Float64, Int}, T::Union{Float64, Int}; q::Union{Float64, Int} = 0)::Union{Float64, Nothing}
    return 𝖲₀ * sqrt(T) * pdf(Normal(), 𝖽₁(𝖲₀, K, r, σ, T, q))
end


"""
    ρ(type::String, 𝖲₀::Union{Float64, Int}, K::Union{Float64, Int}, r::Union{Float64, Int}, σ::Union{Float64, Int}, T::Union{Float64, Int}; q::Union{Float64, Int} = 0)

Computing Theta of European Call or Put Option
"""
function ρ(type::String, 𝖲₀::Union{Float64, Int}, K::Union{Float64, Int}, r::Union{Float64, Int}, σ::Union{Float64, Int}, T::Union{Float64, Int}; q::Union{Float64, Int} = 0)::Union{Float64, Nothing}
    if type == "EuropeanCall"
        return K * T * exp(- r * T) * cdf(Normal(), 𝖽₂(𝖲₀, K, r, σ, T, q))
    elseif type == "EuropeanPut"
        return - K * T * exp(- r * T) * cdf(Normal(), - 𝖽₂(𝖲₀, K, r, σ, T, q))
    else
        nothing
    end
end
using Distributions

include("../Pricing/Options.jl")


"""
    Δ(type::String, 𝖲₀::Union{Float64, Int}, K::Union{Float64, Int}, r::Union{Float64, Int}, σ::Union{Float64, Int}, T::Union{Float64, Int}; q::Union{Float64, Int} = 0)

Computing Delta of European Call or Put Option.
The delta (Δ) is defined as the rate of change of the option price with respect to the price of the underlying asset.
It is the slope of the curve that relates the option price to the underlying asset price.
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

Computing Theta of European Call or Put Option.
The theta (Θ) of a portfolio of options is the rate of change of the value of the portfolio with respect to the passage of time with all else remaining the same.
Theta is sometimes referred to as the time decay of the portfolio.
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

Computing Gamma of European Call or Put Option.
The gamma (Γ) of a portfolio of options on an underlying asset is the rate of change of the portfolio's delta with respect to the price of the underlying asset.
It is the second partial derivative of the portfolio with respect to asset price.
"""
function Γ(𝖲₀::Union{Float64, Int}, K::Union{Float64, Int}, r::Union{Float64, Int}, σ::Union{Float64, Int}, T::Union{Float64, Int}; q::Union{Float64, Int} = 0)::Union{Float64, Nothing}
    return pdf(Normal(), 𝖽₁(𝖲₀, K, r, σ, T, q)) / (𝖲₀ * σ * sqrt(T))
end


"""
    ν(𝖲₀::Union{Float64, Int}, K::Union{Float64, Int}, r::Union{Float64, Int}, σ::Union{Float64, Int}, T::Union{Float64, Int}; q::Union{Float64, Int} = 0)

Computing Vega of European Call or Put Option.
The vega (ν) of an option is the rate of change in its value with respect to the volatility of the underlying asset.
The value of an option is liable to change because of movements in volatility as well as because of changes in the asset price and the passage of time.
"""
function ν(𝖲₀::Union{Float64, Int}, K::Union{Float64, Int}, r::Union{Float64, Int}, σ::Union{Float64, Int}, T::Union{Float64, Int}; q::Union{Float64, Int} = 0)::Union{Float64, Nothing}
    return 𝖲₀ * sqrt(T) * pdf(Normal(), 𝖽₁(𝖲₀, K, r, σ, T, q))
end


"""
    ρ(type::String, 𝖲₀::Union{Float64, Int}, K::Union{Float64, Int}, r::Union{Float64, Int}, σ::Union{Float64, Int}, T::Union{Float64, Int}; q::Union{Float64, Int} = 0)

Computing Rho of European Call or Put Option.
The rho (ρ) of an option is the rate of change of its price with respect to the interest rate.
It measures the sensitivity of the value of a portfolio to a change in the interest rate when all else remains the same.
In practice (at least for European options) the interest rate is usually set equal to the risk-free rate for a maturity equal to the option's maturity.
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
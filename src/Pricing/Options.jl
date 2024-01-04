using Distributions

function PV(D::Vector, T::Vector, r::Union{Float64,Int})::Float64
    present_values = 0

    if (length(D) != length(T)) || length(D) == 0 || length(T) == 0
        return present_values
    end

    for (d, t) in zip(D, T)
        present_values += d * exp(-r * t)
    end

    return present_values

end

𝖽₁(𝖲₀::Union{Float64,Int}, K::Union{Float64,Int}, r::Union{Float64,Int}, σ::Union{Float64,Int}, t::Union{Float64,Int}, q::Union{Float64, Int} = 0)::Float64 = (log(𝖲₀ / K) + ((r - q) + ((σ^2) / 2)) * t) / (σ * sqrt(t));

𝖽₂(𝖲₀::Union{Float64,Int}, K::Union{Float64,Int}, r::Union{Float64,Int}, σ::Union{Float64,Int}, t::Union{Float64,Int}, q::Union{Float64, Int} = 0)::Float64 = (log(𝖲₀ / K) + ((r - q) - ((σ^2) / 2)) * t) / (σ * sqrt(t));

function BSEuropeanCallOptionPricing(𝖲₀::Union{Float64,Int}, K::Union{Float64,Int}, r::Union{Float64,Int}, σ::Union{Float64,Int}, t::Union{Float64,Int}; q::Union{Float64, Int} = 0, D::Vector = [], T::Vector = [])::Float64
    if q == 0
        return (𝖲₀ - PV(D, T, r)) * cdf(Normal(), 𝖽₁((𝖲₀ - PV(D, T, r)), K, r, σ, t)) - K * exp(- r * t) * cdf(Normal(), 𝖽₂((𝖲₀ - PV(D, T, r)), K, r, σ, t));
    else
        return (𝖲₀ - PV(D, T, r)) * exp(- q * t) * cdf(Normal(), 𝖽₁((𝖲₀ - PV(D, T, r)), K, r, σ, t, q)) - K * exp(- r * t) * cdf(Normal(), 𝖽₂((𝖲₀ - PV(D, T, r)), K, r, σ, t, q));
    end
end

function BSEuropeanPutOptionPricing(𝖲₀::Union{Float64,Int}, K::Union{Float64,Int}, r::Union{Float64,Int}, σ::Union{Float64,Int}, t::Union{Float64,Int}; q::Union{Float64, Int} = 0, D::Vector = [], T::Vector = [])::Float64
    if q == 0
        return K * exp(- r * t) * (1 - cdf(Normal(), 𝖽₂((𝖲₀ - PV(D, T, r)), K, r, σ, t))) - (𝖲₀ - PV(D, T, r)) * (1 - cdf(Normal(), 𝖽₁((𝖲₀ - PV(D, T, r)), K, r, σ, t)));
    else
        return K * exp(- r * t) * (1 - cdf(Normal(), 𝖽₂((𝖲₀ - PV(D, T, r)), K, r, σ, t, q))) - (𝖲₀ - PV(D, T, r)) * exp(- q * t) * (1 - cdf(Normal(), 𝖽₁((𝖲₀ - PV(D, T, r)), K, r, σ, t, q))); 
    end
end

function MonteCarloAmericanCallOptionPricing(𝖲₀::Union{Float64,Int}, K::Union{Float64,Int}, μ::Union{Float64,Int}, σ::Union{Float64,Int}; N::Int=10000, S::Int=10000)
    values = zeros(N)

    for i ∈ values
        dW = rand(Normal(0, sqrt(1 / S)), 1, S)
        path = transpose(𝖲₀ .* exp.(cumsum(((μ / S) - ((σ / sqrt(S))^2 / 2)) .+ (σ * dW), dims=2)))
        values[i] = max(last(path) - K, 0)
    end

    return exp(- r * t) * mean(values)
end

function MonteCarloAmericanPutOptionPricing(𝖲₀::Union{Float64,Int}, K::Union{Float64,Int}, μ::Union{Float64,Int}, σ::Union{Float64,Int}; N::Int=10000, S::Int=10000)
    values = zeros(N)

    for i ∈ values
        dW = rand(Normal(0, sqrt(1 / S)), 1, S)
        path = transpose(𝖲₀ .* exp.(cumsum(((μ / S) - ((σ / sqrt(S))^2 / 2)) .+ (σ * dW), dims=2)))
        values[i] = max(K - last(path), 0)
    end

    return exp(- r * t) * mean(values)
end
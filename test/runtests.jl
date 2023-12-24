using Intengo
using Test

@testset "Intengo.jl" begin
    @test CallEuropeanOptionPricing(50, 52, 0.05, 0.1, 0.5) == 1.0908341338718337
    @test CallEuropeanOptionPricing(30, 40, 0.1, 0.5, 0.65) == 2.4355728746353673
    @test CallEuropeanOptionPricing(25, 20, 0.01, 0.1, 0.25) == 5.049938279641463
    @test CallEuropeanOptionPricing(10, 8, 0.05, 0.25, 0.5) == 2.254154545004

    @test CallEuropeanOptionPricing(50, 52, 0.05, 0.1, 0.5, q=0.02) == 0.8885186961422953
    @test CallEuropeanOptionPricing(30, 40, 0.1, 0.5, 0.65, q=0.04) == 2.165398624026505

    @test CallEuropeanOptionPricing(25, 20, 0.01, 0.1, 0.25, D=[2], T=[0.1]) == 3.0526319477040076
    @test CallEuropeanOptionPricing(10, 8, 0.05, 0.25, 0.5, D=[5], T=[0.25]) == 0.0026084809917415602

    @test PutEuropeanOptionPricing(50, 52, 0.05, 0.1, 0.5) == 1.8069495593451315
    @test PutEuropeanOptionPricing(30, 40, 0.1, 0.5, 0.65) == 9.918271409731496
    @test PutEuropeanOptionPricing(25, 20, 0.01, 0.1, 0.25) == 7.275906645132533e-7
    @test PutEuropeanOptionPricing(10, 8, 0.05, 0.25, 0.5) == 0.05663384123065973

    @test PutEuropeanOptionPricing(50, 52, 0.05, 0.1, 0.5, q=0.02) == 2.102142434157191
    @test PutEuropeanOptionPricing(30, 40, 0.1, 0.5, 0.65, q=0.04) == 10.41804447086015

    @test PutEuropeanOptionPricing(25, 20, 0.01, 0.1, 0.25, D=[2], T=[0.1]) == 0.0006953953199584986
    @test PutEuropeanOptionPricing(10, 8, 0.05, 0.25, 0.5, D=[5], T=[0.25]) == 2.742976779687809

    @test Δ("EuropeanCall", 50, 52, 0.05, 0.1, 0.5) == 0.43417452040550686
    @test Δ("EuropeanCall", 30, 40, 0.1, 0.5, 0.65) == 0.36285052026728987

    @test Δ("EuropeanPut", 50, 52, 0.05, 0.1, 0.5) == -0.5658254795944931
    @test Δ("EuropeanPut", 30, 40, 0.1, 0.5, 0.65) == -0.6371494797327102

end

using Test

@testset "Utilities" begin
    using WeightsAndBiasLogger: string_dict

    test1 = (x=1, y="x")
    @test string_dict("", test1) == Dict("x" => 1, "y" => "x")
    @test string_dict("m1", test1) == Dict("m1/x" => 1, "m1/y" => "x")
    test2 = Dict(:x => 1, :y => "x")
    @test string_dict("", test2; ignores=[:y]) == Dict("x" => 1)
end

@testset "Demo" include("demo.jl")

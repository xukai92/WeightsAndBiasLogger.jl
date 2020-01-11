using Test

@testset "Utilities" begin
    using WeightsAndBiasLogger: string_dict

    for info in [
        (x=1, y="x"),
        Dict(:x => 1, :y => "x"),
    ]
        @test string_dict(info) isa Dict{String,Any}
    end
end

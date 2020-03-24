using Test

@testset "Utilities" begin
    using WeightsAndBiasLogger: string_dict

    test1 = (x=1, y="x")
    @test string_dict("", test1) == Dict("x" => 1, "y" => "x")
    @test string_dict("m1", test1) == Dict("m1/x" => 1, "m1/y" => "x")
    test2 = Dict(:x => 1, :y => "x")
    @test string_dict("", test2; ignores=[:y]) == Dict("x" => 1)
end

@testset "Demo" begin
    using Logging, WeightsAndBiasLogger

    logger = WBLogger(project="sample-project")

    args = (n_epochs=1_000, lr=1e-3)

    config!(logger, args)

    with(logger) do
        loss = 0
        for i in 1:args.n_epochs
            loss += randn()
            @info "train" i=i loss=loss
        end
    end
end

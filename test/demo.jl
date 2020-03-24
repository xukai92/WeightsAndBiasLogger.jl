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

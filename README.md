# WeightsAndBiasLogger.jl
Log to [W&B](https://app.wandb.ai/) from Julia

## Prerequisite
1. Install W&B and set it up following [here](https://docs.wandb.com/quickstart)
2. Install [PyCall.jl](https://github.com/JuliaPy/PyCall.jl) 
3. Make sure PyCall is configured to use the same Python env as W&B is installed
    - https://github.com/JuliaPy/PyCall.jl#specifying-the-python-version

## Installation
- From REPL: `] add https://github.com/xukai92/WeightsAndBiasLogger.jl`
- By code: `using Pkg; Pkg.add("https://github.com/xukai92/WeightsAndBiasLogger.jl")`

## Example
```julia
using Logging, WeightsAndBiasLogger

logger = WBLogger(project="sample-project")

args = (n_epochs=1_000, lr=1e-3)

config!(logger, args)

with_logger(logger) do
    loss = 0
    for i in 1:args.n_epochs
        loss += randn()
        @info "train" i=i loss=loss
    end
end
```
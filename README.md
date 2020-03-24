# WeightsAndBiasLogger.jl

![Test](https://github.com/xukai92/WeightsAndBiasLogger.jl/workflows/Test/badge.svg?branch=master)
[![Coverage Status](https://coveralls.io/repos/github/xukai92/WeightsAndBiasLogger.jl/badge.svg?branch=master)](https://coveralls.io/github/xukai92/WeightsAndBiasLogger.jl?branch=master)

## Installation

- From REPL: `] add https://github.com/xukai92/WeightsAndBiasLogger.jl`
- By code: `using Pkg; pkg"add https://github.com/xukai92/WeightsAndBiasLogger.jl"`

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

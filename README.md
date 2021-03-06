# WeightsAndBiasLogger.jl

| Travis CI | Coveralls | LICENSE |
| :-: | :-: | :-: |
| [![Build Status](https://travis-ci.org/xukai92/WeightsAndBiasLogger.jl.svg?branch=master)](https://travis-ci.org/xukai92/WeightsAndBiasLogger.jl) | [![Coverage Status](https://coveralls.io/repos/github/xukai92/WeightsAndBiasLogger.jl/badge.svg?branch=master)](https://coveralls.io/github/xukai92/WeightsAndBiasLogger.jl?branch=master) | [![License](https://img.shields.io/badge/license-MIT-blue.svg)](https://github.com/xukai92/WeightsAndBiasLogger.jl/blob/master/LICENSE) |

## Installation

- From REPL: `] add WeightsAndBiasLogger`
- By code: `using Pkg; pkg"add WeightsAndBiasLogger"`

## Demo

```julia
using Logging, WeightsAndBiasLogger

args = (n_epochs=1_000, lr=1e-3)

logger = WBLogger(project="sample-project")

config!(logger, args)

with(logger) do
    loss = 0
    for i in 1:args.n_epochs
        loss += randn() * args.lr
        @info "train" i=i loss=loss
    end
end
```

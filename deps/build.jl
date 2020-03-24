import Conda
ENVPATH = Conda.ROOTENV
Conda.add("pip")
PIP = joinpath(ENVPATH, "bin/pip")
run(`$PIP install wandb matplotlib`)

import Pkg
PYTHON = joinpath(ENVPATH, "bin/python")
ENV["PYTHON"] = PYTHON
Pkg.build("PyCall")

import Conda
Conda.add("pip")
ENVPATH = Conda.ROOTENV
PIP = joinpath(ENVPATH, "bin/pip")
run(`$PIP install wandb matplotlib`)

import Pkg
PYTHON = joinpath(ENVPATH, "bin/python")
ENV["PYTHON"] = PYTHON
Pkg.build("PyCall")

import Pkg
PYTHON_PATH = joinpath(Conda.ROOTENV, "bin/python")
ENV["PYTHON"] = PYTHON_PATH
Pkg.build("PyCall")

import Conda
Conda.add("pip")
PIP_PATH = joinpath(Conda.ROOTENV, "bin/pip")
run(`$PIP_PATH install wandb matplotlib`)

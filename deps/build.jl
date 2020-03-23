import Conda
Conda.add("pip")

PIP_PATH = joinpath(Conda.ROOTENV, "bin/pip")
run(`$PIP_PATH install wandb`)

run(`julia configure_pycall.jl`)

using PyCall

const PIP = joinpath(split(PyCall.PYTHONHOME, ":")[end], "bin/pip")

function pipinstall(pkg)
    try
        pyimport(pkg)
    catch
        println("`$pkg` is not available in the current PyCall.jl.")
        println("Installing using pip ...")
        run(`$PIP install $pkg`)
    end
end

pipinstall("matplotlib")
pipinstall("wandb")

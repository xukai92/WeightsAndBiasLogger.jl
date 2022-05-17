run(`julia configure_pycall.jl`)

using PyCall

include("set_pip.jl")

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

using PyCall, Conda, Pkg

getpip() = joinpath(split(PyCall.PYTHONHOME, ":")[end], "bin/pip")

if !isfile(getpip())
    println("`pip` is not available in the current PyCall.jl")
    println("Configuring PyCall.jl to use Conda.jl")
    ENV["PYTHON"] = joinpath(Conda.PYTHONDIR, "bin/python")
    rm(Pkg.dir("PyCall", "deps", "PYTHON"))
    Pkg.build("PyCall")
end

function pipinstall(pkg)
    try
        pyimport(pkg)
    catch
        println("`$pkg` is not available in the current PyCall.jl.")
        println("Installing using pip ...")
        run(`$(getpip()) install $pkg`)
    end
end

pipinstall("matplotlib")
pipinstall("wandb")

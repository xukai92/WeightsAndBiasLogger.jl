using PyCall, Pkg

pip = joinpath(split(PyCall.PYTHONHOME, ":")[end], "bin/pip")

if !isfile(pip)
    println("`pip` is not available in the current PyCall.jl")
    println("Configuring PyCall.jl to use Conda.jl")
    ENV["PYTHON"] = ""
    rm(Pkg.dir("PyCall", "deps", "PYTHON"))
    Pkg.build("PyCall")
end

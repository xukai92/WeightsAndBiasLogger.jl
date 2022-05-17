import PyCall, Pkg

include("set_pip.jl")

if !isfile(PIP)
    println("`pip` is not available in the current PyCall.jl")
    println("Configuring PyCall.jl to use Conda.jl")
    ENV["PYTHON"] = ""
    Pkg.build("PyCall")
end

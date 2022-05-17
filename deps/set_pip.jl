if Sys.iswindows()
    const PIP = joinpath(PyCall.PYTHONHOME, "Scripts", "pip.exe")
else
    const PIP = joinpath(split(PyCall.PYTHONHOME, ":")[end], "bin/pip")
end

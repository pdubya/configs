
using Pkg
if isinteractive()
    @eval using VimBindings
end
if isfile("Project.toml") && isfile("Manifest.toml")
    Pkg.activate(".")
end

using Revise
using KittyMakie

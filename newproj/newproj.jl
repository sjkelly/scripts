#! /usr/bin/env julia --compile=min 

using Pkg
Pkg.activate(dirname(@__FILE__); io = devnull)
Pkg.instantiate()
using PkgTemplates

function newproj(projname, orgname = "sjkelly")
    tpl = Template(;
        user = orgname,
        plugins = [
            Git(; manifest = false, ssh = true),
            Documenter{GitHubActions}(),
            TagBot(),
            CompatHelper(),
            Dependabot(),
            Codecov(),
            Coveralls(),
            GitHubActions(; linux = true, osx = true),
            Tests(;
                project = true,
                aqua = true,
                aqua_kwargs = NamedTuple(),
                jet = true
            ),
            Formatter(;
                file = "./.JuliaFormatter.toml"
            )
        ]
    )

    return tpl(projname)
end

if !isempty(ARGS)
    newproj(ARGS[1])
else
    println("Usage: newproj <project name> <orgname>")
end
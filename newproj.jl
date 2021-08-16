#! /usr/bin/env julia

using PkgTemplates

function newproj(name)
    tpl = Template(;
    plugins=[
        Git(; manifest=false, ssh=true),
        Documenter{GitHubActions}(),
        TagBot(),
        GitHubActions(;linux=true, osx=true),
        Develop()
    ],
)

    tpl(name)
end

if !isempty(ARGS)
    newproj(ARGS[1])
else
    println("Usage: newproj <project name>")
end
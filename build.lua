local files = {
    "init",
    "images",
    "utils",
    "songs",
    "game",
    "events",
}

Make = function()

    local file = ""
    make = io.open("build/make.lua", "w")
    for k, f in next, files do
        file = file .. io.open(f .. ".lua"):read("*a") .. "\n\n"
    end
    make:write(file)
end

Make()

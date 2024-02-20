local function Game(name)
    local Game = {}

    Data[name].guitar = tfm.exec.addImage(IMAGES.Guitar, ":0", 150, 50, name, 0.75, 0.75)
    
    return Game
end

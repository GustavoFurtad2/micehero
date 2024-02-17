eventNewPlayer = function(name)
    Data[name] = Data[name] or DATA_STRUCTURE
    Data[name].background = tfm.exec.addImage(IMAGES.Black, ":0", 0, 0, name, 800, 400)
    
    Data[name].guitar = tfm.exec.addImage(IMAGES.Guitar, ":0", 150, 50, name, 0.75, 0.75)
end

eventLoop = function()

    local toDelete = {}
    for index, timer in next, Timers do
        if os.time() >= timer.time then
            timer.toExecute()
            toDelete[#toDelete + 1] = index
        end
    end

    for _, i in next, toDelete do
        table.remove(Timers, i)
    end
end

for _, p in next, tfm.get.room.playerList do
    tfm.exec.freezePlayer(p.playerName, true, false)
    eventNewPlayer(p.playerName)
end

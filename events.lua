eventNewPlayer = function(name)
    Data[name] = Data[name] or Player(name)
    Data[name]:LoadSongsList()
end

eventTextAreaCallback = function(id, name, event)
   if SONGLIST[id] then
      Data[name].gameState = GAMESTATE_PLAYING

      for id = 1,#SONGLIST do
         ui.removeTextArea(id, name)
      end

      for i, v in next, Data[name]:GetList() do
         tfm.exec.removeImage(v)
      end
      Data[name]:Play(SONGLIST[id])
   end
end

eventKeyboard = function(name, key, down, x, y)
    if Data[name].gameState == GAMESTATE_MUSICLIST then
        if key == KEY.UP then
           Data[name].option = Data[name].option - 1
           if Data[name].option < 1 then
              Data[name].option = #SONGLIST
           end
        elseif key == KEY.DOWN then
            Data[name].option = Data[name].option + 1
            if Data[name].option > #SONGLIST then
               Data[name].option = 1
            end
        end
    end
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
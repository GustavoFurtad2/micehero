local function Player(name)
    local Player = DATA_STRUCTURE

    function Player:LoadSongsList() 
        for id, song in next, SONGLIST do
            if id <= 2 then
	              ui.addTextArea(id, string.format("<font color='#%s'><a href='event:%s'>%s</a>", ALBUMS[SONGLIST[id].album].color, id, song.name), name, 10, 10 + (id * 50), 300, 25, 0xf, 0xf, 1, true)
            else
                if SONGLIST[id - 1].album ~= SONGLIST[id].album then
	              		ui.addTextArea(id, string.format("<font color='#%s'><a href='event:%s'>%s</a>", ALBUMS[SONGLIST[id].album].color, id, song.name), name, 10, 10 + (id * 50) + (SONGLIST[id - 2].album == SONGLIST[id - 1].album and 0 or 35), 300, 25, 0xf, 0xf, 1, true)
                else
	              		ui.addTextArea(id, string.format("<font color='#%s'><a href='event:%s'>%s</a>", ALBUMS[SONGLIST[id].album].color, id, song.name), name, 10, 10 + (id * 50), 300, 25, 0xf, 0xf, 1, true)
                end
            end
            if id > 1 then
                if SONGLIST[id - 1].album ~= SONGLIST[id].album then
                    table.insert(self.list, tfm.exec.addImage(ALBUMS[SONGLIST[id].album].image, "&100", 320, 10 + (id * 50) + (SONGLIST[id - 2].album == SONGLIST[id - 1].album and 0 or 35), name, 0.25, 0.25))
                end
            else
                table.insert(self.list, tfm.exec.addImage(ALBUMS[SONGLIST[id].album].image, "&100", 320, 10 + (id * 50), name, 0.25, 0.25))
            end
        end
    end

    function Player:Play(song)
        Data[name].guitar = tfm.exec.addImage(IMAGES.Guitar, ":0", 150, 50, name, 0.75, 0.75)
    end
    return Player
end
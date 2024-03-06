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
        Data[name].guitar = tfm.exec.addImage(IMAGES.Guitar, "?0", 150, 50, name, 0.75, 0.75, 0, 1, 0, 0, true)
        for t = 1, 100, 2 do
            self.gradient[t] = tfm.exec.addImage(IMAGES.BgColor, "!1", 0, 30 + t, name, 800, 2, 0, 1 - (t * 0.008))
        end

        for index, chart in next, song.charts do
            Dolater(chart.time, function()

                local vx, x = 0, nil
                if chart.color == "green" then
                  vx = chart.speed * -0.45
                  x = 360
                elseif chart.color == "red" then
                  vx = chart.speed * -0.25
                  x = 380
                elseif chart.color == "yellow" then
                  x = 385
                end
                local vy = chart.speed

                local chartIndex = #self.charts+1
                self.charts[chartIndex] = {}
                --self.charts[#self.charts].object = tfm.exec.addShamanObject(1, 360, 80, 0, vx, vy)
                self.charts[chartIndex].object = tfm.exec.addPhysicObject(index, x, 90, {
                    type = 12,
                    width = 20,
                    height = 20,
                    groundCollision = false,
                    dynamic = true,
                })
                tfm.exec.movePhysicObject(index, 0, 0, true, vx, vy)
                self.charts[chartIndex].image = tfm.exec.addImage(IMAGES[chart.color], "+" .. index, -30, -13, name, 0.265, 0.265, 0, 1, 0, 0, true)

                local positionPrediction = (1000 / chart.speed)
                Dolater(positionPrediction, function()
                    tfm.exec.removeImage(self.charts[chartIndex].image)
                    self.charts[chartIndex].image = tfm.exec.addImage(IMAGES[chart.color], "+" .. index, -34, -16, name, 0.325, 0.325, 0, 1, 0, 0)
                end)
            end)
        end

        for index, sound in next, song.sounds do
            Dolater(sound.time, function()
                for _, s in next, sound.sounds do
                    tfm.exec.playSound(s, 100, nil, nil, name)
                end
                print(index)
            end)
        end
    end

    function Player:GetList()
        return self.list
    end
    return Player
end
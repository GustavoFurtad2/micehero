for _, s in next,{"AutoNewGame","AutoShaman","AfkDeath","MortCommand"} do
  tfm.exec["disable"..s]()
end

tfm.exec.newGame '<C><P Ca="" MEDATA=";;;;-0;0:::1-"/><Z><S><S T="12" X="-196" Y="292" L="55" H="10" P="0,0,0.3,0.2,0,0,0,0" o="324650"/><S T="12" X="-219" Y="268" L="10" H="51" P="0,0,0.3,0.2,0,0,0,0" o="324650"/><S T="12" X="-195" Y="248" L="60" H="10" P="0,0,0.3,0.2,0,0,0,0" o="324650"/><S T="12" X="-170" Y="270" L="10" H="41" P="0,0,0.3,0.2,0,0,0,0" o="324650"/></S><D><DS X="-195" Y="271"/></D><O/><L/></Z></C>'
ui.setMapName("#micehero")
local Data, Timers = {}, {}

local GAMESTATE_MUSICLIST = 0
local GAMESTATE_PLAYING   = 1

local KEY = {
     UP   = 38,
     DOWN = 40,
     A    = 65,
     S    = 83,
     J    = 75,
     K    = 74,
     L    = 76,
}
local DATA_STRUCTURE = {

    gameState = GAMESTATE_MUSICLIST,

    option = 1,
    hits   = 0,
    misses = 0,

    album,
    guitar,
    gradient = {},

    list = {},

    currentMusic,
}

local IMAGES = {
  Red    = "17948d9ecc2.png",
  Green  = "17948da0435.png",
  Blue   = "17948da1ba8.png",
  Black  = "17948da3319.png",
  White  = "17948da4a89.png",
  Guitar = "18daa0baeca.png",
}

local ALBUMS = {
  ["Favourite Worst Nightmare"] = {image = "18daa0b148c.png", color = "BABD2F"},
  ["Humbug"] = {image = "18daa0b61c4.png", color = "C53DFF"},
}

local function lerp(a, b, x) 
    return a + x * (b - a)
end

local function Dolater(time, toExecute)
    Timers[#Timers + 1] = {time = os.time() + time, toExecute = toExecute}
end

local SONGLIST = {
    [1] = {
        name   = "Balaclava",
        author = "Arctic Monkeys",
        album  = "Favourite Worst Nightmare",
    },

    [2] = {
        name   = "Old Yellow Bricks",
        author = "Arctic Monkeys",
        album  = "Favourite Worst Nightmare",
        verses = {
            {3000, "Old Yellow Bricks, Love's Risk"},
        }
    },

    [3] = {
        name   = "Pretty Visitors",
        author = "Arctic Monkeys",
        album  = "Humbug",
    },

    [4] = {
        name   = "Old Yellow Bricks",
        author = "Arctic Monkeys",
        album  = "Favourite Worst Nightmare",
        verses = {
            {3000, "Old Yellow Bricks, Love's Risk"},
        }
    },
}

local function Player(name)
    local Player = DATA_STRUCTURE

    --Data[name].guitar = tfm.exec.addImage(IMAGES.Guitar, ":0", 150, 50, name, 0.75, 0.75)
    function Player:LoadSongsList() 
        for id, song in next, SONGLIST do
            ui.addTextArea(id, string.format("<font color='#%s'>%s", ALBUMS[SONGLIST[id].album].color, song.name), name, 10, 10 + (id * 50), 300, 25, 0xf, 0xf, 1, true)
            
            if id > 1 then
                if SONGLIST[id - 1].album ~= SONGLIST[id].album then
                    table.insert(self.list, tfm.exec.addImage(ALBUMS[SONGLIST[id].album].image, "&100", 320, 85 + (id * 50), name, 0.25, 0.25))
                end
            else
                table.insert(self.list, tfm.exec.addImage(ALBUMS[SONGLIST[id].album].image, "&100", 320, 10 + (id * 50), name, 0.25, 0.25))
            end
        end
    end
    return Player
end

eventNewPlayer = function(name)
    Data[name] = Data[name] or Player(name)
    Data[name]:LoadSongsList()
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


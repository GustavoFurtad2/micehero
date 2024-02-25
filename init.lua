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
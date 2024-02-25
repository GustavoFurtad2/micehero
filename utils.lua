local function lerp(a, b, x) 
    return a + x * (b - a)
end

local function Dolater(time, toExecute)
    Timers[#Timers + 1] = {time = os.time() + time, toExecute = toExecute}
end
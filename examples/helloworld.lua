package.path = "../termine.lua"
local termine = require("fun.termine.termine")
local x, y = 0, 0
local binds = { w = "up", a = "left", s = "down", d = "right" }
for k, v in pairs(binds) do
    termine:addKeybind(v, k)
end

-- ignore the 6 generation parent union of if statements
local function work()
    termine.spawn("->", x, y)
    print("Move (W/A/S/D), type \"exit\" to exit")
    local m = termine:getinp("l")

    if termine.isKeybind(m) then
        if m == "w" then
            y = y - 1
            if y < 0 then
                y = 0
            end
            work()
        elseif m == "a" then
            x = x - 1
            if x < 0 then
                x = 0
            end
            work()
        elseif m == "s" then
            y = y + 1
            work()
        elseif m == "d" then
            x = x + 1
            work()
        elseif m == "exit" then
            print("exiting")
        end
    end
end

work()

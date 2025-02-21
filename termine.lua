local termine = {}

-- Keybinds
termine.keybinds = {}

-- Version
termine._version = { "0.alpha.1.0" --[[Version]], true --[[isAlpha]], false --[[isBeta]] }

-- Adds a Keybind, self-explanatory
function termine:addKeybind(name, bind)
    assert(type(name) == "string", "Keybind Names must be a string!")
    assert(type(bind) == "string", "Keybinds must be a string!")

    termine.keybinds[bind] = name
end

-- Checks if string is a valid keybind
function termine.isKeybind(bind)
    assert(type(bind) == "string", "arg1 must be a string or a keybind")

    return (termine.keybinds[bind]) ~= nil
end

--[[

    Spawns/Prints a text in specified positions (X,Y)

    (char) can be anything, unless if its not nil/undefined, will be converted to a string

    (x,y) are Vector2 (aka Tec2, because vectors arent real in console world.)
]]
function termine.spawn(char, x, y)
    assert(type(x) == "number", "expected a number at arg2, got " .. x)
    assert(type(y) == "number", "expected a number at arg3, got " .. y)
    assert(char ~= nil, "expected *char at arg1, but got nil")

    local ix, iy = x, y
    local xchar = tostring(char)
    local fc = ""

    while math.abs(ix) > 0 do
        fc = fc .. " "
        ix = ix - 1
    end
    while math.abs(iy) > 0 do
        print("\n")
        iy = iy - 1
    end
    xchar = fc .. xchar
    xchar, _ = xchar:gsub('\n', "\n" .. fc)
    print(xchar)
end

-- Get Input from IO, self-explanatory.
function termine:getinp(type)
    return io.read(tostring(type))
end

return termine

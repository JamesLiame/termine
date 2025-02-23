local termine = {}

-- Keybinds
termine.keybinds = {}

-- Version
termine._version = { "0.1.0" --[[Version]], false --[[isAlpha]], false --[[isBeta]] }



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
function termine.spawn(char, pos)
    assert(type(pos[1]) == "number", "expected a number at arg2, got " .. pos[1])
    assert(type(pos[2]) == "number", "expected a number at arg3, got " .. pos[2])
    assert(char ~= nil, "expected *char at arg1, but got nil")

    local ix, iy = pos[1], pos[2]
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
function termine:getinp(typ)
    assert(typ ~= nil, "expected 1 argument, but got none")
    local g, f = pcall(io.read, typ)
    assert(g, "invalid type")
    return f
end

-- Writes to file, self-explanatory
function termine:writetf(name, format, value, append)
    assert(type(format) == "string", "Error while trying to create/write to file: file format is not a string")
    assert(type(name) == "string", "Error while trying to create/write to file: file name is not a string")
    assert(tonumber(format) == nil, "Error while trying to create/write to file: file format is a number in a string")
    assert(type(append) == "boolean", "expected bool in arg4, got " .. tostring(append))
    assert(format ~= nil, "Error while trying to create/write to file: file format not filled")
    assert(name ~= nil, "Error while trying to create/write to file: file name not filled")

    local v = tostring(value)
    local ff = name .. "." .. format
    local n, f = pcall(io.open, ff, (append and "a" or "w"))
    --file = ((file ~= nil) and file or error("cannot find file :("))
    assert(n, "file cannot be found")

    f:write(v)
    return f and f:close()
end

-- Checks if file exists
function termine:existf(file)
    local n, _ = pcall(io.open, file, "r")
    return n
end

-- Reads file
function termine:readf(file)
    local b, f = pcall(io.open, file, "r")
    assert(b, "file doesnt exist")
    return f
end

return termine

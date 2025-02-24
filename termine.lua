local termine = {}
package.path = "../utils/self.lua"
local self = require("self")

-- Keybinds
termine.keybinds = {}

-- Version
termine._version = { "0.beta.1.1" --[[Version]], false --[[isAlpha]], true --[[isBeta]] }

-- entity types
termine._enttypes = {}

-- entities
termine._ent = {}

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
    local _, f = pcall(io.open, ff, (append and "a" or "w"))
    --file = ((file ~= nil) and file or error("cannot find file :("))
    assert(f ~= nil, "file cannot be found")

    f:write(v)
    f:close()
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

function termine.createEntityType(name, fnalt)
    assert((type(name) == "string") or (type(name) == "table"), "Entity Type names must be either a table or a string")
    assert((type(fnalt) == "function") or (type(fnalt) == "table"),
        "Entity type Functionality must be a function or a func table")

    local tf, tn = type(fnalt), type(name)
    local bf, bn, bl = false, false, false
    local tbl = {}
    setmetatable(tbl, {})
    tbl.__index = self:new(tbl)

    -- no if statements plz
    bn = (tn == "table")
    bf = (tf == "table")
    bl = (#tostring(bn) == #tostring(bf))

    assert(bl, "name and fnalt tables are not the same length")

    -- yez if statements and nesting plz
    if bn then
        for i, n in pairs(name) do
            tn = type(n)
            bn = (tn == "table")
            assert(bn, "name table item " .. tostring(i) .. " is not a string")
            if bf then
                for ii, f in pairs(fnalt) do
                    tf = type(f)
                    bf = (tf == "table")
                    assert(bf, "function table item " .. tostring(ii) .. " is not a function")
                    termine._enttypes[n] = f
                    tbl[n] = f
                end
            end
        end
    else
        bn = (tn == "string")
        bf = (tf == "function")
        assert(bn, "name must be a string")
        assert(bf, "fnalt must be a function")
        termine._enttypes[name] = fnalt
        tbl[name] = fnalt
    end

    function tbl:isEntityType(v)
        return tbl[v] ~= nil
    end

    return tbl, name
end

function termine.createEntity(name, typ, values)
    assert(type(typ) == "string", "Entity type must be a string")
    assert(type(values) == "table", "Entity Values must be a table")
    assert(termine._enttypes[typ] ~= nil, "type is not a valid entity type")
    local n = tostring(name)
    termine._ent[n] = { termine._enttypes[typ], values }
end

return termine

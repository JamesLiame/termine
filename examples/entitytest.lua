package.path = "../termine.lua"
local termine = require("termine")
local function tfunc()
    -- test function
    print("Hello, World!")
end
termine.createEntityType("hello", tfunc)
termine.createEntity("test", "hello", {})
local test = termine._ent["test"]
test[1]()

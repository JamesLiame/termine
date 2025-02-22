package.path = "../src/termine.lua"
local termine = require("termine")
local testfile = termine:writetf("test", "txt", "Hello, World!", true)

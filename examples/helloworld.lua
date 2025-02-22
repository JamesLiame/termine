package.path = "../src/termine.lua"
local termine = require("termine")
termine:writetf("test", "txt", "Hello, World!", true)

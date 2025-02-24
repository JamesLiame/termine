package.path = "../termine.lua"
local termine = require("termine")
local g = termine:getinp("l")
termine:writetf("test", "txt", g, false)

package.path = "../termine.lua"
local termine = require("termine")
local v = termine:getinp("l")
print("Do you wanna [Write] or [Read]")
local h = termine:getinp("l")
if h == "write" then
    termine:writetf(
        "test",
        "txt",
        v,
        false
    )
elseif h == "read" then
    print(termine:readf(tostring(v) .. ".txt"))
else
    error("invalid input", 0)
end

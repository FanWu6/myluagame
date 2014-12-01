local UnLockInstance = nil
local UnLock = {}
UnLock.new = function(self) 
    local o = { --可以在此处添加数据
        }; 
    setmetatable(o,self); 
    self.__index = self; 
    return o; 
end

UnLock.Create = function()
end


local function scrollSliderCreate()
    -- body
    UnLockInstance = UnLock:new()
    return UnLockInstance
end

local a = Config._userData
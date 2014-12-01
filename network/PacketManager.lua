-------------------------------------
------wangwei 20140730---------------
-------------------------------------
PacketManager = class("PacketManager")

PacketManager.packetCorList = {}--协程

errorcodelist = {} --错误码
--
--PacketManager.packetHandlerList = {
--	{ isSupported = true,  name = "包Id对应解释", id = 1  , Handler_func = SceneLogInPacketHandler}
--
--}
--
--
--function PacketManager.createEmptyPacket()
--	
--	local packet = {
--
--        packetId = 0,--解析得到的包id
--        
--   }
--
--   return packet
--end
--
--function PacketManager:addPacket( __packet )
--	cclog("PacketManager:addPacket id = "..__packet.packetId)
--	local _handler = nil
--	local _name = "nil"
--	for i,v in ipairs(self.packetHandlerList) do
--		
--		if v.id == __packet.packetId then
--			
--			_handler = v.Handler_func
--			_name = v.name
--			break
--		end
--
--	end
--
--	if nil ~= _handler then
--    	local co = coroutine.create(function ()
--
--    		_handler(__packet)
--
--  		end)
--  		cclog("注册 handler 成功 name = ".._name)
--		table.insert(self.packetCorList, co)
--    else
--      		
--      	cclog("注册 handler 失败")
--    end
--
--
--	
--end
--
--function PacketManager:dispatchPacket()
--	cclog("PacketManager:dispatchPacket")
--
--	while true do
--		local n = table.getn(self.packetCorList)
--		if n==0 then break end
--		for i=1,n do
--			local status, res = coroutine.resume(self.packetCorList[i])
--			print(status, res)
--			if not res then
--				table.remove(self.packetCorList,i)
--				break
--			end
--		end
--	end
--end

function PacketManager.SocketTCPCreate(_CMD,INFOLIST)
   CG_HANDLER(_CMD,INFOLIST)
end
function PacketManager.SocketUnPack(_CMD,_BODY)
    GC_HANDLER(_CMD,_BODY)
end
--错误码管理
local function errorcodeInit()
    local json = require "json"
    local errorData = cc.FileUtils:getInstance():getStringFromFile("res/json/errorcode.json")
    errorcodelist = json.decode(errorData)
end

local function getErrorByResult(_result)
    local result=nil
    for i,v in ipairs(errorcodelist) do
        if tonumber(v.errorid) == _result then
            result = v
            break;
        end
    end
    return result
end

function PacketManager.errorcode(_result)
    local result = getErrorByResult(_result)
    if tonumber(result.errorid) == 10000 then
        print(result.errorid.."   "..result.desc)
       return true
    else
        print(result.errorid.."   "..result.desc)
        showNoButtonTipPanel(result.desc)
       return false
    end
end


errorcodeInit()




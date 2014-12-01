--GCLoginGame.lua
--登陆游戏回复
--指令:PACKET_GC_LoginGame	指令编号10003	十六进制:0x2713
--auto create by roy.z at 2014-09-05
--
 --------------------------------------------------------------

local GCLoginGameInstance = nil 

 --------------------------------------------------------------
function GCLoginGameCreate()
	-- cclog("GCLoginGameCreate")

	GCLoginGame= BaseData:new()

	GCLoginGame.new = function(self) 
		local o = getmetatable(self).new(self)

		o._UnPackData = BaseData:new()
		o._UnPackData.new = function(self) 

			local o = getmetatable(self).new(self)

			--初始化_GCLoginGameData内数据
			o.cmdid = PACKET_GC_LoginGame	--指令编号
			o._result = 0			---回复，登陆是否成功	类型=short


			return o
		end


		GCLoginGame.unpack = function(self,__body) 
--------------------------------回复，登陆是否成功	类型=short	长度 = 0
			local _next1
			_next1,self._UnPackData._result = string.unpack(__body,">H")
		end

		return o
	end

	GCLoginGameInstance = GCLoginGame:new()
	GCLoginGameInstance._UnPackData = GCLoginGameInstance._UnPackData:new()

	return GCLoginGameInstance
end


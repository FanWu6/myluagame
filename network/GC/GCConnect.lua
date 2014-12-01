--GCConnect.lua
--登陆回复
--指令:PACKET_GC_Connect	指令编号10001	十六进制:0x2711
--auto create by roy.z at 2014-09-05
--
 --------------------------------------------------------------

local GCConnectInstance = nil 

 --------------------------------------------------------------
function GCConnectCreate()
	-- cclog("GCConnectCreate")

	GCConnect= BaseData:new()

	GCConnect.new = function(self) 
		local o = getmetatable(self).new(self)

		o._UnPackData = BaseData:new()
		o._UnPackData.new = function(self) 

			local o = getmetatable(self).new(self)

			--初始化_GCConnectData内数据
			o.cmdid = PACKET_GC_Connect	--指令编号
			o._result = 0			---回复，登陆正确与否	类型=short
			o._guid = 0			---玩家在游戏中的编号	类型=int


			return o
		end


		GCConnect.unpack = function(self,__body) 
--------------------------------回复，登陆正确与否	类型=short	长度 = 0
			local _next1
			_next1,self._UnPackData._result = string.unpack(__body,">H")
--------------------------------玩家在游戏中的编号	类型=int	长度 = 0
			local _next2
			_next2,self._UnPackData._guid = string.unpack(__body,">I",_next1)
		end

		return o
	end

	GCConnectInstance = GCConnect:new()
	GCConnectInstance._UnPackData = GCConnectInstance._UnPackData:new()

	return GCConnectInstance
end


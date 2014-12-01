--GCChat.lua
--聊天信息
--指令:PACKET_GC_Chat	指令编号11001	十六进制:0x2AF9
--auto create by roy.z at 2014-09-05
--
 --------------------------------------------------------------

local GCChatInstance = nil 

 --------------------------------------------------------------
function GCChatCreate()
	-- cclog("GCChatCreate")

	GCChat= BaseData:new()

	GCChat.new = function(self) 
		local o = getmetatable(self).new(self)

		o._UnPackData = BaseData:new()
		o._UnPackData.new = function(self) 

			local o = getmetatable(self).new(self)

			--初始化_GCChatData内数据
			o.cmdid = PACKET_GC_Chat	--指令编号
			o._guid = 0			---玩家在游戏中的编号	类型=int
			o._nicknamelen = 0			---玩家昵称数据长度	类型=short
			o._nickname = ""			---玩家昵称	类型=string
			o._cntlen = 0			---聊天内容数据长度	类型=short
			o._cnt = ""			---聊天内容	类型=string
			o._color = 0			---字体颜色	类型=byte


			return o
		end


		GCChat.unpack = function(self,__body) 
--------------------------------玩家在游戏中的编号	类型=int	长度 = 0
			local _next1
			_next1,self._UnPackData._guid = string.unpack(__body,">I")
--------------------------------玩家昵称	类型=string	长度 = 30
			local _next2,_nicknamelen = string.unpack(__body,">H",_next1)
			local _next3
			_next3,self._UnPackData._nickname= string.unpack(__body,">A".._nicknamelen,_next2)
--------------------------------聊天内容	类型=string	长度 = 250
			local _next4,_cntlen = string.unpack(__body,">H",_next3)
			local _next5
			_next5,self._UnPackData._cnt= string.unpack(__body,">A".._cntlen,_next4)
--------------------------------字体颜色	类型=byte	长度 = 0
			local _next6
			_next6,self._UnPackData._color = string.unpack(__body,">b",_next5)
		end

		return o
	end

	GCChatInstance = GCChat:new()
	GCChatInstance._UnPackData = GCChatInstance._UnPackData:new()

	return GCChatInstance
end


--GCPlayerInfo.lua
--回复玩家信息
--指令:PACKET_GC_PlayerInfo	指令编号12005	十六进制:0x2EE5
--auto create by roy.z at 
--
 --------------------------------------------------------------

local GCPlayerInfoInstance = nil 

 --------------------------------------------------------------
function GCPlayerInfoCreate()
	-- cclog("GCPlayerInfoCreate")

	GCPlayerInfo= BaseData:new()

	GCPlayerInfo.new = function(self) 
		local o = getmetatable(self).new(self)

		o._UnPackData = BaseData:new()
		o._UnPackData.new = function(self) 

			local o = getmetatable(self).new(self)

			--初始化_GCPlayerInfoData内数据
			o.cmdid = PACKET_GC_PlayerInfo	--指令编号
			o._guid = 0			---玩家在游戏中的编号	类型=int
			o._nicknamelen = 0			---玩家昵称数据长度	类型=short
			o._nickname = ""			---玩家昵称	类型=string
			o._level = 0			---等级	类型=short
			o._viplevel = 0			---vip等级	类型=short
			o._exp = 0			---团队经验	类型=int
			o._icon = 0			---头像编号	类型=short
			o._sign = 0			---签到当前天数	类型=short
			o._pp = 0			---玩家体力	类型=int
			o._physical = 0			---玩家体力上限	类型=int
			o._gold = 0			---金币	类型=int
			o._diamond = 0			---钻石	类型=int


			return o
		end


		GCPlayerInfo.unpack = function(self,__body) 
--------------------------------玩家在游戏中的编号	类型=int	长度 = 0
			local _next1
			_next1,self._UnPackData._guid = string.unpack(__body,">I")
--------------------------------玩家昵称	类型=string	长度 = 30
			local _next2,_nicknamelen = string.unpack(__body,">H",_next1)
			local _next3
			_next3,self._UnPackData._nickname= string.unpack(__body,">A".._nicknamelen,_next2)
--------------------------------等级	类型=short	长度 = 0
			local _next4
			_next4,self._UnPackData._level = string.unpack(__body,">H",_next3)
--------------------------------vip等级	类型=short	长度 = 0
			local _next5
			_next5,self._UnPackData._viplevel = string.unpack(__body,">H",_next4)
--------------------------------团队经验	类型=int	长度 = 0
			local _next6
			_next6,self._UnPackData._exp = string.unpack(__body,">I",_next5)
--------------------------------头像编号	类型=short	长度 = 0
			local _next7
			_next7,self._UnPackData._icon = string.unpack(__body,">H",_next6)
--------------------------------签到当前天数	类型=short	长度 = 0
			local _next8
			_next8,self._UnPackData._sign = string.unpack(__body,">H",_next7)
--------------------------------玩家体力	类型=int	长度 = 0
			local _next9
			_next9,self._UnPackData._pp = string.unpack(__body,">I",_next8)
--------------------------------玩家体力上限	类型=int	长度 = 0
			local _next10
			_next10,self._UnPackData._physical = string.unpack(__body,">I",_next9)
--------------------------------金币	类型=int	长度 = 0
			local _next11
			_next11,self._UnPackData._gold = string.unpack(__body,">I",_next10)
--------------------------------钻石	类型=int	长度 = 0
			local _next12
			_next12,self._UnPackData._diamond = string.unpack(__body,">I",_next11)
		end

		return o
	end

	GCPlayerInfoInstance = GCPlayerInfo:new()
	GCPlayerInfoInstance._UnPackData = GCPlayerInfoInstance._UnPackData:new()

	return GCPlayerInfoInstance
end


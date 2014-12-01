--GCMidasTouchUse.lua
--回复使用点金手
--指令:PACKET_GC_MidasTouchUse	指令编号13035	十六进制:0x32EB
--auto create by roy.z at 
--
 --------------------------------------------------------------

local GCMidasTouchUseInstance = nil 

 --------------------------------------------------------------
function GCMidasTouchUseCreate()
	-- cclog("GCMidasTouchUseCreate")

	GCMidasTouchUse= BaseData:new()

	GCMidasTouchUse.new = function(self) 
		local o = getmetatable(self).new(self)

		o._UnPackData = BaseData:new()
		o._UnPackData.new = function(self) 

			local o = getmetatable(self).new(self)

			--初始化_GCMidasTouchUseData内数据
			o.cmdid = PACKET_GC_MidasTouchUse	--指令编号
			o._result = 0			---回复，使用点金手正确与否	类型=short
			o._pbdatalen = 0			---protobuff数据，二进制数据长度	类型=short
			o._pbdata = ""			---protobuff数据，二进制	类型=binary
			o._diamond = 0			---钻石	类型=int
			o._gold = 0			---金币	类型=int
			o._totalusetimes = 0			---总使用次数	类型=int
			o._totalusedtimes = 0			---总已使用次数	类型=int
			o._nextcostdiamond = 0			---下次耗费钻石	类型=int
			o._nextcostgold = 0			---下次兑换金币	类型=int


			return o
		end


		GCMidasTouchUse.unpack = function(self,__body) 
--------------------------------回复，使用点金手正确与否	类型=short	长度 = 0
			local _next1
			_next1,self._UnPackData._result = string.unpack(__body,">H")
--------------------------------protobuff数据，二进制	类型=binary	长度 = 1024
			local _next2,_pbdatalen = string.unpack(__body,">H",_next1)
			local _next3
			_next3,self._UnPackData._pbdata= string.unpack(__body,">A".._pbdatalen,_next2)
--------------------------------钻石	类型=int	长度 = 0
			local _next4
			_next4,self._UnPackData._diamond = string.unpack(__body,">I",_next3)
--------------------------------金币	类型=int	长度 = 0
			local _next5
			_next5,self._UnPackData._gold = string.unpack(__body,">I",_next4)
--------------------------------总使用次数	类型=int	长度 = 0
			local _next6
			_next6,self._UnPackData._totalusetimes = string.unpack(__body,">I",_next5)
--------------------------------总已使用次数	类型=int	长度 = 0
			local _next7
			_next7,self._UnPackData._totalusedtimes = string.unpack(__body,">I",_next6)
--------------------------------下次耗费钻石	类型=int	长度 = 0
			local _next8
			_next8,self._UnPackData._nextcostdiamond = string.unpack(__body,">I",_next7)
--------------------------------下次兑换金币	类型=int	长度 = 0
			local _next9
			_next9,self._UnPackData._nextcostgold = string.unpack(__body,">I",_next8)
		end

		return o
	end

	GCMidasTouchUseInstance = GCMidasTouchUse:new()
	GCMidasTouchUseInstance._UnPackData = GCMidasTouchUseInstance._UnPackData:new()

	return GCMidasTouchUseInstance
end


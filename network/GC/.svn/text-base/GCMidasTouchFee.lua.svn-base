--GCMidasTouchFee.lua
--回复点金手费用
--指令:PACKET_GC_MidasTouchFee	指令编号13033	十六进制:0x32E9
--auto create by roy.z at 
--
 --------------------------------------------------------------

local GCMidasTouchFeeInstance = nil 

 --------------------------------------------------------------
function GCMidasTouchFeeCreate()
	-- cclog("GCMidasTouchFeeCreate")

	GCMidasTouchFee= BaseData:new()

	GCMidasTouchFee.new = function(self) 
		local o = getmetatable(self).new(self)

		o._UnPackData = BaseData:new()
		o._UnPackData.new = function(self) 

			local o = getmetatable(self).new(self)

			--初始化_GCMidasTouchFeeData内数据
			o.cmdid = PACKET_GC_MidasTouchFee	--指令编号
			o._result = 0			---回复，点金手费用正确与否	类型=short
			o._diamond = 0			---钻石	类型=int
			o._gold = 0			---金币	类型=int
			o._usedtimes = 0			---已使用次数	类型=int
			o._totaltimes = 0			---总次数	类型=int


			return o
		end


		GCMidasTouchFee.unpack = function(self,__body) 
--------------------------------回复，点金手费用正确与否	类型=short	长度 = 0
			local _next1
			_next1,self._UnPackData._result = string.unpack(__body,">H")
--------------------------------钻石	类型=int	长度 = 0
			local _next2
			_next2,self._UnPackData._diamond = string.unpack(__body,">I",_next1)
--------------------------------金币	类型=int	长度 = 0
			local _next3
			_next3,self._UnPackData._gold = string.unpack(__body,">I",_next2)
--------------------------------已使用次数	类型=int	长度 = 0
			local _next4
			_next4,self._UnPackData._usedtimes = string.unpack(__body,">I",_next3)
--------------------------------总次数	类型=int	长度 = 0
			local _next5
			_next5,self._UnPackData._totaltimes = string.unpack(__body,">I",_next4)
		end

		return o
	end

	GCMidasTouchFeeInstance = GCMidasTouchFee:new()
	GCMidasTouchFeeInstance._UnPackData = GCMidasTouchFeeInstance._UnPackData:new()

	return GCMidasTouchFeeInstance
end


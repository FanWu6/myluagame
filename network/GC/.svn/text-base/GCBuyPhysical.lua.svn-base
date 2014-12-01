--GCBuyPhysical.lua
--回复购买体力
--指令:PACKET_GC_BuyPhysical	指令编号13039	十六进制:0x32EF
--auto create by roy.z at 
--
 --------------------------------------------------------------

local GCBuyPhysicalInstance = nil 

 --------------------------------------------------------------
function GCBuyPhysicalCreate()
	-- cclog("GCBuyPhysicalCreate")

	GCBuyPhysical= BaseData:new()

	GCBuyPhysical.new = function(self) 
		local o = getmetatable(self).new(self)

		o._UnPackData = BaseData:new()
		o._UnPackData.new = function(self) 

			local o = getmetatable(self).new(self)

			--初始化_GCBuyPhysicalData内数据
			o.cmdid = PACKET_GC_BuyPhysical	--指令编号
			o._result = 0			---回复，购买体力正确与否	类型=short
			o._diamond = 0			---钻石	类型=int
			o._physical = 0			---玩家体力	类型=int


			return o
		end


		GCBuyPhysical.unpack = function(self,__body) 
--------------------------------回复，购买体力正确与否	类型=short	长度 = 0
			local _next1
			_next1,self._UnPackData._result = string.unpack(__body,">H")
--------------------------------钻石	类型=int	长度 = 0
			local _next2
			_next2,self._UnPackData._diamond = string.unpack(__body,">I",_next1)
--------------------------------玩家体力	类型=int	长度 = 0
			local _next3
			_next3,self._UnPackData._physical = string.unpack(__body,">I",_next2)
		end

		return o
	end

	GCBuyPhysicalInstance = GCBuyPhysical:new()
	GCBuyPhysicalInstance._UnPackData = GCBuyPhysicalInstance._UnPackData:new()

	return GCBuyPhysicalInstance
end


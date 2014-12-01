--GCDiamondRecharge.lua
--回复钻石充值
--指令:PACKET_GC_DiamondRecharge	指令编号13041	十六进制:0x32F1
--auto create by roy.z at 
--
 --------------------------------------------------------------

local GCDiamondRechargeInstance = nil 

 --------------------------------------------------------------
function GCDiamondRechargeCreate()
	-- cclog("GCDiamondRechargeCreate")

	GCDiamondRecharge= BaseData:new()

	GCDiamondRecharge.new = function(self) 
		local o = getmetatable(self).new(self)

		o._UnPackData = BaseData:new()
		o._UnPackData.new = function(self) 

			local o = getmetatable(self).new(self)

			--初始化_GCDiamondRechargeData内数据
			o.cmdid = PACKET_GC_DiamondRecharge	--指令编号
			o._result = 0			---回复，钻石充值正确与否	类型=short
			o._diamond = 0			---钻石	类型=int
			o._viplv = 0			---vip等级	类型=short


			return o
		end


		GCDiamondRecharge.unpack = function(self,__body) 
--------------------------------回复，钻石充值正确与否	类型=short	长度 = 0
			local _next1
			_next1,self._UnPackData._result = string.unpack(__body,">H")
--------------------------------钻石	类型=int	长度 = 0
			local _next2
			_next2,self._UnPackData._diamond = string.unpack(__body,">I",_next1)
--------------------------------vip等级	类型=short	长度 = 0
			local _next3
			_next3,self._UnPackData._viplv = string.unpack(__body,">H",_next2)
		end

		return o
	end

	GCDiamondRechargeInstance = GCDiamondRecharge:new()
	GCDiamondRechargeInstance._UnPackData = GCDiamondRechargeInstance._UnPackData:new()

	return GCDiamondRechargeInstance
end


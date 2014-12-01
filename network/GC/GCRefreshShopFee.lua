--GCRefreshShopFee.lua
--回复刷新商店费用
--指令:PACKET_GC_RefreshShopFee	指令编号13025	十六进制:0x32E1
--auto create by roy.z at 
--
 --------------------------------------------------------------

local GCRefreshShopFeeInstance = nil 

 --------------------------------------------------------------
function GCRefreshShopFeeCreate()
	-- cclog("GCRefreshShopFeeCreate")

	GCRefreshShopFee= BaseData:new()

	GCRefreshShopFee.new = function(self) 
		local o = getmetatable(self).new(self)

		o._UnPackData = BaseData:new()
		o._UnPackData.new = function(self) 

			local o = getmetatable(self).new(self)

			--初始化_GCRefreshShopFeeData内数据
			o.cmdid = PACKET_GC_RefreshShopFee	--指令编号
			o._result = 0			---回复，刷新商店费用正确与否	类型=short
			o._payableamt = 0			---刷新商店费用	类型=int
			o._refreshtimes = 0			---刷新次数	类型=int


			return o
		end


		GCRefreshShopFee.unpack = function(self,__body) 
--------------------------------回复，刷新商店费用正确与否	类型=short	长度 = 0
			local _next1
			_next1,self._UnPackData._result = string.unpack(__body,">H")
--------------------------------刷新商店费用	类型=int	长度 = 0
			local _next2
			_next2,self._UnPackData._payableamt = string.unpack(__body,">I",_next1)
--------------------------------刷新次数	类型=int	长度 = 0
			local _next3
			_next3,self._UnPackData._refreshtimes = string.unpack(__body,">I",_next2)
		end

		return o
	end

	GCRefreshShopFeeInstance = GCRefreshShopFee:new()
	GCRefreshShopFeeInstance._UnPackData = GCRefreshShopFeeInstance._UnPackData:new()

	return GCRefreshShopFeeInstance
end


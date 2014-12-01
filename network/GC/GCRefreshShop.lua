--GCRefreshShop.lua
--回复刷新商店
--指令:PACKET_GC_RefreshShop	指令编号13027	十六进制:0x32E3
--auto create by roy.z at 
--
 --------------------------------------------------------------

local GCRefreshShopInstance = nil 

 --------------------------------------------------------------
function GCRefreshShopCreate()
	-- cclog("GCRefreshShopCreate")

	GCRefreshShop= BaseData:new()

	GCRefreshShop.new = function(self) 
		local o = getmetatable(self).new(self)

		o._UnPackData = BaseData:new()
		o._UnPackData.new = function(self) 

			local o = getmetatable(self).new(self)

			--初始化_GCRefreshShopData内数据
			o.cmdid = PACKET_GC_RefreshShop	--指令编号
			o._refreshtimes = 0			---刷新次数	类型=int
			o._pbdatalen = 0			---protobuff数据，二进制数据长度	类型=short
			o._pbdata = ""			---protobuff数据，二进制	类型=binary


			return o
		end


		GCRefreshShop.unpack = function(self,__body) 
--------------------------------刷新次数	类型=int	长度 = 0
			local _next1
			_next1,self._UnPackData._refreshtimes = string.unpack(__body,">I")
--------------------------------protobuff数据，二进制	类型=binary	长度 = 1024
			local _next2,_pbdatalen = string.unpack(__body,">H",_next1)
			local _next3
			_next3,self._UnPackData._pbdata= string.unpack(__body,">A".._pbdatalen,_next2)
		end

		return o
	end

	GCRefreshShopInstance = GCRefreshShop:new()
	GCRefreshShopInstance._UnPackData = GCRefreshShopInstance._UnPackData:new()

	return GCRefreshShopInstance
end


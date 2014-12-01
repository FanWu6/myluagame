--GCShopBuyItem.lua
--回复商城购买结果
--指令:PACKET_GC_ShopBuyItem	指令编号13003	十六进制:0x32CB
--auto create by roy.z at 
--
 --------------------------------------------------------------

local GCShopBuyItemInstance = nil 

 --------------------------------------------------------------
function GCShopBuyItemCreate()
	-- cclog("GCShopBuyItemCreate")

	GCShopBuyItem= BaseData:new()

	GCShopBuyItem.new = function(self) 
		local o = getmetatable(self).new(self)

		o._UnPackData = BaseData:new()
		o._UnPackData.new = function(self) 

			local o = getmetatable(self).new(self)

			--初始化_GCShopBuyItemData内数据
			o.cmdid = PACKET_GC_ShopBuyItem	--指令编号
			o._result = 0			---回复，商城购买是否正确	类型=short


			return o
		end


		GCShopBuyItem.unpack = function(self,__body) 
--------------------------------回复，商城购买是否正确	类型=short	长度 = 0
			local _next1
			_next1,self._UnPackData._result = string.unpack(__body,">H")
		end

		return o
	end

	GCShopBuyItemInstance = GCShopBuyItem:new()
	GCShopBuyItemInstance._UnPackData = GCShopBuyItemInstance._UnPackData:new()

	return GCShopBuyItemInstance
end


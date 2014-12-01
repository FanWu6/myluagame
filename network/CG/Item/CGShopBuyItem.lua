--CGShopBuyItem.lua
--在商城中购买物品
--指令:PACKET_CG_ShopBuyItem	指令编号13002	十六进制:0x32CA
--auto create by roy.z at 
--
 --------------------------------------------------------------


local CGShopBuyItemInstance = nil 


 --------------------------------------------------------------
function CGShopBuyItemCreate()
	-- cclog("CGShopBuyItemCreate")

	CGShopBuyItem= BaseData:new()

	CGShopBuyItem.new = function(self) 
		local o = getmetatable(self).new(self)

		o._PackData = BaseData:new()
		o._PackData.new = function(self) 

			local o = getmetatable(self).new(self)

			--初始化_CGShopBuyItemData内数据
			o.cmdid = PACKET_CG_ShopBuyItem	--指令编号
			o._itemId = 0			---物品编号	类型=int
			o._shoptype = 0			---商店类型 1：商人商店 2：竞技场商店 3：远征商店	类型=short

			o._len = 2 + 2 +  4 + 2

			o._letterCodes = ">HHih"

			o._pack = nil

			return o
		end

		o._PackData.init = function(self,__itemId,__shoptype)

			self._itemId = __itemId			---物品编号	类型=int
			self._shoptype = __shoptype			---商店类型 1：商人商店 2：竞技场商店 3：远征商店	类型=short

			self._len = 2 + 2 +  4 + 2

			self._pack = string.pack(self._letterCodes,self._len,self.cmdid,self._itemId,self._shoptype)

			return o
		end


		o._PackData.getPack = function(self)
			return self._pack
		end

		return o
	end



	CGShopBuyItemInstance = CGShopBuyItem:new()
	CGShopBuyItemInstance._PackData = CGShopBuyItemInstance._PackData:new()

	return CGShopBuyItemInstance
end


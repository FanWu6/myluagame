--CGShopItemList.lua
--商店物品列表
--指令:PACKET_CG_ShopItemList	指令编号13020	十六进制:0x32DC
--auto create by roy.z at 2014-10-28
--
 --------------------------------------------------------------


local CGShopItemListInstance = nil 


 --------------------------------------------------------------
function CGShopItemListCreate()
	-- cclog("CGShopItemListCreate")

	CGShopItemList= BaseData:new()

	CGShopItemList.new = function(self) 
		local o = getmetatable(self).new(self)

		o._PackData = BaseData:new()
		o._PackData.new = function(self) 

			local o = getmetatable(self).new(self)

			--初始化_CGShopItemListData内数据
			o.cmdid = PACKET_CG_ShopItemList	--指令编号
			o._shoptype = 0			---商店类型 1：商人商店 2：竞技场商店 3：远征商店	类型=short

			o._len = 2 + 2 +  2

			o._letterCodes = ">HHh"

			o._pack = nil

			return o
		end

		o._PackData.init = function(self,__shoptype)

			self._shoptype = __shoptype			---商店类型 1：商人商店 2：竞技场商店 3：远征商店	类型=short

			self._len = 2 + 2 +  2

			self._pack = string.pack(self._letterCodes,self._len,self.cmdid,self._shoptype)

			return o
		end


		o._PackData.getPack = function(self)
			return self._pack
		end

		return o
	end



	CGShopItemListInstance = CGShopItemList:new()
	CGShopItemListInstance._PackData = CGShopItemListInstance._PackData:new()

	return CGShopItemListInstance
end


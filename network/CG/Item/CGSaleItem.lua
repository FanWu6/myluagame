--CGSaleItem.lua
--出售物品
--指令:PACKET_CG_SaleItem	指令编号13036	十六进制:0x32EC
--auto create by roy.z at 
--
 --------------------------------------------------------------


local CGSaleItemInstance = nil 


 --------------------------------------------------------------
function CGSaleItemCreate()
	-- cclog("CGSaleItemCreate")

	CGSaleItem= BaseData:new()

	CGSaleItem.new = function(self) 
		local o = getmetatable(self).new(self)

		o._PackData = BaseData:new()
		o._PackData.new = function(self) 

			local o = getmetatable(self).new(self)

			--初始化_CGSaleItemData内数据
			o.cmdid = PACKET_CG_SaleItem	--指令编号
			o._itemId = 0			---物品编号	类型=int
			o._num = 0			---物品数量	类型=short
			o._gold = 0			---金币	类型=int

			o._len = 2 + 2 +  4 + 2 + 4

			o._letterCodes = ">HHihi"

			o._pack = nil

			return o
		end

		o._PackData.init = function(self,__itemId,__num,__gold)

			self._itemId = __itemId			---物品编号	类型=int
			self._num = __num			---物品数量	类型=short
			self._gold = __gold			---金币	类型=int

			self._len = 2 + 2 +  4 + 2 + 4

			self._pack = string.pack(self._letterCodes,self._len,self.cmdid,self._itemId,self._num,self._gold)

			return o
		end


		o._PackData.getPack = function(self)
			return self._pack
		end

		return o
	end



	CGSaleItemInstance = CGSaleItem:new()
	CGSaleItemInstance._PackData = CGSaleItemInstance._PackData:new()

	return CGSaleItemInstance
end


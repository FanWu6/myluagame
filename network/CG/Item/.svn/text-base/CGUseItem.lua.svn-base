--CGUseItem.lua
--物品消耗
--指令:PACKET_CG_UseItem	指令编号13022	十六进制:0x32DE
--auto create by roy.z at 2014-10-23
--
 --------------------------------------------------------------


local CGUseItemInstance = nil 


 --------------------------------------------------------------
function CGUseItemCreate()
	-- cclog("CGUseItemCreate")

	CGUseItem= BaseData:new()

	CGUseItem.new = function(self) 
		local o = getmetatable(self).new(self)

		o._PackData = BaseData:new()
		o._PackData.new = function(self) 

			local o = getmetatable(self).new(self)

			--初始化_CGUseItemData内数据
			o.cmdid = PACKET_CG_UseItem	--指令编号
			o._itemId = 0			---物品编号	类型=int
			o._num = 0			---物品数量	类型=int

			o._len = 2 + 2 +  4 + 4

			o._letterCodes = ">HHii"

			o._pack = nil

			return o
		end

		o._PackData.init = function(self,__itemId,__num)

			self._itemId = __itemId			---物品编号	类型=int
			self._num = __num			---物品数量	类型=int

			self._len = 2 + 2 +  4 + 4
			
            print("参数11=="..self._letterCodes)
            print("参数22=="..self._len)
            print("参数33=="..self.cmdid)
            print("参数44=="..self._itemId)
            print("参数55=="..self._num)

			self._pack = string.pack(self._letterCodes,self._len,self.cmdid,self._itemId,self._num)

			return o
		end


		o._PackData.getPack = function(self)
			return self._pack
		end

		return o
	end



	CGUseItemInstance = CGUseItem:new()
	CGUseItemInstance._PackData = CGUseItemInstance._PackData:new()

	return CGUseItemInstance
end


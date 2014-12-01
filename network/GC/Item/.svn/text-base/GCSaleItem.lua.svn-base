--GCSaleItem.lua
--回复出售物品
--指令:PACKET_GC_SaleItem	指令编号13037	十六进制:0x32ED
--auto create by roy.z at 
--
 --------------------------------------------------------------

local GCSaleItemInstance = nil 

 --------------------------------------------------------------
function GCSaleItemCreate()
	-- cclog("GCSaleItemCreate")

	GCSaleItem= BaseData:new()

	GCSaleItem.new = function(self) 
		local o = getmetatable(self).new(self)

		o._UnPackData = BaseData:new()
		o._UnPackData.new = function(self) 

			local o = getmetatable(self).new(self)

			--初始化_GCSaleItemData内数据
			o.cmdid = PACKET_GC_SaleItem	--指令编号
			o._result = 0			---回复，出售物品正确与否	类型=short
			o._itemId = 0			---物品编号	类型=int
			o._num = 0			---物品数量	类型=short
			o._gold = 0			---金币	类型=int


			return o
		end


		GCSaleItem.unpack = function(self,__body) 
--------------------------------回复，出售物品正确与否	类型=short	长度 = 0
			local _next1
			_next1,self._UnPackData._result = string.unpack(__body,">H")
--------------------------------物品编号	类型=int	长度 = 0
			local _next2
			_next2,self._UnPackData._itemId = string.unpack(__body,">I",_next1)
--------------------------------物品数量	类型=short	长度 = 0
			local _next3
			_next3,self._UnPackData._num = string.unpack(__body,">H",_next2)
--------------------------------金币	类型=int	长度 = 0
			local _next4
			_next4,self._UnPackData._gold = string.unpack(__body,">I",_next3)
		end

		return o
	end

	GCSaleItemInstance = GCSaleItem:new()
	GCSaleItemInstance._UnPackData = GCSaleItemInstance._UnPackData:new()

	return GCSaleItemInstance
end


--GCUseItem.lua
--回复物品消耗
--指令:PACKET_GC_UseItem	指令编号13023	十六进制:0x32DF
--auto create by roy.z at 2014-10-23
--
 --------------------------------------------------------------

local GCUseItemInstance = nil 

 --------------------------------------------------------------
function GCUseItemCreate()
	-- cclog("GCUseItemCreate")

	GCUseItem= BaseData:new()

	GCUseItem.new = function(self) 
		local o = getmetatable(self).new(self)

		o._UnPackData = BaseData:new()
		o._UnPackData.new = function(self) 

			local o = getmetatable(self).new(self)

			--初始化_GCUseItemData内数据
			o.cmdid = PACKET_GC_UseItem	--指令编号
			o._result = 0			---回复，物品消耗正确与否	类型=short


			return o
		end


		GCUseItem.unpack = function(self,__body) 
--------------------------------回复，物品消耗正确与否	类型=short	长度 = 0
			local _next1
			_next1,self._UnPackData._result = string.unpack(__body,">H")
		end

		return o
	end

	GCUseItemInstance = GCUseItem:new()
	GCUseItemInstance._UnPackData = GCUseItemInstance._UnPackData:new()

	return GCUseItemInstance
end


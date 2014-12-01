--GCBagList.lua
--回复背包列表
--指令:PACKET_GC_BagList	指令编号13013	十六进制:0x32D5
--auto create by roy.z at 2014-10-16
--
 --------------------------------------------------------------

local GCBagListInstance = nil 

 --------------------------------------------------------------
function GCBagListCreate()
	-- cclog("GCBagListCreate")

	GCBagList= BaseData:new()

	GCBagList.new = function(self) 
		local o = getmetatable(self).new(self)

		o._UnPackData = BaseData:new()
		o._UnPackData.new = function(self) 

			local o = getmetatable(self).new(self)

			--初始化_GCBagListData内数据
			o.cmdid = PACKET_GC_BagList	--指令编号
			o._pbdatalen = 0			---protobuff数据，二进制数据长度	类型=short
			o._pbdata = ""			---protobuff数据，二进制	类型=binary


			return o
		end


		GCBagList.unpack = function(self,__body) 
--------------------------------protobuff数据，二进制	类型=binary	长度 = 1024
			local _next1,_pbdatalen = string.unpack(__body,">H")
			local _next2
			_next2,self._UnPackData._pbdata= string.unpack(__body,">A".._pbdatalen,_next1)
		end

		return o
	end

	GCBagListInstance = GCBagList:new()
	GCBagListInstance._UnPackData = GCBagListInstance._UnPackData:new()

	return GCBagListInstance
end


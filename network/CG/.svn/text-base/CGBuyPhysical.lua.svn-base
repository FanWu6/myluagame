--CGBuyPhysical.lua
--购买体力
--指令:PACKET_CG_BuyPhysical	指令编号13038	十六进制:0x32EE
--auto create by roy.z at 
--
 --------------------------------------------------------------


local CGBuyPhysicalInstance = nil 


 --------------------------------------------------------------
function CGBuyPhysicalCreate()
	-- cclog("CGBuyPhysicalCreate")

	CGBuyPhysical= BaseData:new()

	CGBuyPhysical.new = function(self) 
		local o = getmetatable(self).new(self)

		o._PackData = BaseData:new()
		o._PackData.new = function(self) 

			local o = getmetatable(self).new(self)

			--初始化_CGBuyPhysicalData内数据
			o.cmdid = PACKET_CG_BuyPhysical	--指令编号
			o._diamond = 0			---钻石	类型=int

			o._len = 2 + 2 +  4

			o._letterCodes = ">HHi"

			o._pack = nil

			return o
		end

		o._PackData.init = function(self,__diamond)

			self._diamond = __diamond			---钻石	类型=int

			self._len = 2 + 2 +  4

			self._pack = string.pack(self._letterCodes,self._len,self.cmdid,self._diamond)

			return o
		end


		o._PackData.getPack = function(self)
			return self._pack
		end

		return o
	end



	CGBuyPhysicalInstance = CGBuyPhysical:new()
	CGBuyPhysicalInstance._PackData = CGBuyPhysicalInstance._PackData:new()

	return CGBuyPhysicalInstance
end


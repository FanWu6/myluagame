--CGBuyPhysicalFee.lua
--购买体力费用
--指令:PACKET_CG_BuyPhysicalFee	指令编号13042	十六进制:0x32F2
--auto create by roy.z at 
--
 --------------------------------------------------------------


local CGBuyPhysicalFeeInstance = nil 


 --------------------------------------------------------------
function CGBuyPhysicalFeeCreate()
	-- cclog("CGBuyPhysicalFeeCreate")

	CGBuyPhysicalFee= BaseData:new()

	CGBuyPhysicalFee.new = function(self) 
		local o = getmetatable(self).new(self)

		o._PackData = BaseData:new()
		o._PackData.new = function(self) 

			local o = getmetatable(self).new(self)

			--初始化_CGBuyPhysicalFeeData内数据
			o.cmdid = PACKET_CG_BuyPhysicalFee	--指令编号

			o._len = 2 + 2 

			o._letterCodes = ">HH"

			o._pack = nil

			return o
		end

		o._PackData.init = function(self)


			self._len = 2 + 2 

			self._pack = string.pack(self._letterCodes,self._len,self.cmdid)

			return o
		end


		o._PackData.getPack = function(self)
			return self._pack
		end

		return o
	end



	CGBuyPhysicalFeeInstance = CGBuyPhysicalFee:new()
	CGBuyPhysicalFeeInstance._PackData = CGBuyPhysicalFeeInstance._PackData:new()

	return CGBuyPhysicalFeeInstance
end


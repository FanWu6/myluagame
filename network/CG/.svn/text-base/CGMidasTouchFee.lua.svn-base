--CGMidasTouchFee.lua
--点金手费用
--指令:PACKET_CG_MidasTouchFee	指令编号13032	十六进制:0x32E8
--auto create by roy.z at 
--
 --------------------------------------------------------------


local CGMidasTouchFeeInstance = nil 


 --------------------------------------------------------------
function CGMidasTouchFeeCreate()
	-- cclog("CGMidasTouchFeeCreate")

	CGMidasTouchFee= BaseData:new()

	CGMidasTouchFee.new = function(self) 
		local o = getmetatable(self).new(self)

		o._PackData = BaseData:new()
		o._PackData.new = function(self) 

			local o = getmetatable(self).new(self)

			--初始化_CGMidasTouchFeeData内数据
			o.cmdid = PACKET_CG_MidasTouchFee	--指令编号

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



	CGMidasTouchFeeInstance = CGMidasTouchFee:new()
	CGMidasTouchFeeInstance._PackData = CGMidasTouchFeeInstance._PackData:new()

	return CGMidasTouchFeeInstance
end


--CGMidasTouchUse.lua
--使用点金手
--指令:PACKET_CG_MidasTouchUse	指令编号13034	十六进制:0x32EA
--auto create by roy.z at 
--
 --------------------------------------------------------------


local CGMidasTouchUseInstance = nil 


 --------------------------------------------------------------
function CGMidasTouchUseCreate()
	-- cclog("CGMidasTouchUseCreate")

	CGMidasTouchUse= BaseData:new()

	CGMidasTouchUse.new = function(self) 
		local o = getmetatable(self).new(self)

		o._PackData = BaseData:new()
		o._PackData.new = function(self) 

			local o = getmetatable(self).new(self)

			--初始化_CGMidasTouchUseData内数据
			o.cmdid = PACKET_CG_MidasTouchUse	--指令编号
			o._times = 0			---点击次数	类型=int

			o._len = 2 + 2 +  4

			o._letterCodes = ">HHi"

			o._pack = nil

			return o
		end

		o._PackData.init = function(self,__times)

			self._times = __times			---点击次数	类型=int

			self._len = 2 + 2 +  4

			self._pack = string.pack(self._letterCodes,self._len,self.cmdid,self._times)

			return o
		end


		o._PackData.getPack = function(self)
			return self._pack
		end

		return o
	end



	CGMidasTouchUseInstance = CGMidasTouchUse:new()
	CGMidasTouchUseInstance._PackData = CGMidasTouchUseInstance._PackData:new()

	return CGMidasTouchUseInstance
end


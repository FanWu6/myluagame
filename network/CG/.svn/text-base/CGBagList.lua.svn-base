--CGBagList.lua
--背包列表
--指令:PACKET_CG_BagList	指令编号13012	十六进制:0x32D4
--auto create by roy.z at 2014-10-16
--
 --------------------------------------------------------------


local CGBagListInstance = nil 


 --------------------------------------------------------------
function CGBagListCreate()
	-- cclog("CGBagListCreate")

	CGBagList= BaseData:new()

	CGBagList.new = function(self) 
		local o = getmetatable(self).new(self)

		o._PackData = BaseData:new()
		o._PackData.new = function(self) 

			local o = getmetatable(self).new(self)

			--初始化_CGBagListData内数据
			o.cmdid = PACKET_CG_BagList	--指令编号

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



	CGBagListInstance = CGBagList:new()
	CGBagListInstance._PackData = CGBagListInstance._PackData:new()

	return CGBagListInstance
end


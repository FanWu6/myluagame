--CGPlayerInfo.lua
--查询玩家信息
--指令:PACKET_CG_PlayerInfo	指令编号12004	十六进制:0x2EE4
--auto create by roy.z at 
--
 --------------------------------------------------------------


local CGPlayerInfoInstance = nil 


 --------------------------------------------------------------
function CGPlayerInfoCreate()
	-- cclog("CGPlayerInfoCreate")

	CGPlayerInfo= BaseData:new()

	CGPlayerInfo.new = function(self) 
		local o = getmetatable(self).new(self)

		o._PackData = BaseData:new()
		o._PackData.new = function(self) 

			local o = getmetatable(self).new(self)

			--初始化_CGPlayerInfoData内数据
			o.cmdid = PACKET_CG_PlayerInfo	--指令编号

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



	CGPlayerInfoInstance = CGPlayerInfo:new()
	CGPlayerInfoInstance._PackData = CGPlayerInfoInstance._PackData:new()

	return CGPlayerInfoInstance
end


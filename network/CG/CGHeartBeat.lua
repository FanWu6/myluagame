--CGHeartBeat.lua
--心跳包
--指令:PACKET_CG_HeartBeat	指令编号10004	十六进制:0x2714
--auto create by roy.z at 2014-09-05
--
 --------------------------------------------------------------


local CGHeartBeatInstance = nil 


 --------------------------------------------------------------
function CGHeartBeatCreate()
	-- cclog("CGHeartBeatCreate")

	CGHeartBeat= BaseData:new()

	CGHeartBeat.new = function(self) 
		local o = getmetatable(self).new(self)

		o._PackData = BaseData:new()
		o._PackData.new = function(self) 

			local o = getmetatable(self).new(self)

			--初始化_CGHeartBeatData内数据
			o.cmdid = PACKET_CG_HeartBeat	--指令编号

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



	CGHeartBeatInstance = CGHeartBeat:new()
	CGHeartBeatInstance._PackData = CGHeartBeatInstance._PackData:new()

	return CGHeartBeatInstance
end


--GCHeartBeat.lua
--心跳包
--指令:PACKET_GC_HeartBeat	指令编号10005	十六进制:0x2715
--auto create by roy.z at 2014-09-05
--
 --------------------------------------------------------------

local GCHeartBeatInstance = nil 

 --------------------------------------------------------------
function GCHeartBeatCreate()
	-- cclog("GCHeartBeatCreate")

	GCHeartBeat= BaseData:new()

	GCHeartBeat.new = function(self) 
		local o = getmetatable(self).new(self)

		o._UnPackData = BaseData:new()
		o._UnPackData.new = function(self) 

			local o = getmetatable(self).new(self)

			--初始化_GCHeartBeatData内数据
			o.cmdid = PACKET_GC_HeartBeat	--指令编号


			return o
		end


		GCHeartBeat.unpack = function(self,__body) 
		end

		return o
	end

	GCHeartBeatInstance = GCHeartBeat:new()
	GCHeartBeatInstance._UnPackData = GCHeartBeatInstance._UnPackData:new()

	return GCHeartBeatInstance
end


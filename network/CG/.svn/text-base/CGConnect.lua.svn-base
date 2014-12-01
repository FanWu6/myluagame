--CGConnect.lua
--登陆服务器
--指令:PACKET_CG_Connect	指令编号10000	十六进制:0x2710
--auto create by roy.z at 2014-09-05
--
 --------------------------------------------------------------


local CGConnectInstance = nil 


 --------------------------------------------------------------
function CGConnectCreate()
	-- cclog("CGConnectCreate")

	CGConnect= BaseData:new()

	CGConnect.new = function(self) 
		local o = getmetatable(self).new(self)

		o._PackData = BaseData:new()
		o._PackData.new = function(self) 

			local o = getmetatable(self).new(self)

			--初始化_CGConnectData内数据
			o.cmdid = PACKET_CG_Connect	--指令编号
			o._accid = 0			---平台账号	类型=int
			o._tstemp = 0			---数字时间戳，用于MD5校验	类型=int
			o._accnamelen = 0			---平台账号名称数据长度	类型=short
			o._accname = ""			---平台账号名称	类型=string
			o._ticketlen = 0			---Accid + accname + tstemp + 校验码SDFSDESF123DFSDF做md5数据长度	类型=short
			o._ticket = ""			---Accid + accname + tstemp + 校验码SDFSDESF123DFSDF做md5	类型=string

			o._len = 2 + 2 +  4 + 4 + 2 + string.len(o._accname)   + 2 + string.len(o._ticket)

			o._letterCodes = ">HHiiHAHA"

			o._pack = nil

			return o
		end

		o._PackData.init = function(self,__accid,__tstemp,__accname,__ticket)

			self._accid = __accid			---平台账号	类型=int
			self._tstemp = __tstemp			---数字时间戳，用于MD5校验	类型=int
			self._accname = __accname			---平台账号名称	类型=string
			self._ticket = __ticket			---Accid + accname + tstemp + 校验码SDFSDESF123DFSDF做md5	类型=string

			self._len = 2 + 2 +  4 + 4 + 2 + string.len(self._accname)   + 2 + string.len(self._ticket)

			self._pack = string.pack(self._letterCodes,self._len,self.cmdid,self._accid,self._tstemp,string.len(self._accname) , self._accname,string.len(self._ticket) , self._ticket)

			return o
		end


		o._PackData.getPack = function(self)
			return self._pack
		end

		return o
	end



	CGConnectInstance = CGConnect:new()
	CGConnectInstance._PackData = CGConnectInstance._PackData:new()

	return CGConnectInstance
end


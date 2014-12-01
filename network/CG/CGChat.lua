--CGChat.lua
--世界聊天
--指令:PACKET_CG_Chat	指令编号11000	十六进制:0x2AF8
--auto create by roy.z at 2014-09-05
--
 --------------------------------------------------------------


local CGChatInstance = nil 


 --------------------------------------------------------------
function CGChatCreate()
	-- cclog("CGChatCreate")

	CGChat= BaseData:new()

	CGChat.new = function(self) 
		local o = getmetatable(self).new(self)

		o._PackData = BaseData:new()
		o._PackData.new = function(self) 

			local o = getmetatable(self).new(self)

			--初始化_CGChatData内数据
			o.cmdid = PACKET_CG_Chat	--指令编号
			o._color = 0			---字体颜色	类型=byte
			o._cntlen = 0			---聊天内容数据长度	类型=short
			o._cnt = ""			---聊天内容	类型=string

			o._len = 2 + 2 +  1 + 2 + string.len(o._cnt)

			o._letterCodes = ">HHbHA"

			o._pack = nil

			return o
		end

		o._PackData.init = function(self,__color,__cnt)

			self._color = __color			---字体颜色	类型=byte
			self._cnt = __cnt			---聊天内容	类型=string

			self._len = 2 + 2 +  1 + 2 + string.len(self._cnt)

			self._pack = string.pack(self._letterCodes,self._len,self.cmdid,self._color,string.len(self._cnt) , self._cnt)

			return o
		end


		o._PackData.getPack = function(self)
			return self._pack
		end

		return o
	end



	CGChatInstance = CGChat:new()
	CGChatInstance._PackData = CGChatInstance._PackData:new()

	return CGChatInstance
end


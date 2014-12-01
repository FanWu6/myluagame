
-- Base = {}
-- Base.new = function(self) 
-- 	local o = {};   --创建新表 
-- 	setmetatable(o,self) --新表的元表设置为原型表 
-- 	self.__index = self--原型表的__index为原型表 
-- 	return o
-- end 
-- Base.setXY = function (self,x,y)

-- 	self.x = x
-- 	self.y = y
-- end
-- Base.setData = function (self,Seves_Data) 

-- 	self.Mail_Title = Seves_Data.Mail_Title
-- 	self.Sand_Name = Seves_Data.Sand_Name
-- 	self.Sand_Date = Seves_Data.Sand_Date
-- 	self.IsOpen = Seves_Data.IsOpen

-- end


local MailInstance = nil 


function MailCreate()

	Mail = Base_Data:new()

	Mail.new = function(self) 
		local o = getmetatable(self).new(self)

		o._MailEnvelope = Base_Data:new()
 		o._MailEnvelope.new = function(self) 

 			local o = getmetatable(self).new(self)

 			o.Mail_Title = 1 --标题
 			o.Sand_Name = 2 --发送人
 			o.Sand_Date = 3 --发送日期
 			o.IsOpen = 4 --时候开启

 			return o

 		end


 		o._MailContent = Base_Data:new()

		o._MailContent.new = function(self) 

 			local o = getmetatable(self).new(self)
 			o.Sth_NO = 5 --含有多少种附件
 			o.Mail_Info = 6 --信件文字
 			--o.Sth_Res = 0 --附件资源


 			o.Sth_Res = Base_Data:new()

			o.Sth_Res.new = function(self) 

 				local o = getmetatable(self).new(self)

 				o.Sth_ID = 7 --物品ID
 				o.Sth_Name = 8 -- 物品名字
 				o.Res = 9 --物品图片资源
 				o.Sth_Describe = 10 --物品描述
 				o.Sth_HaveNum = 11 --含有多少此类物品

 				return o
 			end

 			return o
		end

		return o
	end 


	Mail.init_MailEnvelope = function(self,data) 

		if "table"==type(data) then

			for name, value in pairsByKeys(data) do
	   			self._MailEnvelope[""..name] = value
			end

		else

			cclog("type error in initData")
		end

	end 

	Mail.init_MailContent = function(self,data) 

		if "table"==type(data) then

			for name, value in pairsByKeys(data) do
	   			self._MailContent[""..name] = value

			end

		else

			cclog("type error in initData")
		end

	end 





	MailInstance = Mail:new()
	MailInstance._MailEnvelope = MailInstance._MailEnvelope:new()
	MailInstance._MailContent = MailInstance._MailContent:new()
	MailInstance._MailContent.Sth_Res = MailInstance._MailContent.Sth_Res:new()


	return MailInstance

end

























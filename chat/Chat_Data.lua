
require "src/chat/Base_Class"





local Chat_W_Instance = nil 
local Chat_P_Instance = nil 


function Chat_Word_Create()

	local Chat = Base_Data:new()

	Chat.new = function(self) 
		local o = getmetatable(self).new(self)

		o.Play_Id = 1
		o.Player_Name = 1
		o.Player_LV = 1
		o.Player_Portrait = 1
		o.Player_Sand = 1
		o.Player_SandTime = 1
		o.Vip = 1

		return o
	end


	Chat.init_Data = function(self,data) 

		if "table"==type(data) then

			for name, value in pairsByKeys(data) do
	   			self[""..name] = value

			end

		else

			cclog("type error in initData")
		end

	end 

	Chat_W_Instance = Chat:new()

	return Chat_W_Instance

end

					
function Chat_Private_Create()

	local Chat = Base_Data:new()

	Chat.new = function(self) 
		local o = getmetatable(self).new(self)

		o.Play_Id = 1
		o.Player_Name = 1
		o.Player_LV = 1
		o.Player_Portrait = 1
		o.Player_Sand = 1
		o.Player_SandTime = 1
		o.Vip = 1
		o.IsSand = 1

		return o
	end


	Chat.init_Data = function(self,data) 

		if "table"==type(data) then

			for name, value in pairsByKeys(data) do
	   			self[""..name] = value

			end

		else

			cclog("type error in initData")
		end

	end 

	Chat_P_Instance = Chat:new()

	return Chat_P_Instance

end























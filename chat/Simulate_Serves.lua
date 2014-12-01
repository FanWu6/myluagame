require "src/chat/Chat_Data"


local From_Serve_Data_WD = {{Play_Id = 1007,Player_Name = "梅代夫斯基1",Player_LV = "71",Player_Portrait = "res/chat/CW.jpg",Player_Sand = "聊天内容1end聊天内容1end聊天内容1end聊天内容1end聊天内容1end聊天内容1end聊天内容",Player_SandTime = "15:31",Vip = 1},
						{Play_Id = 1008,Player_Name = "梅代夫斯基2",Player_LV = "72",Player_Portrait = "res/chat/CW.jpg",Player_Sand = "聊天内容2end聊天内容2end聊天内容2end聊天内容2end聊天内容2end聊天内容2end聊天内容2end聊天内容2end聊天内容2end聊天内容2end聊天内容2end聊天内容2end",Player_SandTime = "15:32",Vip = 2},
						{Play_Id = 1009,Player_Name = "梅代夫斯基3",Player_LV = "73",Player_Portrait = "res/chat/CW.jpg",Player_Sand = "聊天内容3end",Player_SandTime = "15:33",Vip = 1},
						{Play_Id = 1010,Player_Name = "梅代夫斯基4",Player_LV = "74",Player_Portrait = "res/chat/CW.jpg",Player_Sand = "聊天内容4end",Player_SandTime = "15:34",Vip = 2},
						{Play_Id = 1011,Player_Name = "梅代夫斯基5",Player_LV = "75",Player_Portrait = "res/chat/CW.jpg",Player_Sand = "聊天内容5end",Player_SandTime = "15:35",Vip = 1}}

local NowSystemTime = "18:18"

local From_Serve_Data_PVE = {{Play_Id = 1007,Player_Name = "梅代夫斯基1",Player_LV = "71",Player_Portrait = "res/chat/CW.jpg",Player_Sand = "聊天内容1end",Player_SandTime = "15:31",Vip = 1,IsSand = false},
						{Play_Id = 1008,Player_Name = "梅代夫斯基2",Player_LV = "72",Player_Portrait = "res/chat/CW.jpg",Player_Sand = "聊天内容2end",Player_SandTime = "15:32",Vip = 2,IsSand = false},
						{Play_Id = 1009,Player_Name = "梅代夫斯基3",Player_LV = "73",Player_Portrait = "res/chat/CW.jpg",Player_Sand = "聊天内容3end",Player_SandTime = "15:33",Vip = 1,IsSand = true},
						{Play_Id = 1010,Player_Name = "梅代夫斯基4",Player_LV = "74",Player_Portrait = "res/chat/CW.jpg",Player_Sand = "聊天内容4end",Player_SandTime = "15:34",Vip = 2,IsSand = false},
						{Play_Id = 1011,Player_Name = "梅代夫斯基5",Player_LV = "75",Player_Portrait = "res/chat/CW.jpg",Player_Sand = "聊天内容5end",Player_SandTime = "15:35",Vip = 1,IsSand = true}}

local Serves = {{ID = 1001,VipType = 1,PlayName = "PlayName1",PlayLevel = "99",Player_Portrait = "res/chat/CW.jpg"},{ID = 1002,VipType = 2,PlayName = "PlayName1",PlayLevel = "99",Player_Portrait = "res/chat/CW.jpg"},
				{ID = 1003,VipType = 1,PlayName = "PlayName1",PlayLevel = "99",Player_Portrait = "res/chat/CW.jpg"},{ID = 1004,VipType = 1,PlayName = "PlayName1",PlayLevel = "99",Player_Portrait = "res/chat/CW.jpg"},
				{ID = 1005,VipType = 2,PlayName = "PlayName1",PlayLevel = "99",Player_Portrait = "res/chat/CW.jpg"},{ID = 1006,VipType = 1,PlayName = "PlayName1",PlayLevel = "99",Player_Portrait = "res/chat/CW.jpg"},
				{ID = 1007,VipType = 1,PlayName = "梅代夫斯基1",PlayLevel = "71",Player_Portrait = "res/chat/CW.jpg"},{ID = 1008,VipType = 2,PlayName = "梅代夫斯基2",PlayLevel = "72",Player_Portrait = "res/chat/CW.jpg"},
				{ID = 1009,VipType = 1,PlayName = "梅代夫斯基3",PlayLevel = "73",Player_Portrait = "res/chat/CW.jpg"},{ID = 1010,VipType = 2,PlayName = "梅代夫斯基4",PlayLevel = "74",Player_Portrait = "res/chat/CW.jpg"},
				{ID = 1011,VipType = 1,PlayName = "梅代夫斯基5",PlayLevel = "75",Player_Portrait = "res/chat/CW.jpg"}}


local BalckList = {1001,1003,1004,1005,1011}


function ServesDataForPlayer(Player_ID)
	
	local PlayerData = {}

		for i=1,table.getn(Serves) do
			if Player_ID == Serves[i].ID then 

				PlayerData.VipType = Serves[i].VipType
	 			PlayerData.PlayName = Serves[i].PlayName
	 			PlayerData.PlayLevel = Serves[i].PlayLevel
	 			PlayerData.Player_Portrait = Serves[i].Player_Portrait
	 			PlayerData.IsBlack = IsBlack
	 			PlayerData.Play_Id = Serves[i].ID

				break
			end 
		end

	return PlayerData
end





function ReturnNowPlayerID()


	return 1006
	
end

function ServesDataForWord()


	local ChatData = {}

	for i=1,table.getn(From_Serve_Data_WD) do
       local o = Chat_Word_Create()
       o:init_Data(From_Serve_Data_WD[i])
       table.insert(ChatData, o)
    end
	
	-- for i=1,table.getn(ChatData) do
 --        print(ChatData[i].Play_Id)
 --        print(ChatData[i].Player_Name)
 --        print(ChatData[i].Player_LV)
 --        print(ChatData[i].Player_Portrait)
 --        print(ChatData[i].Player_Sand)
 --        print(ChatData[i].Player_SandTime)
 --        print(ChatData[i].Vip)
 --    end
	return ChatData

end


function ServesDataForPVE()


	local ChatData = {}

	for i=1,table.getn(From_Serve_Data_PVE) do
       local o = Chat_Private_Create()
       o:init_Data(From_Serve_Data_PVE[i])

       table.insert(ChatData, o)
    end

    -- for i=1,table.getn(ChatData) do
        -- print(ChatData[i].Play_Id)
        -- print(ChatData[i].Player_Name)
        -- print(ChatData[i].Player_LV)
        -- print(ChatData[i].Player_Portrait)
        -- print(ChatData[i].Player_Sand)
        -- print(ChatData[i].Player_SandTime)
        -- print(ChatData[i].Vip)
        -- print(ChatData[i].IsSand)


    -- end


	return ChatData

end



function AddServesDataForWord(Palyer_ID,Sand_Str)
	
	local ReturnTable = {}
	local IsBlack  = false 
	cclog("Now_Player_ID3========="..Palyer_ID)
	for i=1,table.getn(BalckList) do
		if Palyer_ID == BalckList[i] then 
			IsBlack = true 
			break
		end
	end

	if IsBlack == false then 
		for i=1,table.getn(Serves) do
			if Palyer_ID == Serves[i].ID then 
				ReturnTable.Vip = Serves[i].VipType
				ReturnTable.Player_Sand = Sand_Str
				ReturnTable.Player_SandTime = NowSystemTime
	 			ReturnTable.Player_Name = Serves[i].PlayName
	 			ReturnTable.Player_LV = Serves[i].PlayLevel
	 			ReturnTable.Player_Portrait = Serves[i].Player_Portrait
	 			-- ReturnTable.IsBlack = IsBlack
	 			ReturnTable.Play_Id = Serves[i].ID
				cclog("==========")

				-- local NowMsgNun = table.getn(From_Serve_Data_WD)
	   --  		From_Serve_Data_WD[NowMsgNun+1] = {Play_Id = Serves[i].ID,Player_Name = Serves[i].PlayName,Player_LV = Serves[i].PlayLevel,Player_Portrait = Serves[i].Player_Portrait,Player_Sand = Sand_Str,Player_SandTime = NowSystemTime,Vip = Serves[i].VipType}
				
		       	local o = Chat_Word_Create()
		       	o:init_Data(ReturnTable)

		       	return o

			end 
		end

		elseif IsBlack == true then 

			return nil

	end

	return nil

end

function AddServesDataForPrivate(Palyer_ID,Sand_Str,IsSend)
		
	local ReturnTable = {}

	local IsBlack  = false 	
	cclog("Now_Player_ID4========="..Palyer_ID)
	for i=1,table.getn(BalckList) do
		if Palyer_ID == BalckList[i] then 
			IsBlack = true 
			break
		end
	end
	if IsBlack == false then 
		for i=1,table.getn(Serves) do
			if Palyer_ID == Serves[i].ID then 
				ReturnTable.Vip = Serves[i].VipType
				ReturnTable.Player_Sand = Sand_Str
				ReturnTable.Player_SandTime = NowSystemTime
	 			ReturnTable.Player_Name = Serves[i].PlayName
	 			ReturnTable.Player_LV = Serves[i].PlayLevel
	 			ReturnTable.IsSand = IsSend
	 			ReturnTable.Player_Portrait = Serves[i].Player_Portrait
	 			-- ReturnTable.IsBlack = IsBlack
	 			ReturnTable.Play_Id = Serves[i].ID

				cclog("==========")

		       	local o = Chat_Private_Create()
		       	o:init_Data(ReturnTable)


				return o 

				-- local NowMsgNun = table.getn(From_Serve_Data_PVE)
	   --  		From_Serve_Data_PVE[NowMsgNun+1] = {Play_Id = Serves[i].ID,Player_Name = Serves[i].PlayName,Player_LV = Serves[i].PlayLevel,Player_Portrait = Serves[i].Player_Portrait,Player_Sand = Sand_Str,Player_SandTime = NowSystemTime,Vip = Serves[i].VipType,IsSand = IsSend}
			end 
		end
		elseif IsBlack == true then 

			ReturnTable.IsBlack = IsBlack
			
	end 

	return ReturnTable


end

function AddBlackListById(Black_ID)
	
	local BlackList_Index = table.getn(BalckList)

	if BlackList_Index<20 then 

		for i=1,BlackList_Index do
			if BalckList[i] == Black_ID then
				cclog("黑名单已经存在")
				break
			elseif BalckList[i] ~= Black_ID then 
				BalckList[BlackList_Index+1] = Black_ID
			end
		end
	end 

	-- cclog("AddBlackList========="..table.getn(BalckList))
end

function RemoveBlackListById(Black_ID)
	
	local BlackList_Index = table.getn(BalckList)

	for i=1,BlackList_Index do
		if BalckList[i] == Black_ID then
			table.remove(BalckList, i)
			break
		elseif BalckList[i] ~= Black_ID then 
			cclog("黑名单不存在")
		end
	end

	-- for i=1,table.getn(BalckList) do
	-- 	cclog("black====="..BalckList[i])
	-- end

	
end














require "src/chat/Simulate_Serves"
require "src/chat/ToolsHelper"

local Movescheduler
local MoveschedulerEntry



local Channel1
local Channel2

local listView
local OpenChat -- 聊天框开关
local ChatBG_Panel	 
local PageView
local ChatIsOpen --聊天框是否处于打开状态
local OpenChannel --当前打开的聊天频道
local Chat_bg
local ChatEdit

local Sand_Num  -- 免费发送条数文字显示
local SNum = 10-- 免费发送条数
local WhichChannel --记录当前打开的频道
local Sand_Private_Name_Pos --私聊对象名字显示位置
local Sand_Private_Name_Test = "" --私聊对象名字
local Menu_Panel -- 黑名单菜单层
local Menu_BG -- 黑名单菜单
local Now_Player_ID -- 当前登录玩家ID
local Now_ChoosePlayer_ID -- 当前选择玩家ID

local Menu_PlayerData -- 点击头像后获得的目标玩家信息table
local Deletescheduler
local DeleteschedulerEntry
local NoNameEdit -- 输入框遮罩层
local HaveNoNameEdit = false 

local From_Serve_Data_Word--处理之后服务器传递来的消息  世界
local From_Serve_Data_Private--处理之后服务器传递来的消息  私聊

local Out_Of_Range_For_Text
local Out_Of_Range_For_Text_BG

local ChatMax = 5 -- 聊天最大显示条数
local CanEnterMaxTextNum = 10 -- 允许输入最大字符

local function OpenMenu(sender,eventType)

            
    if eventType == ccui.TouchEventType.ended then

  	    Now_ChoosePlayer_ID = sender:getTag()
  		cclog("touchend"..sender:getTag())

        if Now_Player_ID ~= sender:getTag() then 
            cclog("显示窗口")

            Menu_Panel:setVisible(true)
            local move_ease_out = cc.EaseBackOut:create(cc.ScaleTo:create(0.35,1))
            Menu_BG:runAction(move_ease_out)

            local Menu_PortraitBG = Menu_BG:getChildByName("Menu_PortraitBG")

            Menu_PlayerData = ServesDataForPlayer(Now_ChoosePlayer_ID)
            cclog("VipType"..Menu_PlayerData.VipType)
            if Menu_PlayerData.VipType == 2 then
                Menu_PortraitBG:loadTextures("res/chat/main_head_frame_gold.png","res/chat/main_head_frame_gold.png","res/chat/main_head_frame_gold.png")
            end


            local Portrait = maskedSpriteWithSprite(Menu_PlayerData.Player_Portrait,"res/chat/avatar_head_bg.pvr.ccz","res/chat/main_head_frame_gold.png")-- 方法以后要改 问吴总要！
            Portrait:setPosition(Menu_PortraitBG:getPosition())
            Portrait:setScale(Menu_PortraitBG:getScale())
            Portrait:setAnchorPoint(Menu_PortraitBG:getAnchorPoint())
            Menu_BG:addChild(Portrait)

            local Menu_Level_BG = Menu_BG:getChildByName("Menu_Level_BG")

            local Play_Name = Menu_Level_BG:getChildByName("Play_Name")

            Play_Name:setString(Menu_PlayerData.PlayName)

            local Play_Level = Menu_Level_BG:getChildByName("Play_Level")

            Play_Level:setString(Menu_PlayerData.PlayLevel)


        end
      
	end  
end 



local function PrivateTouchName( sender,eventType )

    if eventType == ccui.TouchEventType.ended then

        cclog("TouchName"..sender:getString())
        Now_ChoosePlayer_ID = sender:getTag()
        Sand_Private_Name_Test = sender:getString()
        Sand_Private_Name_Pos:setString(Sand_Private_Name_Test)
        Sand_Private_Name_Pos:setVisible(true)

        --如果输入框遮罩存在 则删除
        if HaveNoNameEdit == true then 
            NoNameEdit:removeFromParent()
            HaveNoNameEdit = false
        end 

    end

end
 
local function LoadServerAddLVForWord()

	local model = Chat_bg:getChildByName("Custom_Item")
 	listView:setItemModel(model)

	local ServerNote = table.getn(From_Serve_Data_Word) --服务器消息条数
	for i=1,ServerNote do
        listView:pushBackDefaultItem()--创建Item
	end
	for i=0,ServerNote-1 do--在每个Item内添加内容
    	local item = listView:getItem(i)
        -- item:setSize(cc.size(1000,300))

        -- cclog("倒数"..ServerNote-i)

        local Index = ServerNote-i

    	local PortraitBG = item:getChildByName("PortraitBG")

    	if From_Serve_Data_Word[Index].Vip == 2 then
            PortraitBG:loadTextures("res/chat/main_head_frame_gold.png","res/chat/main_head_frame_gold.png","res/chat/main_head_frame_gold.png")
    	end

        local Portrait = maskedSpriteWithSprite(From_Serve_Data_Word[Index].Player_Portrait,"res/chat/avatar_head_bg.pvr.ccz","res/chat/main_head_frame_gold.png")-- 方法以后要改 问吴总要！
    	Portrait:setPosition(PortraitBG:getPosition())
    	Portrait:setScale(PortraitBG:getScale())
        Portrait:setAnchorPoint(PortraitBG:getAnchorPoint())

    	item:addChild(Portrait)

    	PortraitBG:setTag(From_Serve_Data_Word[Index].Play_Id)
        PortraitBG:addTouchEventListener(OpenMenu)
  		

    	local Time_Label = item:getChildByName("Time_Label")
    	Time_Label:setString(From_Serve_Data_Word[Index].Player_SandTime)


    	local Level_BG = item:getChildByName("Level_BG")
    	local Play_Level = Level_BG:getChildByName("Play_Level")
    	Play_Level:setString(From_Serve_Data_Word[Index].Player_LV)

    	local Play_Name = Level_BG:getChildByName("Play_Name")
    	Play_Name:setString(From_Serve_Data_Word[Index].Player_Name)


        local Chat_Info = item:getChildByName("Chat_Info")
    	Chat_Info:setString(From_Serve_Data_Word[Index].Player_Sand)

        --------------------------根据文字多少调整对话框尺寸------------------
        Chat_Info:setTextAreaSize(cc.size(620, 0))
    	
        if Chat_Info:getVirtualRendererSize().height<Chat_Info:getContentSize().height then

            local x = Chat_Info:getContentSize().height-Chat_Info:getVirtualRendererSize().height
            print("x======="..x)
            print(item:getSize().height)
            item:setSize(cc.size(730,item:getSize().height-x))
            Portrait:setPositionY(Portrait:getPositionY()-x)
            Time_Label:setPositionY(Time_Label:getPositionY()-x)
            Level_BG:setPositionY(Level_BG:getPositionY()-x)
            Chat_Info:setPositionY(Chat_Info:getPositionY()-x)
            PortraitBG:setPositionY(PortraitBG:getPositionY()-x)


        end

    	   


    end

end

local function LoadServerAddLVForPrivate()

    local model = Chat_bg:getChildByName("Custom_Item_PVE")
    listView:setItemModel(model)

    local ServerNote = table.getn(From_Serve_Data_Private) --服务器消息条数

    for i=1,ServerNote do
        listView:pushBackDefaultItem()
    end

    for i=0,ServerNote-1 do--在每个Item内添加内容
        local item = listView:getItem(i)

        local PortraitBG = item:getChildByName("PortraitBG")
        local Level_BG = item:getChildByName("Level_BG")
        local Sand_To = item:getChildByName("Sand_To")
        local Play_Name1 = item:getChildByName("Play_Name1")
        local Chat_Info = item:getChildByName("Chat_Info")
        Chat_Info:setTextAreaSize(cc.size(620, 0))
        local Time_Label = item:getChildByName("Time_Label")

        local Play_Level = Level_BG:getChildByName("Play_Level")
        local Play_Name = Level_BG:getChildByName("Play_Name")
        local Tell_You = Level_BG:getChildByName("Tell_You")
        local Portrait

        local Index = ServerNote-i  

        if From_Serve_Data_Private[Index].IsSand == true then

            Level_BG:removeFromParent()
            PortraitBG:removeFromParent()   

            Play_Name1:setString(From_Serve_Data_Private[Index].Player_Name)
            Play_Name1:setTag(From_Serve_Data_Private[Index].Play_Id)
            Play_Name1:setTouchEnabled(true)
            Play_Name1:addTouchEventListener(PrivateTouchName)

            Chat_Info:setString(From_Serve_Data_Private[Index].Player_Sand)
           
            Time_Label:setString(From_Serve_Data_Private[Index].Player_SandTime)

            
            if Chat_Info:getVirtualRendererSize().height<Chat_Info:getContentSize().height then

                local x = Chat_Info:getContentSize().height-Chat_Info:getVirtualRendererSize().height
                item:setSize(cc.size(730,item:getSize().height-x))
                Play_Name1:setPositionY(Play_Name1:getPositionY()-x)
                Time_Label:setPositionY(Time_Label:getPositionY()-x)
                Chat_Info:setPositionY(Chat_Info:getPositionY()-x)
                Sand_To:setPositionY(Sand_To:getPositionY()-x)


            end

            elseif From_Serve_Data_Private[Index].IsSand == false then

                Sand_To:removeFromParent()
                Play_Name1:removeFromParent()

                Play_Name:setString(From_Serve_Data_Private[Index].Player_Name)
                cclog("Play_Name"..Play_Name:getContentSize().width)
                Tell_You:setPositionX(Play_Name:getPositionX()+Play_Name:getContentSize().width+5)

                Chat_Info:setString(From_Serve_Data_Private[Index].Player_Sand)
                Time_Label:setString(From_Serve_Data_Private[Index].Player_SandTime)
                Play_Level:setString(From_Serve_Data_Private[Index].Player_LV)

                if From_Serve_Data_Private[Index].Vip == 2 then
                PortraitBG:loadTextures("res/chat/main_head_frame_gold.png","res/chat/main_head_frame_gold.png","res/chat/main_head_frame_gold.png")
                end

            Portrait = maskedSpriteWithSprite(From_Serve_Data_Private[Index].Player_Portrait,"res/chat/avatar_head_bg.pvr.ccz","res/chat/main_head_frame_gold.png")-- 方法以后要改 问吴总要！
                Portrait:setPosition(PortraitBG:getPosition())
                Portrait:setScale(PortraitBG:getScale())
                Portrait:setAnchorPoint(PortraitBG:getAnchorPoint())
                item:addChild(Portrait)

                PortraitBG:setTag(From_Serve_Data_Private[Index].Play_Id)
                PortraitBG:addTouchEventListener(OpenMenu)



                 if Chat_Info:getVirtualRendererSize().height<Chat_Info:getContentSize().height then

                    local x = Chat_Info:getContentSize().height-Chat_Info:getVirtualRendererSize().height
                    item:setSize(cc.size(730,item:getSize().height-x))
                    Level_BG:setPositionY(Level_BG:getPositionY()-x)
                    PortraitBG:setPositionY(PortraitBG:getPositionY()-x)
                    Portrait:setPositionY(Portrait:getPositionY()-x)
                    Time_Label:setPositionY(Time_Label:getPositionY()-x)
                    Chat_Info:setPositionY(Chat_Info:getPositionY()-x)

                end

        end




    end 
end 


local function SandMsgToWord(Play_Id,SandMsg)

    local FromServes = AddServesDataForWord(Play_Id,SandMsg)

    if FromServes == nil  then --黑名单内

        cclog("truetruetruetrue")


    elseif FromServes ~= nil then 

        cclog("falsefalsefalsefalsefalse")
        table.insert(From_Serve_Data_Word, FromServes)

        listView:insertDefaultItem(0)   

        local item = listView:getItem(0)

        local PortraitBG = item:getChildByName("PortraitBG") --设置头像

        if FromServes.Vip == 2 then 
            PortraitBG:loadTextures("res/chat/main_head_frame_gold.png","res/chat/main_head_frame_gold.png","res/chat/main_head_frame_gold.png")
        end 

        local Portrait = maskedSpriteWithSprite(FromServes.Player_Portrait,"res/chat/avatar_head_bg.pvr.ccz","res/chat/main_head_frame_gold.png")-- 方法以后要改 问吴总要！
        Portrait:setPosition(PortraitBG:getPosition())
        Portrait:setScale(PortraitBG:getScale())
        item:addChild(Portrait)
        PortraitBG:setTag(FromServes.Play_Id)   
        PortraitBG:addTouchEventListener(OpenMenu)

        local Time_Label = item:getChildByName("Time_Label")
        Time_Label:setString(FromServes.Player_SandTime)

        local Level_BG = item:getChildByName("Level_BG")
        local Play_Name = Level_BG:getChildByName("Play_Name")
        Play_Name:setString(FromServes.Player_Name)

        local Play_Level = Level_BG:getChildByName("Play_Level")
        Play_Level:setString(FromServes.Player_LV)

        local Chat_Info = item:getChildByName("Chat_Info")
        Chat_Info:setString(FromServes.Player_Sand)


        Chat_Info:setTextAreaSize(cc.size(620, 0))
        
        if Chat_Info:getVirtualRendererSize().height<Chat_Info:getContentSize().height then

            local x = Chat_Info:getContentSize().height-Chat_Info:getVirtualRendererSize().height
            item:setSize(cc.size(730,item:getSize().height-x))
            Portrait:setPositionY(Portrait:getPositionY()-x)
            Time_Label:setPositionY(Time_Label:getPositionY()-x)
            Level_BG:setPositionY(Level_BG:getPositionY()-x)
            Chat_Info:setPositionY(Chat_Info:getPositionY()-x)
            PortraitBG:setPositionY(PortraitBG:getPositionY()-x)

        end





        -- listView:removeLastItem()
        local items_count = table.getn(listView:getItems())
        -- cclog("items_count=="..items_count)
        if items_count>ChatMax then -- 检测聊天记录最大条数
            listView:removeLastItem()
            table.remove(From_Serve_Data_Word, 1)
        end 



    end 

end 

local function SandMsgToPrivate(Play_Id,SandMsg,IsSend)

    local FromServes = AddServesDataForPrivate(Play_Id,SandMsg,IsSend)


    if FromServes.IsBlack == true and IsSend == true  then --黑名单内

        cclog("truetruetruetrue")
        ToastTool("发送失败，对方处于您的黑名单中！！！",true,"res/chat/Toast_BG.png",Chat_bg,Chat_bg:getContentSize().width/2,Chat_bg:getContentSize().height/2,2)


    elseif FromServes.IsBlack == nil then 

        table.insert(From_Serve_Data_Private, FromServes)

        local model = Chat_bg:getChildByName("Custom_Item_PVE")
        listView:setItemModel(model)

        listView:insertDefaultItem(0)   
        -- local SandText = ChatEdit:getText()--发送的文字

        local item = listView:getItem(0)


        local PortraitBG = item:getChildByName("PortraitBG")
        local Level_BG = item:getChildByName("Level_BG")
        local Sand_To = item:getChildByName("Sand_To")
        local Play_Name1 = item:getChildByName("Play_Name1")
        local Chat_Info = item:getChildByName("Chat_Info")
        Chat_Info:setTextAreaSize(cc.size(620, 0))
        local Time_Label = item:getChildByName("Time_Label")

        local Play_Level = Level_BG:getChildByName("Play_Level")
        local Play_Name = Level_BG:getChildByName("Play_Name")
        local Tell_You = Level_BG:getChildByName("Tell_You")



        if FromServes.IsSand == true then 
            Level_BG:removeFromParent()
            PortraitBG:removeFromParent()



            print("FromServes.IsSand == true")
            Play_Name1:setString(FromServes.Player_Name)
            Play_Name1:setTouchEnabled(true)
            Play_Name1:addTouchEventListener(PrivateTouchName)
                
            Chat_Info:setString(FromServes.Player_Sand)
           
            Time_Label:setString(FromServes.Player_SandTime)

            cclog("true")

            

            if Chat_Info:getVirtualRendererSize().height<Chat_Info:getContentSize().height then
                local x = Chat_Info:getContentSize().height-Chat_Info:getVirtualRendererSize().height
                item:setSize(cc.size(730,item:getSize().height-x))
                Play_Name1:setPositionY(Play_Name1:getPositionY()-x)
                Time_Label:setPositionY(Time_Label:getPositionY()-x)
                Chat_Info:setPositionY(Chat_Info:getPositionY()-x)
                Sand_To:setPositionY(Sand_To:getPositionY()-x)
            end

            elseif FromServes.IsSand == false then 
            Sand_To:removeFromParent()
            Play_Name1:removeFromParent()

            Play_Name:setString(FromServes.Player_Name)
            Tell_You:setPositionX(Play_Name:getPositionX()+Play_Name:getContentSize().width+5)

            Chat_Info:setString(FromServes.Player_Sand)
            Time_Label:setString(FromServes.Player_SandTime)
            Play_Level:setString(FromServes.Player_LV)

            if FromServes.Vip == 2 then
                PortraitBG:loadTextures("res/chat/main_head_frame_gold.png","res/chat/main_head_frame_gold.png","res/chat/main_head_frame_gold.png")
            end

            local Portrait = maskedSpriteWithSprite(FromServes.Player_Portrait,"res/chat/avatar_head_bg.pvr.ccz","res/chat/main_head_frame_gold.png")-- 方法以后要改 问吴总要！
            Portrait:setPosition(PortraitBG:getPosition())
            Portrait:setScale(PortraitBG:getScale())
            Portrait:setAnchorPoint(PortraitBG:getAnchorPoint())
            item:addChild(Portrait)
            PortraitBG:setTag(FromServes.Play_Id)   
            PortraitBG:addTouchEventListener(OpenMenu)

            cclog("false")


            if Chat_Info:getVirtualRendererSize().height<Chat_Info:getContentSize().height then

                local x = Chat_Info:getContentSize().height-Chat_Info:getVirtualRendererSize().height
                item:setSize(cc.size(730,item:getSize().height-x))
                Level_BG:setPositionY(Level_BG:getPositionY()-x)
                PortraitBG:setPositionY(PortraitBG:getPositionY()-x)
                Portrait:setPositionY(Portrait:getPositionY()-x)
                Time_Label:setPositionY(Time_Label:getPositionY()-x)
                Chat_Info:setPositionY(Chat_Info:getPositionY()-x)

            end
        end 







            local items_count = table.getn(listView:getItems())
        -- cclog("items_count=="..items_count)
            if items_count>ChatMax then -- 检测聊天记录最大条数
                listView:removeLastItem()
                table.remove(From_Serve_Data_Private, 1)
            end 
    end

end 



local function OnTouch_Sand_BT(sender,eventType)

	if eventType == ccui.TouchEventType.began then

        elseif eventType == ccui.TouchEventType.moved then
            
        elseif eventType == ccui.TouchEventType.ended then

        	cclog("ChatEdit:getText()"..ChatEdit:getText())
        	-- 消息添加到聊天框
        	if ChatEdit:getText() ~= "" then 
                local lable = ccui.Text:create()   
                lable:setString(ChatEdit:getText())
                if lable:getStringLength()>CanEnterMaxTextNum then 
                    Out_Of_Range_For_Text:setVisible(true)
                    local move_ease_out = cc.EaseBackOut:create(cc.ScaleTo:create(0.35,1))
                    Out_Of_Range_For_Text_BG:runAction(move_ease_out)
                else 
                    if WhichChannel == "World" then 
                        if SNum>=1 then 

                            SNum = SNum - 1
                            Sand_Num:setString("免费:"..SNum)
                            cclog("Now_Player_ID1========="..Now_Player_ID)
                            SandMsgToWord(Now_Player_ID,ChatEdit:getText())
                        end 

                        elseif  WhichChannel == "Private" then 
                            cclog("Now_Player_ID2========="..Now_ChoosePlayer_ID)
                            SandMsgToPrivate(Now_ChoosePlayer_ID,ChatEdit:getText(),true)
                    end 

                end 

        	end



        	ChatEdit:setText("")
        	
        elseif eventType == ccui.TouchEventType.canceled then
        
        end
end



local function StartMove(sender,eventType)

        if eventType == ccui.TouchEventType.began then

        elseif eventType == ccui.TouchEventType.moved then
            
        elseif eventType == ccui.TouchEventType.ended then
  
        	if ChatIsOpen == false then 
            OpenChat:loadTextures("res/chat/chat_entrance_2.png","res/chat/chat_entrance_2.png","")
				PageView:scrollToPage(0)
				ChatIsOpen = true 
				elseif ChatIsOpen == true then 
                OpenChat:loadTextures("res/chat/chat_entrance_1.png","res/chat/chat_entrance_1.png","")
					PageView:scrollToPage(1)
					ChatIsOpen = false
			end 

        elseif eventType == ccui.TouchEventType.canceled then
        
        end
end     

local function _nPageViewEvent(sender, eventType)
	if eventType == ccui.PageViewEventType.turning then
	    local pageView = sender
	 	local pageViewType = pageView:getCurPageIndex()
	 	if pageViewType == 0 then 
            OpenChat:loadTextures("res/chat/chat_entrance_2.png","res/chat/chat_entrance_2.png","")
			ChatIsOpen = true 
			elseif pageViewType == 1 then
                OpenChat:loadTextures("res/chat/chat_entrance_1.png","res/chat/chat_entrance_1.png","")
				ChatIsOpen = false
		end  
	end
end
   
local function listViewEvent(sender, eventType)

	cclog("listViewlistViewlistView")
	print("select child index = ",sender:getCurSelectedIndex())

    if eventType == ccui.ListViewEventType.ons_selected_item then
        
    end
end

local function NoNameEditListener(sender,eventType)   
    if eventType == ccui.TouchEventType.ended then

        ToastTool("请选择私聊对象~~！！",true,"res/chat/Toast_BG.png",Chat_bg,Chat_bg:getContentSize().width/2,Chat_bg:getContentSize().height/2,2)

    end 
end   



local function Change_Channel(GoToChannelName)

    local LVPOSX = listView:getPositionX()
    local LVPOSY = listView:getPositionY()
    local LVSIZE = listView:getSize()
    local LVAP = listView:getAnchorPoint()



    listView:removeFromParent()
    listView = ccui.ListView:create()
    listView:setDirection(ccui.ScrollViewDir.vertical)
    listView:setTouchEnabled(true)
    listView:setBounceEnabled(true)

    listView:setSize(cc.size(LVSIZE.width,LVSIZE.height))
    listView:setPosition(cc.p(LVPOSX,LVPOSY))

    listView:setAnchorPoint(LVAP)
    Chat_bg:addChild(listView)


    if GoToChannelName == "Channel1" then 
        cclog("Channel1")
        WhichChannel = "World"
        LoadServerAddLVForWord()
        ChatEdit:setPosition(cc.p(5,510))
        Sand_Private_Name_Pos:setVisible(false)
        if HaveNoNameEdit == true then 
            NoNameEdit:removeFromParent()
            HaveNoNameEdit = false
        end 
        ChatEdit:setText("")

    elseif GoToChannelName == "Channel2" then 
        cclog("Channel2")
        WhichChannel = "Private"
        LoadServerAddLVForPrivate()
        ChatEdit:setPosition(cc.p(115,510))
        Sand_Private_Name_Pos:setVisible(true)

        if Sand_Private_Name_Test == "" then 
            cclog("私聊没有指定对象")
-- ChatEdit = cc.EditBox:create(cc.size(537,50), cc.Scale9Sprite:create("InputBox1.png"))

            NoNameEdit = ccui.Button:create()
            NoNameEdit:setTouchEnabled(true)
            NoNameEdit:loadTextures("res/chat/InputBox1.png", "res/chat/InputBox1.png", "")
            NoNameEdit:setScale9Enabled(true)
            NoNameEdit:setSize(cc.size(537,50))
            NoNameEdit:setPosition(cc.p(ChatEdit:getContentSize().width/2,ChatEdit:getContentSize().height/2))
            NoNameEdit:addTouchEventListener(NoNameEditListener)
            ChatEdit:addChild(NoNameEdit)

            HaveNoNameEdit = true
        end 

        ChatEdit:setText("")

    end 

    OpenChannel = GoToChannelName
end


local function SetVisFalse(dt)

    cclog("StartRemoveToast")

    local Menu_PortraitBG = Menu_BG:getChildByName("Menu_PortraitBG")
    Menu_PortraitBG:loadTextures("res/chat/main_head_frame_silver.png","res/chat/main_head_frame_gold.png","res/chat/main_head_frame_gold.png")

    Menu_Panel:setVisible(false)

    Deletescheduler:unscheduleScriptEntry(DeleteschedulerEntry)
    
end



local function CloseMenu()
    
    local move_ease_out = cc.EaseBackIn:create(cc.ScaleTo:create(0.35,0))
    Menu_BG:runAction(move_ease_out)

    Deletescheduler = cc.Director:getInstance():getScheduler()
    DeleteschedulerEntry = nil

    DeleteschedulerEntry = Deletescheduler:scheduleScriptFunc(SetVisFalse, 0.35, false)

end


local function GoToTalk(sender,eventType)

    if eventType == ccui.TouchEventType.ended then

        cclog("GoToTalk ====== "..Now_ChoosePlayer_ID)

        Sand_Private_Name_Test = Menu_PlayerData.PlayName
        Sand_Private_Name_Pos:setString(Sand_Private_Name_Test)
        Sand_Private_Name_Pos:setVisible(true)

        if HaveNoNameEdit == true then 
            NoNameEdit:removeFromParent()
            HaveNoNameEdit = false
        end 

        if OpenChannel ~= "Channel2" then 
            Channel1:loadTextures("res/chat/ChannelBG.png", "res/chat/ChannelON.png", "res/chat/ChannelON.png")  
            Channel2:loadTextures("res/chat/ChannelON.png", "res/chat/ChannelON.png", "res/chat/ChannelON.png")  
            Change_Channel("Channel2")
        end 

        CloseMenu()

    end

end 
local function GoToBlackList(sender,eventType)

    if eventType == ccui.TouchEventType.ended then
        AddBlackListById(Now_ChoosePlayer_ID)
        
        CloseMenu()
    end

end 
local function ChatMenuExit(sender,eventType)

    if eventType == ccui.TouchEventType.ended then

        CloseMenu()

    end

end 


local function SetVisFalse_Out_Of_Range_For_Text(dt)

    Out_Of_Range_For_Text:setVisible(false)

    Deletescheduler:unscheduleScriptEntry(DeleteschedulerEntry)
    
end



local function Close_Out_Of_Range_For_Text()
    
    local move_ease_out = cc.EaseBackIn:create(cc.ScaleTo:create(0.35,0))
    Out_Of_Range_For_Text_BG:runAction(move_ease_out)

    Deletescheduler = cc.Director:getInstance():getScheduler()
    DeleteschedulerEntry = nil

    DeleteschedulerEntry = Deletescheduler:scheduleScriptFunc(SetVisFalse_Out_Of_Range_For_Text, 0.35, false)

end

local function On_OK_Btn(sender,eventType)

    if eventType == ccui.TouchEventType.ended then

        Close_Out_Of_Range_For_Text()

    end
end 



local function ChannelControl(sender,eventType)

	if eventType == ccui.TouchEventType.ended then
		cclog("sender"..sender:getName())
		local father = sender:getParent()
		for i=1,2 do
			local Channel = father:getChildByTag(i)
            Channel:loadTextures("res/chat/ChannelBG.png", "res/chat/ChannelON.png", "res/chat/ChannelON.png")  
		end

        sender:loadTextures("res/chat/ChannelON.png", "res/chat/ChannelON.png", "res/chat/ChannelON.png")  
		
		if OpenChannel ~= sender:getName() then 

            Change_Channel(sender:getName())


			-- elseif sender:getName() == "Channel3" then 
			-- 	cclog("Channel3")
			-- 	-- LoadServerAddLVForPersonage()
		end	
	end 
	
end 



local function editBoxTextEventHandle(strEventName,pSender)
    local edit = pSender
    local TextFromEditBox
    if strEventName == "began" then

        cclog("editBox began ................")


        TextFromEditBox = string.format("editBox %p DidBegin !", edit)
        print(TextFromEditBox)
    elseif strEventName == "ended" then
        TextFromEditBox = string.format("editBox %p DidEnd !", edit)
        print(TextFromEditBox)
    elseif strEventName == "return" then
        TextFromEditBox = string.format("editBox %p was returned !",edit)
        if edit == EditName then
            TTFShowEditReturn:setString("Name EditBox return !")
        elseif edit == EditPassword then
            TTFShowEditReturn:setString("Password EditBox return !")
        elseif edit == EditEmail then
            TTFShowEditReturn:setString("Email EditBox return !")
        end 
        print(TextFromEditBox)
    elseif strEventName == "changed" then
        TextFromEditBox = string.format("editBox %p TextChanged, text: %s ", edit, edit:getText())
        print(TextFromEditBox)
    end  
end  

local function textFieldEvent(sender, eventType)

    if eventType == ccui.TextFiledEventType.attach_with_ime then

    elseif eventType == ccui.TextFiledEventType.detach_with_ime then

    elseif eventType == ccui.TextFiledEventType.insert_text then

    elseif eventType == ccui.TextFiledEventType.delete_backward then

    end
end


function CreatChatTools( Scene )


    Now_Player_ID = ReturnNowPlayerID()

    From_Serve_Data_Word = ServesDataForWord()

    From_Serve_Data_Private = ServesDataForPVE()
		
	local ui_widget = ccs.GUIReader:getInstance():widgetFromJsonFile("res/chat/ChatScene_1.json")
	Scene:addChild(ui_widget) 
      
	PageView = ui_widget:getChildByName("PageView")
	PageView:scrollToPage(1)
	ChatIsOpen = false


	local Panel_2 = PageView:getChildByName("Panel_2")

	OpenChat = Panel_2:getChildByName("OpenChat")

	ChatBG_Panel = Panel_2:getChildByName("Chat_Panel")

	Chat_bg = ChatBG_Panel:getChildByName("Chat_bg")

    Channel1 = Chat_bg:getChildByName("Channel1")
	Channel1:setTag(1)
	Channel2 = Chat_bg:getChildByName("Channel2")
	Channel2:setTag(2)
	-- local Channel3 = Chat_bg:getChildByName("Channel3")
	-- Channel3:setTag(3)
	--默认显示“世界”
	OpenChannel = "Channel1"
    Channel1:loadTextures("res/chat/ChannelON.png", "res/chat/ChannelON.png", "res/chat/ChannelON.png")

	Channel1:addTouchEventListener(ChannelControl)
	Channel2:addTouchEventListener(ChannelControl)
	-- Channel3:addTouchEventListener(ChannelControl)

	PageView:addEventListenerPageView(_nPageViewEvent)

 	OpenChat:addTouchEventListener(StartMove)
 


 	listView = Chat_bg:getChildByName("Chat_LV")
 	listView:addEventListenerListView(listViewEvent)

    WhichChannel = "World"

--  切换频道 更换输入框 原本输入框移动到屏幕外 坐标 = (375,-100)

    ChatEdit = cc.EditBox:create(cc.size(537,50), cc.Scale9Sprite:create("res/chat/InputBox1.png"))
    ChatEdit:setPosition(cc.p(5,510))



    -- local targetPlatform = cc.Application:getInstance():getTargetPlatform()
    -- if kTargetIphone == targetPlatform or kTargetIpad == targetPlatform then
    --     ChatEdit:setFontName("Paint Boy")
    -- else 
    --     ChatEdit:setFontName("fonts/Paint Boy.ttf")  
    -- end 
    ChatEdit:setAnchorPoint(cc.p(0,0.5))
    ChatEdit:setFontColor(cc.c3b(255,0,0))
    -- ChatEdit:setPlaceHolder("text:")
    -- ChatEdit:setPlaceholderFontColor(cc.c3b(255,255,255))
    ChatEdit:setMaxLength(CanEnterMaxTextNum)
    ChatEdit:setReturnType(cc.KEYBOARD_RETURNTYPE_DONE)
--Handler 
    ChatEdit:registerScriptEditBoxHandler(editBoxTextEventHandle)
    ChatBG_Panel:addChild(ChatEdit)

    local Sand_BT = Chat_bg:getChildByName("Sand_BT")
    Sand_BT:addTouchEventListener(OnTouch_Sand_BT)


    local Sand_Num_BG = Chat_bg:getChildByName("Sand_Num_BG")
    Sand_Num = Sand_Num_BG:getChildByName("Sand_Num")

    Sand_Private_Name_Pos = Chat_bg:getChildByName("Sand_Private_Name")
    Sand_Private_Name_Pos:setVisible(false)





    Menu_Panel = ui_widget:getChildByName("Menu_Panel")
    Menu_BG = Menu_Panel:getChildByName("Menu_BG")
    Menu_BG:setPosition(500,320)

    local Go_To_Talk = Menu_BG:getChildByName("Go_To_Talk")
    Go_To_Talk:addTouchEventListener(GoToTalk)
    local Go_To_BlackList = Menu_BG:getChildByName("Go_To_BlackList")
    Go_To_BlackList:addTouchEventListener(GoToBlackList)
    local Chat_Menu_Exit = Menu_BG:getChildByName("Chat_Menu_Exit")
    Chat_Menu_Exit:addTouchEventListener(ChatMenuExit)


    Out_Of_Range_For_Text = ui_widget:getChildByName("Out_Of_Range_For_Text")
    Out_Of_Range_For_Text_BG = Out_Of_Range_For_Text:getChildByName("Out_Of_Range_For_Text_BG")
    Out_Of_Range_For_Text_BG:setPosition(500,320)

    local OK_Btn = Out_Of_Range_For_Text_BG:getChildByName("OK_Btn")
    OK_Btn:addTouchEventListener(On_OK_Btn)


 	-- TextField:setReturnType(cc.KEYBOARD_RETURNTYPE_DONE )
    --Handler 
    -- TextField:registerScriptEditBoxHandler(editBoxTextEventHandle)

 	LoadServerAddLVForWord()

end
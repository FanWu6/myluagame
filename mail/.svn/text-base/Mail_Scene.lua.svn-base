
require "src/mail/Simulate_Serves"
require "src/mail/ToolsHelper"

local Mail_Data -- 服务器传过来的邮件标题信息
-- local Mail_Info_Data -- 服务器传过来的邮件内容信息

local Mail_Panel
local Mail_Box_BG
local Mail_Box_LV

local Mail_Info_Panel
local Mail_Content_BG

local Get_Sth_Bt
local Close_Bt

local Deletescheduler
local DeleteschedulerEntry

-- local Deletescheduler
-- local DeleteschedulerEntry

local Mail_Content
local Mail_Content_SC
local IsHaveSth -- 是否有物品
local HaveSth_Index  -- 物品种类
local Choose_WhichMail_Index -- 选择了哪封邮件
local Touch_ListView_Index

local SthBG--获得物品背景

local function SetVisFalse(dt)

    cclog("StartRemoveToast")

    Mail_Info_Panel:setVisible(false)
    Get_Sth_Bt:setVisible(false)
    Close_Bt:setVisible(false)
    Mail_Content:setPositionY(344)
    
    if IsHaveSth == true then 
        for i=1,HaveSth_Index do
            local _HaveSth = SthBG:getChildByTag(100+i)
            _HaveSth:removeFromParent()
            local _SthInfo = SthBG:getChildByTag(200+i)
            _SthInfo:removeFromParent()
        end

    end 
    Deletescheduler:unscheduleScriptEntry(DeleteschedulerEntry)
    
end



local function CloseMenu()
    
    local move_ease_out = cc.EaseBackIn:create(cc.ScaleTo:create(0.35,0))
    Mail_Content_BG:runAction(move_ease_out)

    Deletescheduler = cc.Director:getInstance():getScheduler()
    DeleteschedulerEntry = nil

    DeleteschedulerEntry = Deletescheduler:scheduleScriptFunc(SetVisFalse, 0.35, false)

end






local function On_Get_Sth(sender,eventType)

if eventType == ccui.TouchEventType.began then

    elseif eventType == ccui.TouchEventType.moved then
        
    elseif eventType == ccui.TouchEventType.ended then

        cclog("On_Get_SthOn_Get_SthOn_Get_SthOn_Get_Sth"..sender:getTag())

        cclog("Touch_ListView_Index======="..Touch_ListView_Index)
        
        Mail_Box_LV:removeItem(Touch_ListView_Index)
        
        local Remove_Table_Index = table.getn(Mail_Data)-Touch_ListView_Index
        SthBG:setVisible(false)
        cclog("Mail_Data =====" ..table.getn(Mail_Data))

        table.remove(Mail_Data, Remove_Table_Index)
        -- table.remove(Mail_Info_Data, Remove_Table_Index)
        cclog("Mail_Data =====" ..table.getn(Mail_Data))

        -- for i=1,table.getn(Mail_Data) do
        -- print(Mail_Data[i]._MailEnvelope.Mail_Title)
        -- print(Mail_Data[i]._MailEnvelope.Sand_Name)
        -- print(Mail_Data[i]._MailEnvelope.Sand_Date)
        -- print(Mail_Data[i]._MailEnvelope.IsOpen)
        -- print(Mail_Data[i]._MailContent.Sth_NO)
        -- print(Mail_Data[i]._MailContent.Mail_Info)
        -- for j=1,Mail_Data[i]._MailContent.Sth_NO do
        --     print(Mail_Data[i]._MailContent.Sth_Res.Sth_ID[j])
        --     print(Mail_Data[i]._MailContent.Sth_Res.Res[j])
        --     print(Mail_Data[i]._MailContent.Sth_Res.Sth_Describe[j])
        --     print(Mail_Data[i]._MailContent.Sth_Res.Sth_HaveNum[j])
        -- end
        -- end

        CloseMenu()

    elseif eventType == ccui.TouchEventType.canceled then
    
    end
end

local function On_Close(sender,eventType)

if eventType == ccui.TouchEventType.began then

    elseif eventType == ccui.TouchEventType.moved then
        
    elseif eventType == ccui.TouchEventType.ended then

        cclog("On_CloseOn_CloseOn_CloseOn_CloseOn_CloseOn_Close"..sender:getTag())

        Mail_Data[sender:getTag()]._MailEnvelope.IsOpen = true

        CloseMenu()

    elseif eventType == ccui.TouchEventType.canceled then
    
    end
end


local function SthTouchEvent(sender,eventType)
    
    local Mail_InfoTouch_BG = Mail_Info_Panel:getChildByName("Mail_InfoTouch_BG")
    local Mail_Info_Image = Mail_InfoTouch_BG:getChildByName("Mail_Info_Image")
    local Sth_Name = Mail_InfoTouch_BG:getChildByName("Sth_Name")
    local Sth_Info = Mail_InfoTouch_BG:getChildByName("Sth_Info")
    local Sth_Num = Mail_InfoTouch_BG:getChildByName("Sth_Num")

if eventType == ccui.TouchEventType.began then
        cclog("begin"..sender:getTag())
        sender:setScale(0.45)

        Mail_InfoTouch_BG:setVisible(true)
        local move_ease_out = cc.EaseBackOut:create(cc.ScaleTo:create(0.35,1))
        Mail_InfoTouch_BG:runAction(move_ease_out)

        Mail_Info_Image:loadTexture(Mail_Data[Choose_WhichMail_Index]._MailContent.Sth_Res.Res[sender:getTag()-100])
        Sth_Name:setString(Mail_Data[Choose_WhichMail_Index]._MailContent.Sth_Res.Sth_Name[sender:getTag()-100])
        Sth_Info:setString(Mail_Data[Choose_WhichMail_Index]._MailContent.Sth_Res.Sth_Describe[sender:getTag()-100])
        Sth_Num:setString("含有"..Mail_Data[Choose_WhichMail_Index]._MailContent.Sth_Res.Sth_HaveNum[sender:getTag()-100].."个")
    elseif eventType == ccui.TouchEventType.moved then
        cclog("moved"..sender:getTag())
    elseif eventType == ccui.TouchEventType.ended then

        local move_ease_out = cc.EaseBackIn:create(cc.ScaleTo:create(0.35,0))
        Mail_InfoTouch_BG:runAction(move_ease_out)
        sender:setScale(0.5)

    elseif eventType == ccui.TouchEventType.canceled then

        local move_ease_out = cc.EaseBackIn:create(cc.ScaleTo:create(0.35,0))
        Mail_InfoTouch_BG:runAction(move_ease_out)
        sender:setScale(0.5)
    end
end



local function Mail_Info_LoadingData(Mail_Info_Index)


    Choose_WhichMail_Index = Mail_Info_Index

    local Mail_Title_BG = Mail_Content_BG:getChildByName("Mail_Title_BG")
    local Mail_Title = Mail_Title_BG:getChildByName("Mail_Title")
    Mail_Title:setString(Mail_Data[Mail_Info_Index]._MailEnvelope.Mail_Title)

    Get_Sth_Bt = Mail_Content_BG:getChildByName("Get_Sth")
    -- Get_Sth_Bt:setTag(Mail_Info_Index)
    Get_Sth_Bt:addTouchEventListener(On_Get_Sth)
    Close_Bt = Mail_Content_BG:getChildByName("Close")
    Close_Bt:setTag(Mail_Info_Index)
    Close_Bt:addTouchEventListener(On_Close)

    -- Mail_Content_SC = Mail_Content_BG:getChildByName("Mail_Content_SC")
    Mail_Content = Mail_Content_SC:getChildByName("Mail_Content")
    Mail_Content:setTextAreaSize(cc.size(360, 0)) -- 关键

-- Size szContent; 
-- szContent = scrollContent->getSize(); 
-- lbContent->setTextAreaSize(Size(szContent.width, 0)); 
-- lbContent->setText(((String*)g_HelpStrings->objectForKey("daer_introduce"))->getCString());         
-- szContent = lbContent->getVirtualRendererSize(); 
 



    HaveSth_Index = Mail_Data[Mail_Info_Index]._MailContent.Sth_NO

    if HaveSth_Index>0 then 

        Get_Sth_Bt:setVisible(true)
        -- cclog("Mail_Info_Data[Mail_Info_Index]===="..Mail_Info_Data[Mail_Info_Index].Mail_Info)
        Mail_Content:setString(Mail_Data[Mail_Info_Index]._MailContent.Mail_Info)

        local SthRes = Mail_Data[Mail_Info_Index]._MailContent.Sth_Res.Res


        local Interval_Index = 200
        local Interval = 50
        SthBG:setVisible(true)
        -- SthBG = cc.Scale9Sprite:create("Mail_InfoTouch_BG.png")
        SthBG:setContentSize(cc.size(370, 60*HaveSth_Index))
        

        -- Mail_Content_SC:addChild(SthBG)

        for i=1,HaveSth_Index do
            print("cqcqcq"..SthRes[i])

            cclog("posy ===="..Mail_Content:getPositionY())
            cclog("sizeh"..Mail_Content:getVirtualRendererSize().height)


            -- local _HaveSth = cc.Sprite:create(SthRes[i])
            -- _HaveSth:setPosition(Mail_Content:getPositionX()+30,Interval*i)
            -- _HaveSth:setScale(0.5)
            -- _HaveSth:setTag(100+i)
            -- Mail_Content_SC:addChild(_HaveSth)




            local _HaveSth = ccui.Button:create()
            _HaveSth:setTouchEnabled(true)
            _HaveSth:setScale(0.5) 
            _HaveSth:setAnchorPoint(cc.p(0.5,1)) 
            _HaveSth:loadTextures(SthRes[i],SthRes[i],SthRes[i])
            _HaveSth:setPosition(30,SthBG:getContentSize().height+40-Interval*i)    
            _HaveSth:setTag(100+i)  
            _HaveSth:addTouchEventListener(SthTouchEvent)
            SthBG:addChild(_HaveSth)

            local _SthInfo = ccui.Text:create()
            _SthInfo:setString("物品信息")  
            _SthInfo:setAnchorPoint(cc.p(0,1))  
            _SthInfo:setFontSize(16)
            _SthInfo:setTag(200+i)
            _SthInfo:setPosition(_HaveSth:getPositionX()+35,_HaveSth:getPositionY())
            SthBG:addChild(_SthInfo)
        end

        IsHaveSth = true

        local SCInnerContainerSize_Height = Mail_Content:getVirtualRendererSize().height+SthBG:getContentSize().height
        cclog("Mail_Content====".. Mail_Content:getVirtualRendererSize().height)

        Mail_Content_SC:setInnerContainerSize(cc.size(370,SCInnerContainerSize_Height+20))
        SthBG:setPosition(Mail_Content_SC:getContentSize().width/2,Mail_Content_SC:getInnerContainerSize().height-Mail_Content:getVirtualRendererSize().height-20)
        cclog("Mail_Content_SC====".. Mail_Content_SC:getInnerContainerSize().height-Mail_Content:getVirtualRendererSize().height)

        if (Mail_Content_SC:getInnerContainerSize().height>Mail_Content_SC:getContentSize().height) then 

            Mail_Content:setPositionY(Mail_Content:getVirtualRendererSize().height+HaveSth_Index*Interval+50)
            cclog(">>>>>>>>>>>>>>>>")
        end
    else 

        Close_Bt:setVisible(true)
        Mail_Content:setString(Mail_Data[Mail_Info_Index]._MailContent.Mail_Info)
        Mail_Content_SC:setInnerContainerSize(cc.size(370,Mail_Content:getVirtualRendererSize().height))

        if (Mail_Content_SC:getInnerContainerSize().height>Mail_Content_SC:getContentSize().height) then 
            
            Mail_Content:setPositionY(Mail_Content:getVirtualRendererSize().height)

        end
        IsHaveSth = false 
    end 

end

local function MailBoxBGtouch(sender,eventType)

    if eventType == ccui.TouchEventType.began then
        sender:setScale(0.95)
            cclog("began")
        elseif eventType == ccui.TouchEventType.moved then
            -- sender:setScale(1)
            cclog("moved")
        elseif eventType == ccui.TouchEventType.ended then

            local Mail_Item_Image = sender:getChildByName("Mail_Item_Image")
        sender:loadTextures("res/mail/mailbox_maillist_read_bg.png","res/mail/mailbox_maillist_read_bg.png","res/mail/mailbox_maillist_read_bg.png")

            local x = Mail_Data[table.getn(Mail_Data)-Touch_ListView_Index]._MailContent.Sth_NO

            if x == 0 then 
            Mail_Item_Image:loadTexture("res/mail/mailbox_maillist_letter_open_icon.jpg")
            end 
            cclog("table.getn(Mail_Data)"..table.getn(Mail_Data))
            cclog("Touch_ListView_Index"..Touch_ListView_Index)

            cclog("table.getn(Mail_Data)-Touch_ListView_Index"..table.getn(Mail_Data)-Touch_ListView_Index)

            cclog("cqcqqcqcqcqcqcqcq=========".. Mail_Data[table.getn(Mail_Data)-Touch_ListView_Index]._MailContent.Sth_NO
)


                Mail_Info_Panel:setVisible(true)
                local move_ease_out = cc.EaseBackOut:create(cc.ScaleTo:create(0.35,1))
                Mail_Content_BG:runAction(move_ease_out)
                Mail_Info_LoadingData(table.getn(Mail_Data)-Touch_ListView_Index)

                sender:setScale(1)


                -- Mail_Box_LV:removeItem(sender:getTag())
            -- end
        elseif eventType == ccui.TouchEventType.canceled then

            sender:setScale(1)
    end
end

local function listViewEvent(sender, eventType)
    if eventType == ccui.ListViewEventType.onsSelectedItem then
        print("select child index = ",sender:getCurSelectedIndex())

        Touch_ListView_Index = sender:getCurSelectedIndex()
    end
end

local function ListViewLoadingData(Data)
	


 	local ServerNote = table.getn(Data)

 	for i=1,ServerNote do
        Mail_Box_LV:pushBackDefaultItem()--创建Item
	end




	for i=0,ServerNote-1 do--在每个Item内添加内容

		local item = Mail_Box_LV:getItem(i) 
    	local Index = ServerNote-i


    	local Mail_Item_BG = item:getChildByName("Mail_Item_BG")
    	local Mail_Item_Image = Mail_Item_BG:getChildByName("Mail_Item_Image")

        local Mail_Title = Mail_Item_BG:getChildByName("Mail_Title")
        Mail_Title:setString(Mail_Data[Index]._MailEnvelope.Mail_Title)
        local Mail_Sand_Name = Mail_Item_BG:getChildByName("Mail_Sand_Name")
        Mail_Sand_Name:setString(Mail_Data[Index]._MailEnvelope.Sand_Name)
        local Mail_Sand_Data = Mail_Item_BG:getChildByName("Mail_Sand_Data")
        Mail_Sand_Data:setString(Mail_Data[Index]._MailEnvelope.Sand_Date)

        Mail_Item_BG:addTouchEventListener(MailBoxBGtouch)


    	if Mail_Data[Index]._MailEnvelope.IsOpen == true then
            Mail_Item_BG:loadTextures("res/mail/mailbox_maillist_read_bg.png", "res/mail/mailbox_maillist_read_bg.png", "res/mail/mailbox_maillist_read_bg.png")
            Mail_Item_Image:loadTexture("res/mail/mailbox_maillist_letter_open_icon.jpg")
    	end
        cclog("Mail_Data[Index]._MailEnvelope.Sth_NO ==="..Mail_Data[Index]._MailContent.Sth_NO)
        if Mail_Data[Index]._MailContent.Sth_NO ~=0 then 
            Mail_Item_Image:loadTexture("res/mail/101.jpg")
        end 



	end 
end 

local function Open_Mail(sender,eventType)

if eventType == ccui.TouchEventType.began then

    elseif eventType == ccui.TouchEventType.moved then
        
    elseif eventType == ccui.TouchEventType.ended then

    	Mail_Panel:setVisible(true)
    	local move_ease_out = cc.EaseBackOut:create(cc.ScaleTo:create(0.35,1))
        Mail_Box_BG:runAction(move_ease_out)
        ListViewLoadingData(Mail_Data)

    elseif eventType == ccui.TouchEventType.canceled then
    
    end
end

function StartRemove(dt)

    cclog("StartRemoveToast")

    

    for i=1,table.getn(Mail_Data) do
        Mail_Box_LV:removeLastItem()
    end
    Mail_Panel:getParent():removeFromParent()
    Deletescheduler:unscheduleScriptEntry(DeleteschedulerEntry)
    
end


function RemoveObject()


    local move_ease_out = cc.EaseBackIn:create(cc.ScaleTo:create(0.35,0))
    Mail_Box_BG:runAction(move_ease_out)

    Deletescheduler = cc.Director:getInstance():getScheduler()
    DeleteschedulerEntry = nil

    DeleteschedulerEntry = Deletescheduler:scheduleScriptFunc(StartRemove, 0.35, false)
    
end


local function CloseHandle(sender,eventType)
    if eventType == ccui.TouchEventType.ended then 
        print("关闭界面")
        RemoveObject()

    end
end



function CreatMail_Scene(Scene)

	local ui_widget = ccs.GUIReader:getInstance():widgetFromJsonFile("res/mail/MailScene_1.json")

	Scene:addChild(ui_widget) 




    Mail_Data = ServesDataForMail() -- 读取服务器信息
    -- Mail_Info_Data = ServesDataForMail_Info()

--	local Open_MailScene = ui_widget:getChildByName("Open_MailScene")
--	Open_MailScene:addTouchEventListener(Open_Mail)


	Mail_Panel = ui_widget:getChildByName("Mail_Panel")

    Mail_Panel:addTouchEventListener(CloseHandle)

	Mail_Box_BG = Mail_Panel:getChildByName("Mail_Box_BG")

    local Mail_Exit = Mail_Box_BG:getChildByName("Mail_Exit")
    Mail_Exit:addTouchEventListener(CloseHandle)


    Mail_Info_Panel = ui_widget:getChildByName("Mail_Info_Panel")

    Mail_Content_BG = Mail_Info_Panel:getChildByName("Mail_Content_BG")

    Mail_Content_SC = Mail_Content_BG:getChildByName("Mail_Content_SC")

    SthBG = cc.Scale9Sprite:create("res/mail/Mail_InfoTouch_BG.png")
    SthBG:setAnchorPoint(cc.p(0.5,1)) 
    Mail_Content_SC:addChild(SthBG)

    Mail_Box_LV = Mail_Box_BG:getChildByName("Mail_Box_LV")
    Mail_Box_LV:addEventListenerListView(listViewEvent)
    local model = Mail_Panel:getChildByName("Custom_Item")
    Mail_Box_LV:setItemModel(model)

    Mail_Panel:setVisible(true)
    local move_ease_out = cc.EaseBackOut:create(cc.ScaleTo:create(0.35,1))
    Mail_Box_BG:runAction(move_ease_out)
    ListViewLoadingData(Mail_Data)

end
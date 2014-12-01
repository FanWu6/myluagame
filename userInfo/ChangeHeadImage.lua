local changeHeadPanel
local testNum = nil
local parent = nil
local headData  = {
    {"Dot","DragonTurtle","GlaiveThrower","Goblinjr","Necromancer","SkeletonWarrior","Coco","NagaArcher","Ghoul","SpellBreaker","Treant"},
    {"Axe","BB","CM","CW","DP","DR","Ench","Lich","Luna","POM","QOP","SF","SNK","THD","Troll","Sil","AM","Panda"},
    {"Spider","SwitchCoco","SwitchHuskar","SwitchSil","TA","TBult","VS","Footman","JUGG","TB","Ursa","Marine","Med"}
}

local function _closeHandle(sender,eventType)
    if eventType == ccui.TouchEventType.ended then 
        print("关闭界面")
        changeHeadPanel:setVisible(false)
    end
end

local function showHeadToPanel(data,panel)
    local imgWidth = 104 
    for i=1,table.maxn(data),1 do
        local function touchEvent(sender,eventType)
            local btn = sender
            if eventType == ccui.TouchEventType.began then
--                self._displayValueLabel:setString("Touch Down")
                sender:setScale(0.95)
            elseif eventType == ccui.TouchEventType.moved then
--                self._displayValueLabel:setString("Touch Move")
                sender:setScale(0.95)
            elseif eventType == ccui.TouchEventType.ended then
--                self._displayValueLabel:setString("Touch Up")
                --关闭界面
                --头像icon
                sender:setScale(1)
                changeUserDataIcon(btn:getName())
                parent:updateHeadImg()
                changeHeadPanel:setVisible(false)
                
            elseif eventType == ccui.TouchEventType.canceled then
                sender:setScale(1)
            end
        end    
        local button = ccui.Button:create()
        button:setName(data[i])
        button:setTouchEnabled(true)
        button:loadTextures("res/userInfo/head/"..data[i]..".jpg", "res/userInfo/head/"..data[i]..".jpg", "")
        local x =((i-1)%5)*(imgWidth+14)+100
        local y = panel:getContentSize().height - math.floor(((i-1)/5)) * (imgWidth+4)-60
        button:setPosition(x,y)  
        button:addTouchEventListener(touchEvent)
        panel:addChild(button)
        
    end
end


function showChangeHeadPanel(_parent,panel)
    parent = _parent
    changeHeadPanel = panel
    changeHeadPanel:setVisible(true)
    changeHeadPanel:addTouchEventListener(_closeHandle)
    local scrollView = changeHeadPanel:getChildByName("NameCh_Panel"):getChildByName("bg"):getChildByName("contentScrollView")
    local normal = scrollView:getChildByName("normalPanel"):getChildByName("headItemPanel")
    local PurplePanel = scrollView:getChildByName("PurplePanel"):getChildByName("headItemPanel")
    local ArenaPanel = scrollView:getChildByName("ArenaPanel"):getChildByName("headItemPanel")
    showHeadToPanel(headData[1],normal)
end




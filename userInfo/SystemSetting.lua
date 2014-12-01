require "src/userInfo/RechargeCode"
require "src/userInfo/BlackList"

local _systemPanel
local currDataState = {}
local soundBtnState
local _contentPanel
local ui_widget

local systemPanelInstance = nil
local systemPanelState
local systemPanelScene = {};

systemPanelScene.new = function(self) 
    local o = {}
    setmetatable(o,self); 
    self.__index = self; 
    return o; 
end

systemPanelScene.buttonInit = function(self)
    local closeBtn = _systemPanel:getChildByName("closeBtn")
    local scrollView = _systemPanel:getChildByName("contentScrollView")
    local soundBtn = scrollView:getChildByName("soundBtn")
    local codeBtn = scrollView:getChildByName("codeBtn")
    local blacklistBtn = scrollView:getChildByName("blacklistBtn")

    local function _closeHandle(sender,eventType)
        if eventType == ccui.TouchEventType.ended then 
            print("关闭系统设置界面")
            ui_widget:removeFromParent()
        end
    end
    closeBtn:addTouchEventListener(_closeHandle)

    local function _soundBtnHandle(sender,eventType)
        if eventType == ccui.TouchEventType.ended then 
            print("控制开关")
            local soundBtn = sender
            local soundImg = soundBtn:getChildByName("soundImg")
            if soundBtnState == 1 then
                soundImg:loadTexture("res/userInfo/playerinfo_button_sound_off_1.png")
                soundBtnState = 0
            else 
                soundImg:loadTexture("res/userInfo/playerinfo_button_sound_on_1.png")
                soundBtnState = 1
            end
        end
    end
    soundBtn:addTouchEventListener(_soundBtnHandle)
    soundBtnState = 1

    local function _codeBtntnHandle(sender,eventType)
        if eventType == ccui.TouchEventType.ended then 
            print("打开兑换码界面")
            local panel = rechargeCodeSceneCreate():Create()
            ui_widget:addChild(panel,10,10)
        end
    end
    codeBtn:addTouchEventListener(_codeBtntnHandle)
    
    local function _blacklistBtnHandle(sender,eventType)
        if eventType == ccui.TouchEventType.ended then 
            print("打开黑名单界面")
            local panel = blackListSceneCreate():Create()
            ui_widget:addChild(panel,10,10)
        end
    end
    blacklistBtn:addTouchEventListener(_blacklistBtnHandle)
end

local function changeBtnState(num)
    if nil ~= currDataState then
        local currState = currDataState[num]
        if currState == true then 
            currDataState[num] = false
        else
            currDataState[num] = true
        end
    end
end

--初始化按钮状态
local function initBtnState()
    for i=1,10,1 do
        if i%2 == 0 then
            currDataState[i] = true
        else 
            currDataState[i] = false
        end
    end
end

--开关推送 执行指定的推送功能
local function  changeBtnFunction(num)


    if num == 1  then       --12点领取体力
    	
    elseif num == 2  then   --9点商城刷新
    
    elseif num == 3 then    --18点领取体力
    
    elseif num == 4  then   --21商城刷新

    elseif num == 5 then    --体力回复满通知
    
    elseif num == 6  then   --技能点回复满通知

    elseif num == 7 then    --竞技场被攻击通知
    
    elseif num == 8  then   --宝藏被掠夺通知

    elseif num == 9 then    --私聊消息通知
    
    elseif num == 10  then  --矿已采完通知

    end

end


local function _closeHandle(sender,eventType)
    if eventType == ccui.TouchEventType.ended then 
        print("关闭信息界面")
        ui_widget:removeFromParent()
    end
end

systemPanelScene.init = function(self)
    _contentPanel:setVisible(true)
    local scrollView = _systemPanel:getChildByName("contentScrollView")
    
    local function selectedEvent(sender,eventType)
        local cBox = sender
        local parName = cBox:getParent():getName()
        local tempStr = string.sub(parName,10,10)
        changeBtnState(tempStr)
        changeBtnFunction(tempStr)
        if eventType == ccui.CheckBoxEventType.selected then  --unslc
            cBox:loadTextureBackGround("res/userInfo/playerinfo_button_notice_clos.png")
            cBox:loadTextureBackGroundSelected("res/userInfo/playerinfo_button_notice_clos.png")
        elseif eventType == ccui.CheckBoxEventType.unselected then  --slc
            cBox:loadTextureBackGround("res/userInfo/playerinfo_button_notice_ope.png")
            cBox:loadTextureBackGroundSelected("res/userInfo/playerinfo_button_notice_ope.png")
        end
    end
    
    initBtnState() 
    
    for i=1,10,1 do
        local pushPanel = scrollView:getChildByName("pushLine_"..i)
        local cBox = pushPanel:getChildByName("cBoxBtn")
        cBox:setTouchEnabled(true)
        cBox:addEventListenerCheckBox(selectedEvent)  
        cBox:setSelectedState(currDataState[i])
        if currDataState[i]==true then  --unslc
            cBox:loadTextureBackGround("res/userInfo/playerinfo_button_notice_clos.png")
            cBox:loadTextureBackGroundSelected("res/userInfo/playerinfo_button_notice_clos.png")
        elseif currDataState[i]== false then  --slc
            cBox:loadTextureBackGround("res/userInfo/playerinfo_button_notice_ope.png")
            cBox:loadTextureBackGroundSelected("res/userInfo/playerinfo_button_notice_ope.png")
        end
    end
    
    _contentPanel:addTouchEventListener(_closeHandle)
end


systemPanelScene.Create = function(self)
    ui_widget = ccs.GUIReader:getInstance():widgetFromJsonFile("res/userInfo/systemSettingPanel.json")
    _contentPanel = ui_widget:getChildByName("systemPanel")
    _systemPanel = _contentPanel:getChildByName("systemSp_Panel"):getChildByName("bg")
    systemPanelState = "systemPush"
    systemPanelScene.buttonInit(self)
    systemPanelScene.init(self)

    return ui_widget
end

function systemPanelSceneCreate()
    -- body

    systemPanelInstance = systemPanelScene:new()

    return systemPanelInstance

end

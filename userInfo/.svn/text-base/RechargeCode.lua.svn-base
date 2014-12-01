local _rechargeCodePanel
local inputTxt
local ui_widget

local rechargeCodeInstance = nil
local rechargeCodeState
local rechargeCodeScene = {};


rechargeCodeScene.new = function(self) 
    local o = {}
    setmetatable(o,self); 
    self.__index = self; 
    return o; 
end

rechargeCodeScene.buttonInit = function(self)
    local cancleBtn = _rechargeCodePanel:getChildByName("rechargeCp_Panel"):getChildByName("bg"):getChildByName("cancleBtn")
    local okBtn = _rechargeCodePanel:getChildByName("rechargeCp_Panel"):getChildByName("bg"):getChildByName("okBtn")


    local function _cancleBtnHandle(sender,eventType)
        if eventType == ccui.TouchEventType.ended then 
            print("取消")
            ui_widget:removeFromParent()
        end
    end
    cancleBtn:addTouchEventListener(_cancleBtnHandle)

    local function _okBtnHandle(sender,eventType)
        if eventType == ccui.TouchEventType.ended then 
            print("确定，打开提示框")
            --获取钻石   获取金币
        end
    end
    okBtn:addTouchEventListener(_okBtnHandle)
end


local function _closeHandle(sender,eventType)
    if eventType == ccui.TouchEventType.ended then 
        print("关闭界面")
        ui_widget:removeFromParent()
    end
end

local function editBoxTextEventHandle(strEventName,pSender)
    local edit = pSender
    local strFmt 
    if strEventName == "began" then
        strFmt = string.format("editBox %p DidBegin !", edit)
        print(strFmt)
    elseif strEventName == "ended" then
        strFmt = string.format("editBox %p DidEnd !", edit)
        print(strFmt)
    elseif strEventName == "return" then
        strFmt = string.format("editBox %p was returned !",edit)
        print(strFmt)
    elseif strEventName == "changed" then
        strFmt = string.format("editBox %p TextChanged, text: %s ", edit, edit:getText())
        print(strFmt)
    end
end

rechargeCodeScene.init = function(self)
    local inner = _rechargeCodePanel:getChildByName("rechargeCp_Panel")
    _rechargeCodePanel:addTouchEventListener(_closeHandle)
    local bg = _rechargeCodePanel:getChildByName("rechargeCp_Panel"):getChildByName("bg")
    inputTxt = cc.EditBox:create(cc.size(339,47),cc.Scale9Sprite:create("res/userInfo/main_head_name_bg_silve.png"))
    inputTxt:setPosition(cc.p(200, 110))
    inputTxt:setFontSize(14)
    inputTxt:setFontColor(cc.c3b(255,255,255))
    inputTxt:setReturnType(cc.KEYBOARD_RETURNTYPE_DONE )
    inputTxt:setInputMode(cc.EDITBOX_INPUT_MODE_SINGLELINE)
    --Handler
    inputTxt:registerScriptEditBoxHandler(editBoxTextEventHandle)
    bg:addChild(inputTxt)
end


rechargeCodeScene.Create = function(self)
    
    ui_widget = ccs.GUIReader:getInstance():widgetFromJsonFile("res/userInfo/rechargeCodePanel.json")
    _rechargeCodePanel = ui_widget:getChildByName("rechargeCodePanel")
    rechargeCodeState = "rechargeCode"
    rechargeCodeScene.buttonInit(self)
    rechargeCodeScene.init(self)

    return ui_widget
end

function rechargeCodeSceneCreate()
    -- body

    rechargeCodeInstance = rechargeCodeScene:new()

    return rechargeCodeInstance

end

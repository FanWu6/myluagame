require "src/network/httpRequest"
local scene
local ui_widget
local contact_panel
local EditName = nil
local EditPassword = nil
local function initCGhandler()
    CG_HANDLER(PACKET_CG_LoginGame) --登陆游戏
        
    --获取玩家信息
    local playerToken = function()
        XMLhttpRequestInit(contact_panel,EditName,EditPassword,SceneMainLogIn)
    end
    SET_CallBack(PACKET_GC_PlayerInfo,playerToken)
    CG_HANDLER(PACKET_CG_PlayerInfo) 
end

local function HTTPRequest()
   
    --contactAnimation
    local gear = contact_panel:getChildByName("gearImage")
    local rotateAction =  cc.RepeatForever:create(cc.RotateBy:create(0.5,90))
    gear:runAction(rotateAction)
    local function contactShow()
        contact_panel:setVisible(true)

    end
    local function contactNotShow()
        contact_panel:setVisible(false)
    end
    
--    XMLhttpRequestInit(contact_panel,SceneMainLogIn)
    --Get
    local function onMenuGetClicked(sender,eventType)
        local _button = sender
        --        cclog("tag====".. _button:getTag()) 
        if eventType == ccui.TouchEventType.began then
            _button:setLocalZOrder(3)
        elseif eventType == ccui.TouchEventType.moved then
         --移动按钮没有操作
        elseif eventType == ccui.TouchEventType.canceled then   
            _button:setLocalZOrder(0)
        elseif eventType == ccui.TouchEventType.ended then     --end之后的回调
            -- XMLhttpRequestInit(contact_panel,EditName,EditPassword,SceneMainLogIn)
            --1
--            getItemData()
            local function fuc1()
                print("SOCKET_IP===="..SOCKET_IP)
             SocketTCP:init(SOCKET_IP,SOCKET_PORT,false)
             SocketTCP:connect()
            end

            --2
            local function fuc2()
                initCGhandler()
            end
--            SocketTCP:init(SOCKET_IP,SOCKET_PORT,false)
--            SocketTCP:connect()
--            initCGhandler()
            --3  网络
--           
            local delay1 = cc.DelayTime:create(1)
            local delay = cc.DelayTime:create(0)
            sender:runAction(cc.Sequence:create(cc.CallFunc:create(fuc1),delay1,cc.CallFunc:create(fuc2)))
            
            --本地
--            SceneMainLogIn()
            --
        end
    end

    local confirm_btn  = ui_widget:getChildByName("enter_btn")

    confirm_btn:addTouchEventListener(onMenuGetClicked)

end

local function LandMain()
    local editBoxSize = cc.size(200,50)

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
            if edit == EditName then
                print("Name EditBox return !")
            elseif edit == EditPassword then
                print("Password EditBox return !")
           
            end
            print(strFmt)
        elseif strEventName == "changed" then
            strFmt = string.format("editBox %p TextChanged, text: %s ", edit, edit:getText())
            print(strFmt)
        end
    end
    -- top
    EditName = cc.EditBox:create(editBoxSize, cc.Scale9Sprite:create("res/LoginUI/green_edit.png"))
    EditName:setPosition(cc.p(562, 300))
    EditName:setFontSize(25)
    EditName:setFontColor(cc.c3b(255,0,0))
    EditName:setPlaceHolder("Name:")
    EditName:setPlaceholderFontColor(cc.c3b(255,255,255))
    EditName:setMaxLength(8)
    EditName:setReturnType(cc.KEYBOARD_RETURNTYPE_DONE )
    EditName:setInputMode(cc.EDITBOX_INPUT_MODE_SINGLELINE)
    --Handler
    EditName:registerScriptEditBoxHandler(editBoxTextEventHandle)
    ui_widget:addChild(EditName)
    
    --middle
    EditPassword = cc.EditBox:create(editBoxSize, cc.Scale9Sprite:create("res/LoginUI/orange_edit.png"))
    EditPassword:setPosition(cc.p(562,200))


    EditPassword:setFontColor(cc.c3b(0,255,0))
    EditPassword:setPlaceHolder("Password:")
    EditPassword:setMaxLength(6)
--    EditPassword:setInputFlag(cc.EDITBOX_INPUT_FLAG_PASSWORD)
    EditPassword:setInputMode(cc.EDITBOX_INPUT_MODE_SINGLELINE)
    EditPassword:registerScriptEditBoxHandler(editBoxTextEventHandle)
    ui_widget:addChild(EditPassword)

    HTTPRequest()
end
--继承BASELAYER后初始化
local LandSceneLayer = class("LandSceneLayer",BaseLayer)

function LandSceneLayer.extend(target)
    local t = tolua.getpeer(target)
    if not t then
        t = {}
        tolua.setpeer(target, t)
    end
    setmetatable(t, LandSceneLayer)
    return target
end

function LandSceneLayer:onEnter()
    cclog("LandSceneLayer:onEnter")
end

function LandSceneLayer:onExit()
    cclog("LandSceneLayer:onExit")

    local eventDispatcher = self:getEventDispatcher()
    eventDispatcher:removeEventListener(self._listener)
end

function LandSceneLayer:init()
    cclog("LandSceneLayer:init")

end

function LandSceneLayer.create()
    local layer = LandSceneLayer.extend(cc.Layer:create())
    cclog("LandSceneLayer:create")

    if nil ~= layer then
        -- layer:initExtend()
        local function onNodeEvent(event)
            --enterTransitionFinish

            if "enter" == event then
                layer:onEnter()
            elseif "exit" == event then
                layer:onExit()
            end
        end
        layer:registerScriptHandler(onNodeEvent)
    end

    return layer
end


function LandMainLogIn()

    scene = cc.Scene:create()
    if cc.Director:getInstance():getRunningScene() then
        cc.Director:getInstance():replaceScene(scene)
    else
        cc.Director:getInstance():runWithScene(scene)
    end

    local layer = LandSceneLayer.create()
    scene:addChild(layer)
    ui_widget = ccs.GUIReader:getInstance():widgetFromJsonFile("res/LoginUI/LoginUI_1.json")
    layer:addChild(ui_widget)
    
    contact_panel = ui_widget:getChildByName("contact_Panel")
    LandMain()
    
    CreatVersionUpData_Scene(scene) 
    
end

local stageData={id=1,name="日光森林·山谷大门",desc="没有别的道路可以走，这个洞穴也许能穿过这座山，我闻到了闪电的味道",body=6,monsterList={101,102,103,104,105},itemList={106,107,108,109},state=0,starLevel=3}
--    {id=2,name="闪电的味道",desc="没有别的道路可以走，这个洞穴也许能穿过这座山，我闻到了闪电的味道",body=6,monsterList={101,102,103,104,105},itemList={106,107,108,109},state=1,starLevel=1},
--    {id=3,name="迷雾之宫",desc="没有别的道路可以走，这个洞穴也许能穿过这座山，我闻到了闪电的味道",body=6,monsterList={101,102,103,104,105},itemList={106,107,108,109},state=2,starLevel=2},
--    {id=4,name="暗夜城门",desc="没有别的道路可以走，这个洞穴也许能穿过这座山，我闻到了闪电的味道",body=6,monsterList={101,102,103,104,105},itemList={106,107,108,109},state=0,starLevel=3},
--    {id=5,name="冤家路窄",desc="没有别的道路可以走，这个洞穴也许能穿过这座山，我闻到了闪电的味道",body=6,monsterList={101,102,103,104,105},itemList={106,107,108,109},state=1,starLevel=0},
--}
 

local Mainscene
local main_1
local main_2
local main_3
local ui_widget

local function buttonInit()
    local xx =ui_widget:getChildByName("main_Scroll"):getInnerContainer()
    xx:setPositionX(SceneMainOffset)
    --滑动
    
    
--藏宝
    local treasure_btn  = ui_widget:getChildByName("main_Scroll"):getChildByName("treasurePanel"):getChildByName("_btn")
    local treasure_light = ui_widget:getChildByName("main_Scroll"):getChildByName("treasurePanel"):getChildByName("_light")
    local function _tresureTouchEvent(sender,eventType)
        if eventType == ccui.TouchEventType.began then
             treasure_light:setVisible(true)
        elseif eventType == ccui.TouchEventType.moved then
            treasure_light:setVisible(false)
        elseif eventType == ccui.TouchEventType.canceled then
            treasure_light:setVisible(false)
        elseif eventType == ccui.TouchEventType.ended then 
            treasure_light:setVisible(false)
            print("寻宝占矿")
        end
    end
    treasure_btn:addTouchEventListener(_tresureTouchEvent)
    --时光之穴
    
    
    local guard_btn  = ui_widget:getChildByName("main_Scroll"):getChildByName("guardPanel"):getChildByName("_btn")
    local guard_light = ui_widget:getChildByName("main_Scroll"):getChildByName("guardPanel"):getChildByName("_light")
    local function _guardTouchEvent(sender,eventType)
        if eventType == ccui.TouchEventType.began then
            guard_light:setVisible(true)
        elseif eventType == ccui.TouchEventType.moved then
            guard_light:setVisible(false)
        elseif eventType == ccui.TouchEventType.canceled then
            guard_light:setVisible(false)
        elseif eventType == ccui.TouchEventType.ended then 
            guard_light:setVisible(false)
        end
    end
    guard_btn:addTouchEventListener(_guardTouchEvent)
    --邮箱
    local mail_btn  = ui_widget:getChildByName("main_Scroll"):getChildByName("mailPanel"):getChildByName("_btn")
    local mail_light = ui_widget:getChildByName("main_Scroll"):getChildByName("mailPanel"):getChildByName("_light")
    local function _mailTouchEvent(sender,eventType)
        if eventType == ccui.TouchEventType.began then
            mail_light:setVisible(true)
        elseif eventType == ccui.TouchEventType.moved then
            mail_light:setVisible(false)
        elseif eventType == ccui.TouchEventType.canceled then
            mail_light:setVisible(false)
        elseif eventType == ccui.TouchEventType.ended then 
            mail_light:setVisible(false)
            print("邮箱")
--            local xx = MailToolInMain()
--            Mainscene:addChild(xx,102)
            CreatMail_Scene(Mainscene)
        end
    end
    mail_btn:addTouchEventListener(_mailTouchEvent)
    --战役
    local pve_btn  = ui_widget:getChildByName("main_Scroll"):getChildByName("pvePanel"):getChildByName("_btn")
    local pve_light = ui_widget:getChildByName("main_Scroll"):getChildByName("pvePanel"):getChildByName("_light")
    local function _pveTouchEvent(sender,eventType)
        if eventType == ccui.TouchEventType.began then
            pve_light:setVisible(true)
        elseif eventType == ccui.TouchEventType.moved then
            pve_light:setVisible(false)
        elseif eventType == ccui.TouchEventType.canceled then
            pve_light:setVisible(false)
        elseif eventType == ccui.TouchEventType.ended then 
            pve_light:setVisible(false)
--              stageSelectLogIn()   --副本
--            require "src/stg_lua/Stage_output"
            require "src/stg_lua/Stage_start"
            local xx = ccs.GUIReader:getInstance():widgetFromJsonFile("res/Stageselect_UI/StageHeroUI.json")
            ui_widget:addChild(xx,11)
            Stagestart(xx)
            print("战役")
        end
    end
    pve_btn:addTouchEventListener(_pveTouchEvent)
    
    --商人
    local shop_btn  = ui_widget:getChildByName("main_Scroll"):getChildByName("shopPanel"):getChildByName("_btn")
    local shop_light = ui_widget:getChildByName("main_Scroll"):getChildByName("shopPanel"):getChildByName("_light")
    local function _shopTouchEvent(sender,eventType)
        if eventType == ccui.TouchEventType.began then
            shop_light:setVisible(true)
        elseif eventType == ccui.TouchEventType.moved then
            shop_light:setVisible(false)
        elseif eventType == ccui.TouchEventType.canceled then
            shop_light:setVisible(false)
        elseif eventType == ccui.TouchEventType.ended then 
            shop_light:setVisible(false)
            local changeToken = function(_result)   
                print("商人")
                ShopLogInMain()
            end
            SET_CallBack(PACKET_GC_ShopItemList,changeToken)
            CG_HANDLER_ShopItemList(1)  --商店列表
        end
    end
    shop_btn:addTouchEventListener(_shopTouchEvent)
    
    
    
end




local function update(dt) --update
    local xx= ui_widget:getChildByName("main_Scroll"):getInnerContainer()
    main_2:setPositionX(289-xx:getPositionX()*-1*0.25)
    main_3:setPositionX(0-xx:getPositionX()*-1*0.16)
end


--继承BASELAYER后初始化
local LogInSceneLayer = class("LogInSceneLayer",BaseLayer)

function LogInSceneLayer.extend(target)
    local t = tolua.getpeer(target)
    if not t then
        t = {}
        tolua.setpeer(target, t)
    end
    setmetatable(t, LogInSceneLayer)
    return target
end

function LogInSceneLayer:onEnter()
    cclog("LogInSceneLayer:onEnter")
    --按钮初始化
    buttonInit()
    --菜单初始化
    local menuUIinstance = menuUI:createmenuUI("open",false)
    menuUIinstance:setName("menuUIinstance")
    ui_widget:addChild(menuUIinstance,10)
    menuUIinstance:changeData()
    ui_widget:scheduleUpdateWithPriorityLua(update,0)
end

function LogInSceneLayer:onExit()
    cclog("LogInSceneLayer:onExit")

    local xx= ui_widget:getChildByName("main_Scroll"):getInnerContainer()  --滑动位置初始化
    SceneMainOffset = xx:getPositionX()
    local eventDispatcher = self:getEventDispatcher()
    eventDispatcher:removeEventListener(self._listener)
   
    ui_widget:getChildByName("menuUIinstance"):removeFromParent()
end

function LogInSceneLayer:init()
    cclog("LogInSceneLayer:initAAAAAAAAAAAAAAAAAAAAA")
end

function LogInSceneLayer.create()
    local layer = LogInSceneLayer.extend(cc.Layer:create())
    cclog("LogInSceneLayer:create")

    if nil ~= layer then
                layer:init()
        local function onNodeEvent(event)
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


function SceneMainLogIn()
    --runFunc
    local function runFunc()
        local layer = LogInSceneLayer.create()
        Mainscene:addChild(layer)
        ui_widget = ccs.GUIReader:getInstance():widgetFromJsonFile("res/data/mainUI/mainUI_1.json")
        layer:addChild(ui_widget)
        main_2 = ui_widget:getChildByName("mountPanel")
        main_3 = ui_widget:getChildByName("cloudPanel")

--        ui_widget:scheduleUpdateWithPriorityLua(update,0)        
    end
    --run
    local size = cc.Director:getInstance():getVisibleSize()
    local origin = cc.Director:getInstance():getVisibleOrigin()
    Mainscene = cc.Scene:create()
    if cc.Director:getInstance():getRunningScene() then
        if _uisceneStack[table.maxn(_uisceneStack)] ~= "Mainscene" then
            pushUIScene(Mainscene,"Mainscene")
            runFunc()
 
            --
--            local xx = ChatBoxInMain()
--            Mainscene:addChild(xx,102)

            --聊天
            CreatChatTools(Mainscene)
        end
    else
        cc.Director:getInstance():runWithScene(Mainscene)
    end
  
end
 
 


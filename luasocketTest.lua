-------------------------------------
------wangwei 20140728---------------
-------------------------------------


--network
require "src/network/SocketTCP"
require "src/network/PacketManager"--新加的socket接受包 分发管理类 

local SOCKET = require("socket")
local tcp,tcp1
local __succ, __status
local scheduler = cc.Director:getInstance():getScheduler()

local luasocketUILayer = class("luasocketUILayer",BaseLayer)
luasocketUILayer.__index = luasocketUILayer
--此处可以定义需要用到的局部变量
luasocketUILayer._uiLayer = nil
luasocketUILayer._schedulerUpdata = nil
------------------------------------

--自定义方法
function luasocketUILayer:upData( dt )
    
    local self = luasocketUILayer
    cclog("111")

    if nil ~= tcp then

        recvt, sendt, status = SOCKET.select({tcp}, nil, 1)
        print(recvt,sendt,status)
        while #recvt > 0 do
            print("#recvt = "..#recvt)
            local response, receive_status = tcp:receive()
            if receive_status ~= "closed" then
                if response then
                    print(response)
                    recvt, sendt, status = SOCKET.select({tcp}, nil, 1)
                end
            else
                break
            end
        end

        -- SOCKET.select({tcp}},write_able, 1)

        
    end
    
end

function luasocketUILayer:initExtend()
    cclog("luasocketUILayer:initExtend")
    
    --适配
    local _bg = cc.Sprite:create("bbg_snow_road.jpg")
    cclog("ScreenSize.width = "..ScreenSize.width.." ScreenSize.height = "..ScreenSize.height)
    cclog("DesignResolutionSize.width = "..DesignResolutionSize.width.." DesignResolutionSize.height = "..DesignResolutionSize.height)
    _bg:setPosition(DesignResolutionSize.width/2,DesignResolutionSize.height/2)

    local _dat = screenScaleMaker(_bg)

    _bg:setScale(_dat)

    self:addChild(_bg)
    --适配 end

    self:init()

    self._uiLayer = cc.Layer:create()
    self:addChild(self._uiLayer)


    local function SocketTCPinitevent(sender,eventType)

        if eventType == ccui.TouchEventType.began then
            
        elseif eventType == ccui.TouchEventType.moved then
            
        elseif eventType == ccui.TouchEventType.ended then
            
            SocketTCP:init(SOCKET_IP,SOCKET_PORT,false)
            SocketTCP:connect()
            

        elseif eventType == ccui.TouchEventType.canceled then
            
        end
    end    
    local socketInitbutton = ccui.Button:create()
    socketInitbutton:setTouchEnabled(true)
    socketInitbutton:loadTextures("CloseNormal.png", "CloseSelected.png", "")
    socketInitbutton:setPosition(cc.p(300, 200))        
    socketInitbutton:addTouchEventListener(SocketTCPinitevent)
    self._uiLayer:addChild(socketInitbutton)

    local lable = cc.Label:createWithSystemFont("SocketTCP init connect", "Helvetica", 16)
    lable:setPosition(cc.p(300, 170))
    self._uiLayer:addChild(lable)


    local function touchEvent1(sender,eventType)
        
        if eventType == ccui.TouchEventType.began then
            
        elseif eventType == ccui.TouchEventType.moved then
            
        elseif eventType == ccui.TouchEventType.ended then

            local _string = "username"
            local _len = 2+string.len(_string)
            local __pack = string.pack(">HHA", _len, 1,_string)
            SocketTCP:send(__pack)
            
            -- SocketTCP:send("hello my name is wangwei")

        elseif eventType == ccui.TouchEventType.canceled then
            
        end
    end    
    local button1 = ccui.Button:create()
    button1:setTouchEnabled(true)
    button1:loadTextures("CloseNormal.png", "CloseSelected.png", "")
    button1:setPosition(cc.p(500, 300))        
    button1:addTouchEventListener(touchEvent1)
    self._uiLayer:addChild(button1)

    local lable1 = cc.Label:createWithSystemFont("SocketTCP send", "Helvetica", 16)
    lable1:setPosition(cc.p(500, 270))
    self._uiLayer:addChild(lable1)

    local function touchEvent2(sender,eventType)
        
        if eventType == ccui.TouchEventType.began then
            
        elseif eventType == ccui.TouchEventType.moved then
            
        elseif eventType == ccui.TouchEventType.ended then
            -- CreateAndReplaceScene(GAME_SCENE_SIGNIN)
            
         --   local _p = PacketManager.createEmptyPacket()
--            _p.packetId = 1

          --  local _p1 = PacketManager.createEmptyPacket()
          --  _p1.packetId = 1111

           -- PacketManager:addPacket(_p)
          --  PacketManager:addPacket(_p1)

          --  PacketManager:dispatchPacket()


        elseif eventType == ccui.TouchEventType.canceled then
            
        end
    end    
    local button2 = ccui.Button:create()
    button2:setTouchEnabled(true)
    button2:loadTextures("CloseNormal.png", "CloseSelected.png", "")
    button2:setPosition(cc.p(700, 300))        
    button2:addTouchEventListener(touchEvent2)
    self._uiLayer:addChild(button2)

    local lable2 = cc.Label:createWithSystemFont("PacketManager test", "Helvetica", 16)
    lable2:setPosition(cc.p(700, 270))
    self._uiLayer:addChild(lable2)


--test CGConnect
    local function testCGConnect(sender,eventType)
        
        if eventType == ccui.TouchEventType.began then
            
        elseif eventType == ccui.TouchEventType.moved then
            
        elseif eventType == ccui.TouchEventType.ended then

            -- local _string = "username"
            -- local _len = 2+string.len(_string)
            -- local __pack = string.pack(">HHA", _len, 1,_string)
            
            -- local __t = CGConnectCreate()
            -- local _accid = 60305
            -- local _tstemp = 20258
            -- local _accname = "user450"
            -- local _ticket = md5String(_accid.._accname.._tstemp.."SDFSDESF123DFSDF")
            
            -- __t._PackData:init(_accid,_tstemp,_accname,_ticket)

            -- local _ = __t._PackData
            -- print(_._letterCodes,_._len,_.cmdid,_._accid,_._tstemp,string.len(_._accname) , _._accname,string.len(_._ticket) , _._ticket)
            
            -- SocketTCP:send(__t._PackData:getPack())

            local infolist={60305,20258,"user450"}
            CG_HANDLER(PACKET_CG_Connect,infolist)
            
            -- SocketTCP:send("hello my name is wangwei")

        elseif eventType == ccui.TouchEventType.canceled then
            
        end
    end    
    local buttonCGConnect = ccui.Button:create()
    buttonCGConnect:setTouchEnabled(true)
    buttonCGConnect:loadTextures("CloseNormal.png", "CloseSelected.png", "")
    buttonCGConnect:setPosition(cc.p(100, 500))        
    buttonCGConnect:addTouchEventListener(testCGConnect)
    self._uiLayer:addChild(buttonCGConnect)

    local lableCGConnect = cc.Label:createWithSystemFont("CGConnect", "Helvetica", 16)
    lableCGConnect:setPosition(cc.p(100, 470))
    self._uiLayer:addChild(lableCGConnect)

--test CGLoginGame
    local function testCGLoginGame(sender,eventType)
        
        if eventType == ccui.TouchEventType.began then
            
        elseif eventType == ccui.TouchEventType.moved then
            
        elseif eventType == ccui.TouchEventType.ended then

            -- local _string = "username"
            -- local _len = 2+string.len(_string)
            -- local __pack = string.pack(">HHA", _len, 1,_string)
            
            -- if NETWORD_GUID ~= 0 then
            --     local __t = CGLoginGameCreate()
            
            
            --     __t._PackData:init(NETWORD_GUID)

            --     local _ = __t._PackData
        
                
            --     SocketTCP:send(__t._PackData:getPack())
            -- end
            CG_HANDLER(PACKET_CG_LoginGame)

            -- SocketTCP:send("hello my name is wangwei")

        elseif eventType == ccui.TouchEventType.canceled then
            
        end
    end    
    local buttonCGLoginGame = ccui.Button:create()
    buttonCGLoginGame:setTouchEnabled(true)
    buttonCGLoginGame:loadTextures("CloseNormal.png", "CloseSelected.png", "")
    buttonCGLoginGame:setPosition(cc.p(100, 400))        
    buttonCGLoginGame:addTouchEventListener(testCGLoginGame)
    self._uiLayer:addChild(buttonCGLoginGame)

    local lableCGLoginGame = cc.Label:createWithSystemFont("CGLoginGame", "Helvetica", 16)
    lableCGLoginGame:setPosition(cc.p(100, 370))
    self._uiLayer:addChild(lableCGLoginGame)

--test GCBagList
    local function testCGBagList(sender,eventType)
        
        if eventType == ccui.TouchEventType.began then
            
        elseif eventType == ccui.TouchEventType.moved then
            
        elseif eventType == ccui.TouchEventType.ended then

            -- local _string = "username"
            -- local _len = 2+string.len(_string)
            -- local __pack = string.pack(">HHA", _len, 1,_string)
            
            -- local __t = CGBagListCreate()
            
            
            -- __t._PackData:init()

            -- local _ = __t._PackData
    
            
            -- SocketTCP:send(__t._PackData:getPack())
            CG_HANDLER(PACKET_CG_BagList)
            
            -- SocketTCP:send("hello my name is wangwei")

        elseif eventType == ccui.TouchEventType.canceled then
            
        end
    end    
    local buttonCGBagList = ccui.Button:create()
    buttonCGBagList:setTouchEnabled(true)
    buttonCGBagList:loadTextures("CloseNormal.png", "CloseSelected.png", "")
    buttonCGBagList:setPosition(cc.p(100, 300))        
    buttonCGBagList:addTouchEventListener(testCGBagList)
    self._uiLayer:addChild(buttonCGBagList)

    local lableCGBagList = cc.Label:createWithSystemFont("CGBagList", "Helvetica", 16)
    lableCGBagList:setPosition(cc.p(100, 270))
    self._uiLayer:addChild(lableCGBagList)
--test CGChat
    local function testCGChat(sender,eventType)
        
        if eventType == ccui.TouchEventType.began then
            
        elseif eventType == ccui.TouchEventType.moved then
            
        elseif eventType == ccui.TouchEventType.ended then

            -- local _string = "username"
            -- local _len = 2+string.len(_string)
            -- local __pack = string.pack(">HHA", _len, 1,_string)
            
            local __t = CGChatCreate()
            
            
            __t._PackData:init(1,"你好world!!！")

            local _ = __t._PackData
    
            
            SocketTCP:send(__t._PackData:getPack())
            
            -- SocketTCP:send("hello my name is wangwei")

        elseif eventType == ccui.TouchEventType.canceled then
            
        end
    end    
    local buttonCGChat = ccui.Button:create()
    buttonCGChat:setTouchEnabled(true)
    buttonCGChat:loadTextures("CloseNormal.png", "CloseSelected.png", "")
    buttonCGChat:setPosition(cc.p(200, 500))        
    buttonCGChat:addTouchEventListener(testCGChat)
    self._uiLayer:addChild(buttonCGChat)

    local lableCGChat = cc.Label:createWithSystemFont("CGChat", "Helvetica", 16)
    lableCGChat:setPosition(cc.p(200, 470))
    self._uiLayer:addChild(lableCGChat)
--test CGHeartBeat
    local function testCGHeartBeat(sender,eventType)
        
        if eventType == ccui.TouchEventType.began then
            
        elseif eventType == ccui.TouchEventType.moved then
            
        elseif eventType == ccui.TouchEventType.ended then

            -- local _string = "username"
            -- local _len = 2+string.len(_string)
            -- local __pack = string.pack(">HHA", _len, 1,_string)
            
            local __t = CGHeartBeatCreate()
            
            
            __t._PackData:init()

            local _ = __t._PackData
    
            
            SocketTCP:send(__t._PackData:getPack())
            
            -- SocketTCP:send("hello my name is wangwei")

        elseif eventType == ccui.TouchEventType.canceled then
            
        end
    end    
    local buttonCGHeartBeat = ccui.Button:create()
    buttonCGHeartBeat:setTouchEnabled(true)
    buttonCGHeartBeat:loadTextures("CloseNormal.png", "CloseSelected.png", "")
    buttonCGHeartBeat:setPosition(cc.p(200, 400))        
    buttonCGHeartBeat:addTouchEventListener(testCGHeartBeat)
    self._uiLayer:addChild(buttonCGHeartBeat)

    local lableCGHeartBeat = cc.Label:createWithSystemFont("CGHeartBeat", "Helvetica", 16)
    lableCGHeartBeat:setPosition(cc.p(200, 370))
    self._uiLayer:addChild(lableCGHeartBeat)
end 

------------------------------------

------------------------------------
--重写父类方法

function luasocketUILayer:setPriority(fixedPriority)
    self._fixedPriority = fixedPriority
end

function luasocketUILayer.extend(target)
    local t = tolua.getpeer(target)
    if not t then
        t = {}
        tolua.setpeer(target, t)
    end
    setmetatable(t, luasocketUILayer)
    return target
end

function luasocketUILayer:onEnter()
    cclog("luasocketUILayer:onEnter")

------------------------------------
    local function onTouchBegan(touch, event)
        --return true 吞噬
        --return false 下放(不走本身的 onTouchMoved onTouchEnded)

        cclog("luasocketUILayer:onTouchBegan")
        -- local target = event:getCurrentTarget()
        -- local locationInNode = target:convertToNodeSpace(touch:getLocation())
        -- local s = target:getContentSize()
        -- local rect = cc.rect(0, 0, s.width, s.height)
        
        -- if cc.rectContainsPoint(rect, locationInNode) then
        --     print(string.format("sprite began... x = %f, y = %f", locationInNode.x, locationInNode.y))
        --     target:setOpacity(180)
        --     return true
        -- end
        return true
    end

    local function onTouchMoved(touch, event)
        cclog("luasocketUILayer:onTouchMoved")
        -- local target = event:getCurrentTarget()
        -- local posX,posY = target:getPosition()
        -- local delta = touch:getDelta()
        -- target:setPosition(cc.p(posX + delta.x, posY + delta.y))
    end

    local function onTouchEnded(touch, event)
        cclog("luasocketUILayer:onTouchEnded")
        -- local target = event:getCurrentTarget()
        -- print("sprite onTouchesEnded..")
        -- target:setOpacity(255)
        -- if target == sprite2 then
        --     sprite1:setLocalZOrder(100)
        -- elseif target == sprite1 then
        --     sprite1:setLocalZOrder(0) 
        -- end
    end

    local touchListener = cc.EventListenerTouchOneByOne:create()
    self._listener = touchListener
    touchListener:setSwallowTouches(true)
    touchListener:registerScriptHandler(onTouchBegan, cc.Handler.EVENT_TOUCH_BEGAN) 
    touchListener:registerScriptHandler(onTouchMoved, cc.Handler.EVENT_TOUCH_MOVED) 
    touchListener:registerScriptHandler(onTouchEnded, cc.Handler.EVENT_TOUCH_ENDED)
    local eventDispatcher = self:getEventDispatcher()

    if 0 == self._fixedPriority then
        eventDispatcher:addEventListenerWithSceneGraphPriority(touchListener, self)
    else
        eventDispatcher:addEventListenerWithFixedPriority(touchListener,self._fixedPriority)
    end
------------------------------------
    -- self._schedulerUpdata = scheduler:scheduleScriptFunc(self.upData, 10, false)
end

function luasocketUILayer:onExit()
    cclog("luasocketUILayer:onExit")

    local eventDispatcher = self:getEventDispatcher()
    eventDispatcher:removeEventListener(self._listener)

    -- cc.Director:getInstance():getTextureCache():removeUnusedTextures()

end

function luasocketUILayer:init()
    cclog("luasocketUILayer:init")

end

function luasocketUILayer.create()
    local layer = luasocketUILayer.extend(cc.Layer:create())
    cclog("luasocketUILayer:create")

    if nil ~= layer then
        layer:initExtend()
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










-------------------------------------
--luasocketTest
-------------------------------------
function luasocketTestMain()
	cclog("luasocketTestMain")
	local scene = cc.Scene:create()

    local _uilayer = luasocketUILayer.create()
    _uilayer:setPriority(0)
    scene:addChild(_uilayer)


	return scene
end




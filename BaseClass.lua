-------------------------------------
------wangwei 20140702---------------
-------------------------------------

---------BaseLayer--------------------------------------------
BaseLayer = class("BaseLayer")
BaseLayer.__index = BaseLayer
BaseLayer._fixedPriority = 0
BaseLayer._listener = nil
--以下方法均可以在自定义类中重写
function BaseLayer.extend(target)
    local t = tolua.getpeer(target)
    if not t then
        t = {}
        tolua.setpeer(target, t)
    end
    setmetatable(t, BaseLayer)
    return target
end

function BaseLayer:setPriority(fixedPriority)
    self._fixedPriority = fixedPriority
end

function BaseLayer:onEnter()
    cclog("BaseLayer:onEnter")


------------------------------------
--touch 注册
    local function onTouchBegan(touch, event)
        --return true 吞噬
        --return false 下放(不走本身的 onTouchMoved onTouchEnded)
        cclog("BaseLayer:onTouchBegan")
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
        cclog("BaseLayer:onTouchMoved")
        -- local target = event:getCurrentTarget()
        -- local posX,posY = target:getPosition()
        -- local delta = touch:getDelta()
        -- target:setPosition(cc.p(posX + delta.x, posY + delta.y))
    end

    local function onTouchEnded(touch, event)
        cclog("BaseLayer:onTouchEnded")
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

end

function BaseLayer:onExit()
    cclog("BaseLayer:onExit")
    local eventDispatcher = self:getEventDispatcher()
    eventDispatcher:removeEventListener(self._listener)
end

function BaseLayer:init()
    cclog("BaseLayer:init")

end

function BaseLayer.create()
    local layer = BaseLayer.extend(cc.Layer:create())
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
-----------------------------------------------------------------


---------BaseData--------------------------------------------


BaseData = {}; 
BaseData.new = function(self) 
    local o = { --可以在此处添加数据
            }; 
    setmetatable(o,self); 
    self.__index = self; 
    return o; 
end


-----------------------------------------------------------------




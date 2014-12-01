require "src/HeroUI/SoulstonePanel"
local heroObj
local soulSum
local soulNum
local jinhuaPanel
function updateJinhua()
    local jdProgressBar = jinhuaPanel:getChildByName("jh_ProgressBar")
    local textLabel = jdProgressBar:getChildByName("jh_label")
    --自己有用的灵魂石个数
    soulNum = getBagNumById(heroObj._heroData.soulID)
    if heroObj._heroData.starlvl ==1 then
        textLabel:setString(soulNum.."/"..20)
        soulSum=20
    elseif heroObj._heroData.starlvl == 2 then
        textLabel:setString(soulNum.."/"..50)
        soulSum=50
    elseif heroObj._heroData.starlvl == 3 then
        textLabel:setString(soulNum.."/"..100)
        soulSum=100
    elseif heroObj._heroData.starlvl == 4 then
        textLabel:setString(soulNum.."/"..150)
        soulSum=150
    else
        textLabel:setString("已进化至顶级")
    end
    ----

    if heroObj._heroData.starlvl ~= 5 then
        if soulNum>=soulSum then
            jdProgressBar:setPercent(100)
        else
            jdProgressBar:setPercent((soulNum/soulSum)*100)
        end
    else
        jdProgressBar:setPercent(100)
    end
end

function HeroJinhua(_jinhuaPanel,_heroObj)
    heroObj = _heroObj
    jinhuaPanel = _jinhuaPanel
    --1.关闭按钮
    local close_btn=jinhuaPanel:getChildByName("close_btn")
    local function _closeEvent(sender,eventType)
        local _button = sender
        if eventType == ccui.TouchEventType.began then
        elseif eventType == ccui.TouchEventType.moved then
        --移动按钮没有操作
        elseif eventType == ccui.TouchEventType.canceled then   

        elseif eventType == ccui.TouchEventType.ended then     --end之后的回调
            jinhuaPanel:setVisible(false)
            heroInfoInit()
        end
    end  
    close_btn:addTouchEventListener(_closeEvent)
   
    --3.英雄名字
    local hroname_fra=jinhuaPanel:getChildByName("hroname_fra") --英雄名字
    hroname_fra:setString(heroObj._heroData.roleName)
    
    
    local jdProgressBar = jinhuaPanel:getChildByName("jh_ProgressBar")
    local textLabel = jdProgressBar:getChildByName("jh_label")
    
    --自己有用的灵魂石个数
    soulNum = getBagNumById(heroObj._heroData.soulID)
    if heroObj._heroData.starlvl ==1 then
        textLabel:setString(soulNum.."/"..20)
        soulSum=20
    elseif heroObj._heroData.starlvl == 2 then
        textLabel:setString(soulNum.."/"..50)
        soulSum=50
    elseif heroObj._heroData.starlvl == 3 then
        textLabel:setString(soulNum.."/"..100)
        soulSum=100
    elseif heroObj._heroData.starlvl == 4 then
        textLabel:setString(soulNum.."/"..150)
        soulSum=150
    else
        textLabel:setString("已进化至顶级")
    end
    --4 进度条
    
    

    if heroObj._heroData.starlvl ~= 5 then
        if soulNum>=soulSum then
            jdProgressBar:setPercent(100)
        else
            jdProgressBar:setPercent((soulNum/soulSum)*100)
        end
    else
        jdProgressBar:setPercent(100)
    end
    
    
    --4 灵魂石获取来源
    local jbBtn = jinhuaPanel:getChildByName("jh_btn")
    local function _jbEvent(sender,eventType)
        local _button = sender
        if eventType == ccui.TouchEventType.began then
        elseif eventType == ccui.TouchEventType.moved then
        --移动按钮没有操作
        elseif eventType == ccui.TouchEventType.canceled then   

        elseif eventType == ccui.TouchEventType.ended then     --end之后的回调
            if heroObj._heroData.starlvl < 5 then
                
                SoulstonePanel(jinhuaPanel:getParent():getChildByName("soulstone_panel"),heroObj,soulNum,soulSum)
            end
        end
    end  
    jbBtn:addTouchEventListener(_jbEvent)
    
    --2.确认按钮
    local confirm_btn=jinhuaPanel:getChildByName("confirm_btn")
    local function _confirmEvent(sender,eventType)
        local _button = sender
        if eventType == ccui.TouchEventType.began then
            _button:setScale(0.9)
        elseif eventType == ccui.TouchEventType.moved then
            _button:setScale(0.9)
        elseif eventType == ccui.TouchEventType.canceled then   
            _button:setScale(1)
        elseif eventType == ccui.TouchEventType.ended then     --end之后的回调
            _button:setScale(1)
            --
            if heroObj._heroData.starlvl<5 and soulNum>=soulSum then
                addDataToBag(heroObj._heroData.soulID,-soulSum)
                soulNum = getBagNumById(heroObj._heroData.soulID)
                heroObj._heroData.starlvl = heroObj._heroData.starlvl+1
                updateJinhua()
            else
                print("不足")
            end
        end
    end  
    confirm_btn:addTouchEventListener(_confirmEvent)
end
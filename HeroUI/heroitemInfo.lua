require "src/HeroUI/HeroItemPanel"
local RichLabel = require "src/HeroUI/RichLabel"
local ui_widget
local nameArr = {"攻击力","护甲","吸血","魔法抗性","生命力","能量恢复","生命恢复","力量","敏捷","智力","攻击速度","物理闪避","力量，敏捷，智力"}


--获取装备框强化的概率
local function getStengthLv(lv,frameId)
    local lvData = frameStrengthData[lv]
    local result = lvData["sthPer"..frameId]/100
    return result
end

function heroItmInfo(hro_item_panel,_heroObj,framID)
    ui_widget = hro_item_panel
    --1 --强化等级
    if _heroObj._heroData["itemfra"..framID] ~= nil then
        local itemQHlvl = ui_widget:getChildByName("qhlvl_label1") --强化等级
        itemQHlvl:setString(_heroObj._heroData["itemfralvl"..framID])
    end
    --2 .属性强化
    if _heroObj._heroData["itemfra"..framID] ~= nil then
        local itemSHqh = ui_widget:getChildByName("qhlvl_label2") --属性强化
    end
    --3.道具名字以及图标
    local itemFrame = ui_widget:getChildByName("itemFrame")
    itemFrame:removeAllChildren()
    if _heroObj._heroData["itemfra"..framID] ~= nil then
        local result = getTestDataById(_heroObj._heroData["itemfra"..framID])
        
        local xx = ccui.ImageView:create("res/daota/"..result._itemData.iIcon..".jpg")
        xx:setEnabled(false)
        itemFrame:addChild(xx)
        xx:setPosition(cc.p(itemFrame:getContentSize().width/2,itemFrame:getContentSize().height/2+2))
        xx:setScale(94/78)
    
        local itemName = ui_widget:getChildByName("skill_name")
        itemName:setString(result._itemData.iName)
        
        --属性
        local descInfoView = ui_widget:getChildByName("descInfoView")
        descInfoView:removeAllItems()
        --橙色 FFC79A05 装备框升级了展示橙色
        --绿色 FF1EB007 装备框未升级展示颜色
        for i=1,5,1 do
            local attrType = result._itemData["attrType"..i]
            if attrType ~= "null" and attrType ~= 0  then
                local name = nameArr[attrType]
                local lv = math.random(30,60)
                local bb = getStengthLv(lv,i)
                local value = result._itemData["attr"..i]
                local targetText
                local one,two = math.modf(value*bb*10)
                if lv >1 then
                    targetText = "[fontColor=f75d85 fontSize=20]"..name.."[/fontColor]".."[fontColor=FFC79A05 fontSize=20]+"..(value+one/10).."[/fontColor]"
                else
                    targetText = "[fontColor=f75d85 fontSize=20]"..name.."[/fontColor]".."[fontColor=FF1EB007 fontSize=20]+"..value.."[/fontColor]"
                end
                
                local params = {
                    text = targetText,
                    dimensions = cc.size(400, 200)
                }
                local testLabel = RichLabel:create(params)
                local layout = ccui.Layout:create()
                layout:setSize(cc.size(400,30))
                layout:addChild(testLabel)
                testLabel:setPosition(cc.p(5,30))
                descInfoView:pushBackCustomItem(layout)
            end
        end
        
    end
    --4，更换装备
    local changeItem_btn = hro_item_panel:getChildByName("genghuan_btn")
    local function _jinjieEvent(sender,eventType)
        local _button = sender
        --        cclog("tag====".. _button:getTag()) 
        if eventType == ccui.TouchEventType.began then
 
        elseif eventType == ccui.TouchEventType.moved then
        --移动按钮没有操作
        elseif eventType == ccui.TouchEventType.canceled then   
            
        elseif eventType == ccui.TouchEventType.ended then     --end之后的回调
            local xx = ccs.GUIReader:getInstance():widgetFromJsonFile("res/HeroSceneUI/HeroItem.json")
            cc.Director:getInstance():getRunningScene():addChild(xx,10)
                HeroItemPanel(xx,hro_item_panel,_heroObj,framID)
        end
    end  
    changeItem_btn:addTouchEventListener(_jinjieEvent)
 end
 

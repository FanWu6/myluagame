local ccsReader 
local ui_widget
local _stageData
local function buttonInit()
    local close_btn = ui_widget:getChildByTag(763)
     local function _closetouchEvent(sender,eventType)
        if eventType == ccui.TouchEventType.began then
            sender:setScale(0.9)
        elseif eventType == ccui.TouchEventType.moved then
        --移动按钮没有操作
        elseif eventType == ccui.TouchEventType.canceled then
            sender:setScale(1.0)
        elseif eventType == ccui.TouchEventType.ended then
                local function close()
                ccsReader:removeFromParent()
                end
            local scale1 = cc.ScaleTo:create(0.3,0)
            local scale_ease1 = cc.EaseBackIn:create(scale1)
            print("xx")
            --添加物品到背包
            for i=1,table.maxn(_stageData.itemList),1 do
                local currItemData = getTestDataById(_stageData.itemList[i])
                addDataToBag(currItemData._itemData.iId,currItemData._itemData.iNum)
            end
            changeUserDateGold(_stageData.gold,1)
            changeUserDataExp(_stageData.exp,1)
            
            ui_widget:runAction(cc.Sequence:create(scale_ease1,cc.CallFunc:create(close)))
           
            
        end
     end
    close_btn:addTouchEventListener(_closetouchEvent)
end

function StageOutPut(uiPanel,stageId,level,type)
    ccsReader = ccs.GUIReader:getInstance():widgetFromJsonFile("res/Stageselect_UI/StageOutput_UI.json")
    uiPanel:addChild(ccsReader,11)
    ui_widget=ccsReader:getChildByName("saodang_Panel"):getChildByName("sd_bg")
    ui_widget:setScale(0,0)
    
    local scale1 = cc.ScaleTo:create(0.3,1)
    local scale_ease1 = cc.EaseBackOut:create(scale1)
    ui_widget:runAction(scale_ease1)
    local scrollPanel =  ui_widget:getChildByName("sd_scroll")
    local targetPanel = scrollPanel:getChildByName("rewardPanel")
    
    _stageData = getStageDataById(stageId,level,type)
    
    local numText = targetPanel:getChildByName("battle_title"):getChildByName("battle_num")
    local goldText = targetPanel:getChildByName("gold_num")
    local expText = targetPanel:getChildByName("EXP_num")
    goldText:setString(_stageData.gold)
    numText:setString("第1次")
    expText:setString(_stageData.exp)
    local itemList = _stageData.itemList
    local line = 0;
    for i=1,table.maxn(itemList),1 do
        local itemId = itemList[i]
        print("id==="..itemId)
        local itemData = getTestDataById(itemId)
        local fragment,frag = ToolsgetItemIcon(itemData._itemData.iType,itemData._itemData.iTone)
        
        
        local item_frame = ccui.ImageView:create()
        local  maskedCal = maskedHeroWithSprite("res/daota/"..itemData._itemData.iIcon, fragment, frag,itemData._itemData.iNum)
        item_frame:addChild(maskedCal)
        local xNum = 80+(i-1)*100
        local yNum = 300
        if xNum>480  then
            line =1 + math.floor((i-1)/5)
            xNum = 80+((i-1)-(line-1)*5)*100
            yNum = 300-(80*(line-1)+10)
        end
        maskedCal:setPosition(xNum,yNum)
        targetPanel:addChild(item_frame)
        
    end
    
    buttonInit()
end

return ui_widget
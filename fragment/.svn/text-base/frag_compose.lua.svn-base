require("src/fragment/fragment_main")


local _composeLayer
local _composeData
local _container
local _currNum = 1
local _maxNum = 1

--更新界面
local function updateFragCompose()
    --物品拥有的个数
    local myNum = _container:getChildByName("frag_num")
    local bagNum = getBagNumById(_composeData.iId)
    myNum:setString(bagNum)
    --合成需要的个数
    local targetNum = _container:getChildByName("frag_compose_num")
    targetNum:setString("/".._composeData.iComposeTargetNum)

    --r g b 237 15 4  少于合成的数量
    --r g b 252 122 5 大于合成的数量
    --设置颜色
    if bagNum >= _composeData.iComposeTargetNum then
        myNum:setColor(cc.c3b(252,255,2555))
    else
        myNum:setColor(cc.c3b(237,15,4))
    end
    
    --获取最多可合成的个数
    _maxNum =math.floor(bagNum/_composeData.iComposeTargetNum)

    local itemComposeNum = _container:getChildByName("item_compose_num")

    local itemCompseSum = _container:getChildByName("item_compose_sum")
    _currNum = 1
    --设置合成颜色
    if _maxNum >= 1 then
        itemComposeNum:setColor(cc.c3b(255,255,255))
        itemComposeNum:setString("1")
        itemCompseSum:setColor(cc.c3b(255,255,255))
        itemCompseSum:setString("/".._maxNum)
    else
        itemComposeNum:setColor(cc.c3b(237,15,4))
        itemComposeNum:setString("0")
        itemCompseSum:setColor(cc.c3b(237,15,4))
        itemCompseSum:setString("/0")
    end

    _currNum = 1
    
    local targetItem = getBagDataById(_composeData.iComposeTargetStr)
    local composeGold = _container:getChildByName("composegold")
    composeGold:setString(targetItem.iMcostPay*_currNum)

end


local function buttonInit(currPage)

    local function easeAciton()
        _composeLayer:setVisible(false)
        _composeLayer:setEnabled(false)
    end
    
    local function closeTouchHandle(sender,eventType)
        local _button = sender
        if eventType == ccui.TouchEventType.ended then
            local scale1 = cc.ScaleTo:create(0.3,0)
            local scale_ease1 = cc.EaseBackIn:create(scale1)
            -- 播放动作
            local seq2 = cc.Sequence:create(scale_ease1,cc.CallFunc:create(easeAciton))
            _container:runAction(seq2)
        end
    end
    
    local closeBtn = _container:getChildByName("btn_close")
    closeBtn:addTouchEventListener(closeTouchHandle)
    
    --合成
    local function composeTouchHandle(sender,eventType)
        local _button = sender
        if eventType == ccui.TouchEventType.ended then
            --出售操作
           cclog("修改数据，减少碎片个数，添加一个新道具")
            local itemComposeNum = _container:getChildByName("item_compose_num")
            local composeNum = tonumber(itemComposeNum:getString())
            local num =  getBagNumById(_composeData.iId)
            if num >=_composeData.iComposeTargetNum and composeNum >0 then
                --更改数据
                addDataToBag(_composeData.iComposeTargetStr,composeNum)
                addDataToBag(_composeData.iId,-(tonumber(_composeData.iComposeTargetNum * composeNum)))
                updateDetailPanel(_composeData,1)
                local iName = _composeData.iName
                
                if num - tonumber(_composeData.iComposeTargetNum*composeNum) == 0 then
                    fragment_scrollInit_change("delete",currPage,iName,nil)
                else
                    fragment_scrollInit_change("change",currPage,iName,(num - (tonumber(_composeData.iComposeTargetNum * composeNum))))
                end
            end
            updateFragCompose()
        end
    end
    
    local composeBtn = _container:getChildByName("btn_compose")
    composeBtn:addTouchEventListener(composeTouchHandle)
    
    --减少一个
    local function minusButtonTouchHandle(sender,eventType)
        local _button = sender
        if eventType == ccui.TouchEventType.ended then
            if _currNum >1 then
                local itemComposeNum = _container:getChildByName("item_compose_num")
                _currNum = _currNum - 1
                itemComposeNum:setString(_currNum)
                local composeGold = _container:getChildByName("composegold")
                local targetItem = getBagDataById(_composeData.iComposeTargetStr)
                composeGold:setString(targetItem.iMcostPay*_currNum)
            end
        end
    
    end
    local minusButton = _container:getChildByName("minus_button")
    minusButton:addTouchEventListener(minusButtonTouchHandle)


    --增加一个
    local function plusButtonTouchHandle(sender,eventType)
        local _button = sender
        if eventType == ccui.TouchEventType.ended then
            if _currNum < _maxNum then
                local itemComposeNum = _container:getChildByName("item_compose_num")
                _currNum = _currNum + 1
                itemComposeNum:setString(_currNum)
                local composeGold = _container:getChildByName("composegold")
                local targetItem = getBagDataById(_composeData.iComposeTargetStr)
                composeGold:setString(targetItem.iMcostPay*_currNum)
            end
        end

    end
    local plusButton = _container:getChildByName("plus_button")
    plusButton:addTouchEventListener(plusButtonTouchHandle)
    
    --最大
    local function maxButtonTouchHandle(sender,eventType)
        local _button = sender
        if eventType == ccui.TouchEventType.ended then
            local itemComposeNum = _container:getChildByName("item_compose_num")
            _currNum = _maxNum
            itemComposeNum:setString(_currNum)
            local composeGold = _container:getChildByName("composegold")
            local targetItem = getBagDataById(_composeData.iComposeTargetStr)
            composeGold:setString(targetItem.iMcostPay*_currNum)
        end

    end
    local maxButton = _container:getChildByName("max_button")
    maxButton:addTouchEventListener(maxButtonTouchHandle)
    
end


function fragComposeInit(composeLayer,compseData,currPage)

    _composeLayer = composeLayer
    _composeData = compseData
    _container = _composeLayer:getChildByName("item_container")
    _container:setScale(0)
    _container:setAnchorPoint(cc.p(0.5,0.5))
    _container:setPosition(cc.p(1136/2,640/2))
    composeLayer:setVisible(true)
    composeLayer:setEnabled(true)
    
    local scale1 = cc.ScaleTo:create(0.3,1)
    local scale_ease1 = cc.EaseBackOut:create(scale1)
    -- 播放动作
    local seq2 = cc.Sequence:create(scale_ease1)
    _container:runAction(seq2)
    
    local frament1,frag1 = ToolsgetItemIcon(_composeData.iType,_composeData.iTone)
    
    --名字
    local item_name = _container:getChildByName("compose_title")
    item_name:setString(_composeData.iName)

    --图标
    local item_frame = _container:getChildByName("item_frame")
    local  maskedCal = maskedHeroWithSprite("res/daota/".._composeData.iIcon, frament1, frag1)
    item_frame:addChild(maskedCal)
    maskedCal:setPosition(cc.p(item_frame:getSize().width/2,item_frame:getSize().height/2))
    
    --碎片标记
    local sign = cc.Sprite:create("res/HeroSceneUI/star_yellow.png")
    item_frame:addChild(sign)
    sign:setPosition(cc.p(item_frame:getContentSize().width/2+33,-15))
    
    --合成的目标  图标  
    local fragment2,frag2 = ToolsgetItemIcon(_composeData.iSmallType,_composeData.iTone)
    local item_frame1 = _container:getChildByName("item_image")
    
    local composeTarget = getTestDataById(_composeData.iComposeTargetStr)
    local  maskedCal1 = maskedHeroWithSprite("res/daota/"..(composeTarget._itemData.iIcon), fragment2, frag2)
    item_frame1:addChild(maskedCal1)
    maskedCal1:setPosition(cc.p(item_frame:getSize().width/2,item_frame:getSize().height/2))
    
    --合成目标 名字
    local targetName = _container:getChildByName("item_name")
    targetName:setString(composeTarget._itemData.iName)
    
    --标题
    local item_name = _container:getChildByName("compose_title")
    item_name:setString("合成"..composeTarget._itemData.iName)
    --更新界面
    updateFragCompose()
    --按钮
    buttonInit(currPage)
    
end
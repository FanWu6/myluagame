local shopBuyPanel
local _itemId
local MenuUIinstance
local function closeBuyPanel(send,eventType)
    shopBuyPanel:setVisible(false)
    shopBuyPanel:setEnabled(false)
end

local function buyItem(send,eventType)
    local _button = sender
    if eventType == ccui.TouchEventType.ended then --end
    local function runFuc()
       shopBuyPanel:setVisible(false)
        shopBuyPanel:setEnabled(false)
        addImageToBtn(_itemId)--添加遮罩
--        changeShopDataByKeyId(_itemId,"iState",1)
        print("aassdd")
        --
--       MenuUIinstance:changeData()
    end
    
       --添加数据   
--       local insertData = getShopDataById(_itemId)
--       addDataToBag(_itemId,insertData.iNum)   
       --修改团队数据  
--       if _itemId%2 == 0  then
--            local boolvalue = changeUserDataToken(insertData.iBuyJewel,2)
--            if boolvalue then
--                runFuc()
--            end
--       else
--            local boolvalue = changeUserDateGold(insertData.iSellPrice,2)
--            if boolvalue then
--                runFuc()
--            end

        local changeToken = function(_result)   
           if _result == 10000 then
                shopBuyPanel:setVisible(false)
                shopBuyPanel:setEnabled(false)
                addImageToBtn(_itemId)--添加遮罩
                --        changeShopDataByKeyId(_itemId,"iState",1)
                MenuUIinstance:changeData()
           else
                PacketManager.errorcode(_result)
                print("其他命令")
           end
        end
        SET_CallBack(PACKET_GC_ShopBuyItem,changeToken)
        CG_HANDLER_ShopBuyItem(_itemId,1)
        print("编号------=======".._itemId)
--            runFuc()
--       end
       --
       
    end
    
    --添加
end

function openBuyPanel(shopBuy,itemId,_menuUIinstance)
    shopBuyPanel = shopBuy
    MenuUIinstance = _menuUIinstance
    local sellPanel = shopBuy:getChildByName("sellPanel") 
    _itemId = itemId
    local item = getShopDataById(itemId)

    local nameText = sellPanel:getChildByName("itemName")
    local myItemNum = sellPanel:getChildByName("myItemNum")
    local itemDesc = sellPanel:getChildByName("itemDesc")
    local itemNum = sellPanel:getChildByName("itemNum")
    local moneyText = sellPanel:getChildByName("moneyText")
    local closeBtn = sellPanel:getChildByName("closeBtn")
    local buyBtn = sellPanel:getChildByName("buyBtn")
    local goldIcon = sellPanel:getChildByName("goldIcon")
    local itemDetail = sellPanel:getChildByName("item_detail")
    local itemDetailBg = sellPanel:getChildByName("itemDetailBg")

    nameText:setString(item.iName)
    itemNum:setString(item.iNum)
    moneyText:setString(item.iSellPrice)
    myItemNum:setString(getBagNumById(itemId))
    itemDesc:setString(item.iDesc)
    itemDetail:setString(item.iDesc)
    
    local word_num = itemDetail:getStringLength()
    local word_lines = tonumber(word_num/16 +1)
    print("word_num=="..word_num.."  word_lines=="..word_lines.." height=="..30*word_lines.."     bgwidht=="..(18*word_lines+20))
    itemDetail:setSize(cc.size(300,30*word_lines))
    itemDetailBg:setSize(cc.size(325,18*word_lines+20))
    print("dexcbg.y == "..(itemDetailBg:getPositionY()))
    print("dexc.y == "..(itemDetailBg:getPositionY()-itemDetailBg:getSize().height-itemDesc:getPositionY() - 20))
    itemDesc:setPosition(28,(itemDetailBg:getPositionY()-55))
    

    local frament,frag = ToolsgetItemIcon(item.iType,item.iTone)
    local _ccbutton = ccui.Button:create()
    _ccbutton:setTouchEnabled(true)
    _ccbutton:loadTextures(frament,frament,"")
    _ccbutton:setPosition(85,430)
    sellPanel:addChild(_ccbutton)

    local  maskedCal = maskedHeroWithSprite("res/daota/"..item.iIcon, frament,frag,item.iNum)
    _ccbutton:addChild(maskedCal)
    maskedCal:setPosition(cc.p(_ccbutton:getContentSize().width/2,_ccbutton:getContentSize().height/2))

    --        if item[5] == 2 then
    --            goldIcon:loadTexture("res/data/GUI/shop_token_icon.png")
    --        elseif item[5] == 1 then
    goldIcon:loadTexture("res/data/ShopUI_1/shop_gold_icon.png")
    --        end

    closeBtn:setTouchEnabled(true)
    closeBtn:addTouchEventListener(closeBuyPanel)

    buyBtn:setTouchEnabled(true)
    buyBtn:addTouchEventListener(buyItem)

    shopBuyPanel:setVisible(true)
    shopBuyPanel:setEnabled(true)
end
local _selldetail = nil
local _container  = nil
local _tableitem = nil
-- table{id=物品ID，name=名字，frag_name=边框，num=数量，detail=描述,price=价格}
local function buttonInit(_openType,currPage)
    --关闭
    local function easeAciton()
        _selldetail:setVisible(false)
        _selldetail:setEnabled(false)
        print("asd")
    end
    local function _ptouchEvent(sender,eventType)
        local _button = sender
--        if eventType == ccui.TouchEventType.began then
--            cclog("tag====".. _button:getPositionX())
--            _button:setScale(0.9) 
--        elseif eventType == ccui.TouchEventType.moved then
--            _button:setScale(1) 
        if eventType == ccui.TouchEventType.ended then --end操作
            _button:setScale(1) 
            --
            --end操作
            local scale1 = cc.ScaleTo:create(0.3,0)
            local scale_ease1 = cc.EaseBackIn:create(scale1)
--            local
            local seq2 = cc.Sequence:create(scale_ease1,cc.CallFunc:create(easeAciton))
            _container:runAction(seq2)
            
            local itemID = _button:getTag()
            print("close====")
        end
    end  
    
    local _xbutton = _selldetail:getChildByName("sell_container"):getChildByName("close_button")
    _xbutton:addTouchEventListener(_ptouchEvent)
    --关闭end
    
    --出售调节
    local text_sellnum = _container:getChildByName("item_sell_num")
    local text_income = _container:getChildByName("get_price")
    local _sellnum
    _sellnum = 1
    local function sellAdjust()
        if _sellnum <1 then _sellnum =1 end
        if _sellnum >_tableitem.iNum then _sellnum = _tableitem.iNum end
          
        text_sellnum:setString(_sellnum)        --出售个数
        text_income:setString(_tableitem.iSellPrice*_sellnum)   --获得金钱
    end
    
    local function _stouchEvent(sender,eventType)
        local _button = sender
        if eventType == ccui.TouchEventType.ended then --end操作
           if _button:getName() == "minus_button" then
              _sellnum = _sellnum -1
              sellAdjust()
           elseif _button:getName() == "plus_button" then
            _sellnum = _sellnum +1
            sellAdjust()
           elseif _button:getName() == "max_button"  then
            _sellnum = _tableitem.iNum
            sellAdjust()
           end
            
        end
    end  
    
    local _minusbutton = _container:getChildByName("minus_button")
    _minusbutton:addTouchEventListener(_stouchEvent)
    
    local _plusbutton  = _container:getChildByName("plus_button") 
    _plusbutton:addTouchEventListener(_stouchEvent)
    
    local _maxbutton = _container:getChildByName("max_button")
    _maxbutton:addTouchEventListener(_stouchEvent)
    
    --出售调节end
   
    
    
    --确认出售
    local function _confirmtouchEvenet(sender,eventType)
    if eventType == ccui.TouchEventType.ended then
         print("出售完之后要改XML，现在没法保存")
            local scale1 = cc.ScaleTo:create(0.3,0)
            local scale_ease1 = cc.EaseBackIn:create(scale1)
            --            local
            local seq2 = cc.Sequence:create(scale_ease1,cc.CallFunc:create(easeAciton))
            _container:runAction(seq2)
            print("打开当前页 ===== "..currPage)


            print("卖。。。。。。。。。。。。====".._tableitem.iSellPrice*_sellnum)
            if _tableitem.iNum - _sellnum >0  then
                print("_tableitem.iId====1111===".._tableitem.iId)
                print("_sellnum====1111===".._sellnum)
                
                --修改数量
                local changeToken = function(_result) 
                      if _result == 10000 then
--                      print("仅仅几你急急急急急急急急急急急急急")
--                            CG_HANDLER(PACKET_CG_BagList)
                        changeBagDataByIdKey(_tableitem.iId,"iNum",(_tableitem.iNum - _sellnum))
                        updateDetailPanel(_tableitem,_openType,currPage)
                            local iName = _tableitem.iName
                            local num = _tableitem.iNum-_tableitem.iheroNum
                            if _openType == 1 then
                                    fragment_scrollInit_change("change",currPage,iName,num)
                            else
                                    paclage_scrollInit_change("change",currPage,iName,num)
                            end
                            
                      else
                            print("有其他错误")
                      end  
                end
                SET_CallBack(PACKET_GC_SaleItem,changeToken)
                CG_HANDLER_SaleItem(_tableitem.iId,_sellnum,_tableitem.iSellPrice*_sellnum)
            else
                --删除物品
--                closeDetailPanel()
--            ld(_sellnum*_tableitem.iSellPrice,1)
                local iName = _tableitem.iName

                local changeToken = function(_result) 
                    if _result == 10000 then
                            delBagDataById(_tableitem.iId)
                            local iName = _tableitem.iName
                            local num = _tableitem.iNum-_tableitem.iheroNum
                            if _openType == 1 then
                                fragment_scrollInit_change("delete",currPage,iName,num)
                            else
                                paclage_scrollInit_change("delete",currPage,iName,num)
                            end
                        
                    else
                        print("有其他错误")
                    end  
                end
                SET_CallBack(PACKET_GC_SaleItem,changeToken)
                CG_HANDLER_SaleItem(_tableitem.iId,_sellnum,_tableitem.iSellPrice*_sellnum)
                
            end
         
    end
    end
    
     local _confirmbutton = _container:getChildByName("sell_confirm_button")
    _confirmbutton:addTouchEventListener(_confirmtouchEvenet)
    --确认出售end
end

function SellInit(selldetail,table_item,openType,currPage)
    _selldetail = selldetail
    _tableitem = table_item
    
    _container = _selldetail:getChildByName("sell_container")
    _container:setAnchorPoint(cc.p(0.5,0.5))
    _container:setPosition(cc.p(1136/2,640/2))
    local scale1 = cc.ScaleTo:create(0.3,1)
--    local scale_ease1 = cc.EaseBounceOut:create(scale1)
    local scale_ease1 = cc.EaseBackOut:create(scale1)
    print("xx")
    _container:runAction(scale_ease1)
    
    print("sellinit  currPage==== "..currPage)
    buttonInit(openType,currPage) --按钮初始化
    
    local frament,frag = ToolsgetItemIcon(_tableitem.iType,_tableitem.iTone)
    
    local item_frame = _container:getChildByName("item_frame")
    local  maskedCal = maskedHeroWithSprite("res/daota/".._tableitem.iIcon, frament, frag)
    item_frame:addChild(maskedCal)
    maskedCal:setPosition(cc.p(item_frame:getSize().width/2,item_frame:getSize().height/2))
    
    local text_name = _container:getChildByName("item_name")
    text_name:setString(_tableitem.iName)
    
    local text_num = _container:getChildByName("item_num")
    text_num:setString(_tableitem.iNum)
    
    local text_price = _container:getChildByName("item_price")
    text_price:setString(_tableitem.iSellPrice)
    
    local text_sum = _container:getChildByName("item_sell_sum")
    text_sum:setString("/".._tableitem.iNum)
    
    local text_income = _container:getChildByName("get_price")
    text_income:setString(_tableitem.iSellPrice)
    
    local text_sell_num = _container:getChildByName("item_sell_num")
    text_sell_num:setString("1")
    
end

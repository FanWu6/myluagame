require "src/pkg_lua/sell_detail"
require "src/pkg_lua/item_detail"
require "src/fragment/frag_compose"
-- table{id=物品ID，name=名字，frag_name=边框，num=数量，detail=描述,price=价格}
local _detailLayer = nil
local function buttonInit(_tableitem,_openType,_currpage)
     --出售
    local function _stouchEvent(sender,eventType)
        local _button = sender
        if eventType == ccui.TouchEventType.ended then
            --出售操作
            print("_buttontag==".._button:getTag())
            local _psell = _detailLayer:getParent():getChildByName("sell_Panel")
            _psell:setVisible(true)
            _psell:setEnabled(true)
            print("detail  currPage==".._currpage)
            SellInit(_psell,_tableitem,_openType,_currpage)
            --
        end
    end 
    
   local sbutton = _detailLayer:getChildByTag(141)
   sbutton:addTouchEventListener(_stouchEvent)
    --出售end
     
    --详情/使用
    local function _utouchEvent(sender,eventType)
        local _button = sender
        if eventType == ccui.TouchEventType.ended then
        --详情/使用操作
            print("_buttontag==".._openType)
          
            if _openType == 1 then
                local _composeDetail = _detailLayer:getParent():getChildByName("frag_compose")
                _composeDetail:setVisible(true)
                _composeDetail:setEnabled(true)
                fragComposeInit(_composeDetail,_tableitem,_currpage)
            else
                local _pitemdetail = _detailLayer:getParent():getChildByName("item_detail_Panel")
                _pitemdetail:setVisible(true)
                _pitemdetail:setEnabled(true)
                ItemdetailInit(_pitemdetail,_tableitem)
            end
           
        --
        end
    end
    
    local ubutton = _detailLayer:getChildByTag(143)
    ubutton:addTouchEventListener(_utouchEvent)
    if _openType == 1 then
         ubutton:setTitleText("合成")
    else
        ubutton:setTitleText("详情")
    end
    --详情end
end

function updateSkillDetailPanel(_tableitem,_openType,_currpage)
    
    buttonInit(_tableitem,_openType,_currpage)

    local text_name= _detailLayer:getChildByTag(46) --名称
    text_name:setString(_tableitem.iName)

    local text_num=_detailLayer:getChildByTag(137) --数量
    text_num:setString(_tableitem.iNum)

    local text_detail = _detailLayer:getChildByTag(139) --detail
    text_detail:setString(_tableitem.iDesc)
    local text_detail_bg = _detailLayer:getChildByName("package_detail_frame")
    print("strenleng========----"..text_detail:getStringLength())
    local word_num = text_detail:getStringLength()
    local word_lines = word_num/16 +1
    text_detail:setSize(cc.size(300,30*word_lines))
    text_detail_bg:setSize(cc.size(326,18*word_lines+20))

    local text_item_story = _detailLayer:getChildByName("item_story")
    text_item_story:setPositionY(309-text_detail_bg:getSize().height)
    text_item_story:setString(_tableitem.iUseDesc)

    local text_price = _detailLayer:getChildByTag(150) --price
    text_price:setString(_tableitem.iSellPrice)

    local itemframe = _detailLayer:getChildByTag(45)--物品图像
    --    itemframe:loadTexture("res/daota/fragment2.png")
    local frament,frag = ToolsgetItemIcon(_tableitem.iType,_tableitem.iTone)

    local  maskedCal = maskedHeroWithSprite("res/daota/".._tableitem.iIcon, frament,frag)
    itemframe:removeAllChildren()
    itemframe:addChild(maskedCal)
    maskedCal:setPosition(cc.p(itemframe:getSize().width/2,itemframe:getSize().height/2))
end


function SkillDetailInit(detaillayer,_tableitem,_openType,_currpage)
    print("打开类型===".._openType.."    当前页签==".._currpage)
    _detailLayer = detaillayer
    if _detailLayer:getPositionX() == -160 then --初始化
    _detailLayer:setVisible(true)
    _detailLayer:setEnabled(true)
    local move1 = cc.MoveTo:create(0.5,cc.p(55,65))
    local move_ease1 = cc.EaseIn:create(move1,0.2)
    _detailLayer:runAction(move_ease1)
    print("INTI LAYER")
    end
    
    print("itemID==++++++++++".._currpage)
    updateDetailPanel(_tableitem,_openType,_currpage)
 
end

function closeSkillDetailPanel()
    if _detailLayer:getPositionX() ~= -160 then --初始化
        _detailLayer:setVisible(false)
        _detailLayer:setEnabled(false)
    end
    _detailLayer:setPositionX(-160)
    _detailLayer:getChildByTag(45):removeAllChildren()--物品图像
    
end
local _itemdetail =nil
local _container = nil
local _iscroll  = nil
local _tableitem = nil
local _hechengState = 1 --0隐藏  1展示
local _pathState = 1 --0隐藏 1展示
-- table{id=物品ID，name=名字，frag_name=边框，num=数量，detail=描述,price=价格}
local function buttonInit()
    local function easeAciton()
        _itemdetail:setVisible(false)
        _itemdetail:setEnabled(false)
    end

    local function _ptouchEvent(sender,eventType)
        local _button = sender
        --        if eventType == ccui.TouchEventType.began then
        --            cclog("tag====".. _button:getPositionX())
        --            _button:setScale(0.9) 
        --        elseif eventType == ccui.TouchEventType.moved then
        --            _button:setScale(1) 
        if eventType == ccui.TouchEventType.ended then --end
            --
            --end操作
            local itemID = _button:getTag()
            
            local scale1 = cc.ScaleTo:create(0.3,0)
            local scale_ease1 = cc.EaseBackIn:create(scale1)
--            --            local
            local seq2 = cc.Sequence:create(scale_ease1,cc.CallFunc:create(easeAciton))
            _container:runAction(seq2)
            
           print("close")
        end
    end  

    local _xbutton = _container:getChildByName("close_button")
    _xbutton:addTouchEventListener(_ptouchEvent)
end

local function initHecheng()
    local _frameHecheng = _iscroll:getChildByName("frame_hecheng")
    local crackSize = 20
    local imageSize = 60
    _frameHecheng:removeAllChildren()
    
    --合成字段是否为空。
    if _tableitem.iComposeTargetStr ~= "null" and nil ~= _tableitem.iComposeTargetStr then
        _hechengState = 1
        --截取合成字段，获取道具Id数组
        local hechengStrArr = lua_string_split(_tableitem.iComposeTargetStr,"_")
        _frameHecheng:setSize(cc.size(500,imageSize*math.ceil(table.maxn(hechengStrArr)/2)+(math.ceil(table.maxn(hechengStrArr)/2)+1)*15))
        for i=0,table.maxn(hechengStrArr)-1,1 do
            local tempItem = getTestDataById(tonumber(hechengStrArr[i+1]))
            local frament,frag = ToolsgetItemIcon(tempItem._itemData.iType,tempItem._itemData.iTone)
            
            local image1 = ccui.ImageView:create("res/daota/"..tempItem._itemData.iIcon..".jpg")
            local  maskedCal = maskedHeroWithSprite("res/daota/"..tempItem._itemData.iIcon, frament,frag)
            image1:addChild(maskedCal)
            maskedCal:setPosition(cc.p(image1:getSize().width/2,image1:getSize().height/2))
               
               
           image1:setSize(cc.size(imageSize,imageSize))
           image1:ignoreContentAdaptWithSize(false)
           image1:setScale(60/108)
           
            --设置文字说明
            local text_hecheng = ccui.Text:create()
            text_hecheng:setAnchorPoint(cc.p(0,0.5))
            text_hecheng:setString(tempItem._itemData.iName)
            text_hecheng:setFontSize(20)
            _frameHecheng:addChild(text_hecheng)
            --设置文字end
           
            _frameHecheng:addChild(image1,10)
            local t1,t2 = math.modf((i+1)/2)
            
            if t2>0 then  --设置X坐标
                image1:setPositionX(12+image1:getSize().width*0.5)
                text_hecheng:setPositionX(12+image1:getSize().width+10)
            elseif t2 ==0 then
                image1:setPositionX(12+180+image1:getSize().width*1.5)
                 text_hecheng:setPositionX(12+180+image1:getSize().width*2+10)
            end
            local posY = (_frameHecheng:getSize().height-crackSize-image1:getSize().height/2)-(crackSize+image1:getSize().height)*(math.modf(i/2)) + (math.modf(i/2)) * 8
            --(地板高度-边缘间隔-纹理高度/2)-(边缘间隔+纹理高度)*（行数-1）- (缩短上下边距)
            image1:setPositionY(posY)
            text_hecheng:setPositionY(posY)
        end
    else
        _hechengState = 0
    end
end

local function initPath()
    local _framePath = _iscroll:getChildByName("frame_path")
    local crackSize = 25
    local imageSize = 60

    _framePath:removeAllChildren()
    
    --合成字段是否为空。
    if _tableitem.thingsFrom ~= "null" and nil ~= _tableitem.thingsFrom then
        _pathState = 1
        local thingFromArr = lua_string_split(_tableitem.thingsFrom,"_")
        _framePath:setSize(cc.size(500,imageSize*math.ceil(table.maxn(thingFromArr)/2)+(math.ceil(table.maxn(thingFromArr)/2)+1)*15))
        for i=0,table.maxn(thingFromArr)-1,1 do
            --设置管卡图标，目前这个是假数据，假图片
            local frament,frag = ToolsgetItemIcon(1,1)
            local image1 = ccui.ImageView:create("res/daota/1.jpg")
            local  maskedCal = maskedHeroWithSprite("res/daota/1", frament,frag)
            image1:addChild(maskedCal)
            maskedCal:setPosition(cc.p(image1:getSize().width/2,image1:getSize().height/2))

            image1:setSize(cc.size(imageSize,imageSize))
            image1:ignoreContentAdaptWithSize(false)
            image1:setScale(60/108)

            --设置文字说明
            print("thingFromArr[i+1]====="..thingFromArr[i+1])
            local charpterData = getCharpterDataById(tonumber(thingFromArr[i+1]))
            local text_path = ccui.Text:create()
            text_path:setAnchorPoint(cc.p(0,0.5))
            text_path:setString(charpterData["name"])
            text_path:setFontSize(20)
            _framePath:addChild(text_path)
            --设置文字end

            _framePath:addChild(image1,10)
            local t1,t2 = math.modf((i+1)/2)

            if t2>0 then  --设置X坐标
                image1:setPositionX(5+image1:getSize().width*0.5)
                text_path:setPositionX(5+image1:getSize().width+10)
            elseif t2 ==0 then
                image1:setPositionX(5+180+image1:getSize().width*1.5)
                text_path:setPositionX(5+180+image1:getSize().width*2+10)
            end

            local posY = (_framePath:getSize().height-crackSize-image1:getSize().height/2)-(crackSize+image1:getSize().height)*(math.modf(i/2)) + (math.modf(i/2)) * 8
            --(地板高度-边缘间隔-纹理高度/2)-(边缘间隔+纹理高度)*（行数-1）- (缩短上下边距)
            image1:setPositionY(posY)
            text_path:setPositionY(posY+8)


        end
    else
        _pathState = 0
    end
    
end

local function InitScroll()
    local _textName = _iscroll:getChildByName("text_name")
    local _frameHecheng = _iscroll:getChildByName("frame_hecheng")
    local _framePath = _iscroll:getChildByName("frame_path")

    local _text1 = _iscroll:getChildByName("text_hecheng")
    local _text2 = _iscroll:getChildByName("text_tujing")
    
    local scrollY=_textName:getSize().height+20
    --+_frameHecheng:getSize().height+_framePath:getSize().height   _text1:getVirtualRendererSize().height
    --合成面板是否展示
    if _hechengState == 1 then
        scrollY = scrollY + _frameHecheng:getSize().height + _text1:getVirtualRendererSize().height
    end
    
    if _pathState == 1 then
        scrollY = scrollY + _framePath:getSize().height + _text1:getVirtualRendererSize().height
    end
    --设置滑动区域大小
    
    if scrollY>=480 then
        _iscroll:setInnerContainerSize(cc.size(510,scrollY))
    else
        _iscroll:setInnerContainerSize(cc.size(510,480))
    end
    --    
    _textName:setPositionY(_iscroll:getInnerContainerSize().height - _textName:getSize().height)
    
    --判断是否隐藏合成面  重新设置位置
    if _hechengState == 1 then
        _text1:setPositionY(_iscroll:getInnerContainerSize().height-_textName:getSize().height-20)
        _frameHecheng:setPositionY(_text1:getPositionY()-20)
        _text1:setVisible(true)
        _frameHecheng:setVisible(true)
    else 
        _text1:setVisible(false)
        _frameHecheng:setVisible(false)
    end
    
    --判断是否隐藏获得途径界面  重新设置位置
    if _pathState == 1  and _hechengState == 1 then
        _text2:setPositionY(_frameHecheng:getPositionY()-_frameHecheng:getSize().height-20)
        _framePath:setPositionY(_text2:getPositionY()-20)
        _text2:setVisible(true)
        _framePath:setVisible(true)
    else 
        if _pathState == 1 and _hechengState == 0 then
            _text2:setPositionY(_iscroll:getInnerContainerSize().height-_textName:getSize().height-20)
            _framePath:setPositionY(_text2:getPositionY()-20)
            _text2:setVisible(true)
            _framePath:setVisible(true)
        else
            _text2:setVisible(false)
            _framePath:setVisible(false)
        end
        
    end
end

function ItemdetailInit(itemdetail,tableitem)
    _itemdetail = itemdetail
    _tableitem = tableitem
    _container  = itemdetail:getChildByName("item_detail_container")
    _container:setAnchorPoint(cc.p(0.5,0.5))
    _container:setPosition(cc.p(1136/2,640/2))
    
    local scale1 = cc.ScaleTo:create(0.3,1)
--    --    local scale_ease1 = cc.EaseBounceOut:create(scale1)
    local scale_ease1 = cc.EaseBackOut:create(scale1)
--    print("xx")
    _container:runAction(scale_ease1)
    _iscroll = _container:getChildByName("item_detail_scroll")
    
    --设置滚动容器中的道具图片   道具名字
    local _textName = _iscroll:getChildByName("text_name")
    local frament,frag = ToolsgetItemIcon(tableitem.iType,tableitem.iTone)
    local _itemImage = _textName:getChildByName("item_frame")
    local  maskedCal = maskedHeroWithSprite("res/daota/"..tableitem.iIcon, frament,frag)
    _itemImage:addChild(maskedCal)
    maskedCal:setPosition(cc.p(_itemImage:getSize().width/2,_itemImage:getSize().height/2))
    _itemImage:setScale(80/108)
    --设置名字
    local itemNameLabel = _textName:getChildByName("item_name_label")
    itemNameLabel:setString(tableitem.iName)
    
    local t1,t2 = math.modf(1/2)
    buttonInit()
    
    initHecheng()  --可合成装备信息初始化
    initPath()--获得途径初始化
    InitScroll()
end
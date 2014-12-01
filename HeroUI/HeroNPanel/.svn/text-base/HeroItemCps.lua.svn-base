local ui_widget
local pui
local cur_item
local heroObj
local framID
local hro_item_panel

local CpsInit
local cur_itemlist = {} -- 当前合成列表
local isConfirm = "" --存储当前物品是否足够的状态  0 不足  1 足

--
local function selecedChange(_Id)
    local seleced_list= ui_widget:getChildByName("Itm_cps_Panel"):getChildByName("seleced_list")  

    local index = table.maxn(cur_itemlist)
    
    for i=1,index,1 do
        local longsign = table.maxn(cur_itemlist)
        if cur_itemlist[longsign].iId ~= _Id then
            table.remove(cur_itemlist)
            local xx = seleced_list:getChildByName("selecedBtn"..longsign)
            xx:removeFromParent()
            local star = seleced_list:getChildByName("star"..longsign)
                if star ~= nil then
                    star:removeFromParent()
                end
        else
            cur_item = cur_itemlist[longsign]
            CpsInit(cur_item.iId)
            break
        end
    end
    if 30*2+85*(table.maxn(cur_itemlist)-1)<=360 then
        seleced_list:getInnerContainer():setSize(cc.size(360,60))
    else
        seleced_list:getInnerContainer():setSize(cc.size(30*2+85*(table.maxn(cur_itemlist)-1),60))
        seleced_list:getInnerContainer():setPositionX(360-seleced_list:getInnerContainer():getSize().width)
    end
    local seleced_frame = seleced_list:getChildByName("seleced_frame")
    print("aaassssaaa----"..table.maxn(cur_itemlist))
    local curBtn = seleced_list:getChildByName("selecedBtn"..table.maxn(cur_itemlist))
    
    seleced_frame:setPosition(cc.p(curBtn:getPositionX(),26))

    
end

--选择框按钮
local function _selecedEvent(sender,eventType)
    local _button = sender
    if eventType == ccui.TouchEventType.began then
        _button:setScale(0.9)
    elseif eventType == ccui.TouchEventType.moved then
        --移动按钮没有操作
        _button:setScale(0.9)
    elseif eventType == ccui.TouchEventType.canceled then   
        _button:setScale(1)
    elseif eventType == ccui.TouchEventType.ended then     --end之后的回调
        _button:setScale(1)
        local result = getBagDataById(_button:getTag())
--        table.insert(cur_itemlist,result)
        print("----aaa-----"..result.iId)
        cur_item = result
        CpsInit(result.iId)
       selecedChange(result.iId)
    end
end  


local function selecedInit(_Id)
    local seleced_list= ui_widget:getChildByName("Itm_cps_Panel"):getChildByName("seleced_list")  
    
    local index = table.maxn(cur_itemlist)   --选择序数
    
    --滑动条大小
    if 30*2+85*(index-1)>360 then
        seleced_list:getInnerContainer():setSize(cc.size(30*2+85*(index-1),60))
    end
    --初始化第一个
    if index == 1 then
        local selecedBtn = seleced_list:getChildByName("selecedBtn1")
        local frament,frag = ToolsgetItemIcon(cur_item.iType,cur_item.iTone)
        local  maskedCal = maskedHeroWithSprite("res/daota/"..cur_item.iIcon, frament,frag)

        --currData[i]._itemData.iNum-currData[i]._itemData.iheroNum
        selecedBtn:setTag(_Id)
        selecedBtn:addChild(maskedCal)
        maskedCal:setScale(50/108)
        maskedCal:setPosition(cc.p(selecedBtn:getContentSize().width/2,selecedBtn:getContentSize().height/2))
        selecedBtn:addTouchEventListener(_selecedEvent)
    end
    --1
    if index>=2 then
            local selecedBtn = seleced_list:getChildByName("selecedBtn1"):clone()
            selecedBtn:setName("selecedBtn"..index)
            selecedBtn:setTag(_Id)
            seleced_list:addChild(selecedBtn)
            selecedBtn:setPosition(cc.p(30+(index-1)*85,30))
            selecedBtn:addTouchEventListener(_selecedEvent)
            
        local frament,frag = ToolsgetItemIcon(cur_item.iType,cur_item.iTone)
        local  maskedCal = maskedHeroWithSprite("res/daota/"..cur_item.iIcon, frament,frag)

        --currData[i]._itemData.iNum-currData[i]._itemData.iheroNum

        selecedBtn:addChild(maskedCal)
        maskedCal:setScale(50/108)
        maskedCal:setPosition(cc.p(selecedBtn:getContentSize().width/2,selecedBtn:getContentSize().height/2))
            --2
            local star = ccui.ImageView:create("res/HeroSceneUI/item_compose/compose_path_arrow.png")
            seleced_list:addChild(star)
            star:setName("star"..index)
            star:setPosition(cc.p(75+(index-2)*85,30))
            --3选择框
            local seleced_frame = seleced_list:getChildByName("seleced_frame")
            seleced_frame:setPosition(cc.p(selecedBtn:getPositionX(),26))
            
        --碎片标示1
        if _Id >= 180001 then
            local sign = cc.Sprite:create("res/HeroSceneUI/star_yellow.png")
            selecedBtn:addChild(sign)
            sign:setPosition(cc.p(selecedBtn:getContentSize().width/2,5))
        end
    end
    
    --
    if seleced_list:getInnerContainer():getSize().width>360 then
        seleced_list:getInnerContainer():setPositionX(360-seleced_list:getInnerContainer():getSize().width)
        print("aaa===----"..seleced_list:getInnerContainer():getSize().width)
        print("bbb===----"..seleced_list:getInnerContainer():getPositionX())
    end
end

local function _itemCpsEvent(sender,eventType)
    local _button = sender
    if eventType == ccui.TouchEventType.began then
        _button:setScale(0.9)
    elseif eventType == ccui.TouchEventType.moved then
        --移动按钮没有操作
        _button:setScale(0.9)
    elseif eventType == ccui.TouchEventType.canceled then   
        _button:setScale(1)
    elseif eventType == ccui.TouchEventType.ended then     --end之后的回调
        _button:setScale(1)
        local result = getBagDataById(_button:getTag())
        table.insert(cur_itemlist,result)
            cur_item = result
          CpsInit(result.iId)
        selecedInit(result.iId)
    end
end  


CpsInit = function()
    --1道具名
    isConfirm=""
    print("CpsInit '' ------- isConfirm======="..isConfirm)
    local item_name = ui_widget:getChildByName("Itm_cps_Panel"):getChildByName("itemname")
    item_name:setString(cur_item.iName)
    --2合成路线
    local cpsPath_panel = ui_widget:getChildByName("Itm_cps_Panel"):getChildByName("cpsPath_panel")
    local getPath_panel = ui_widget:getChildByName("Itm_cps_Panel"):getChildByName("getPath_panel")
    local itemCpslist = lua_string_split(cur_item.iComposeMaterialsStr,"_")

        --4合成费用
       local hechengFee = cpsPath_panel:getChildByName("itemfee_text")
       hechengFee:setString(cur_item.iMcostPay)
       
    if cur_item.iComposeMaterialsStr ~= "null" then   --如果合成所需材料不为空
        getPath_panel:setVisible(false)
        cpsPath_panel:setVisible(true)
        
        print("如果合成所需材料不为空")
            --2.1被合成道具
            local itemtarget = cpsPath_panel:getChildByName("itemtarget")
            itemtarget:removeAllChildren()
            local frament,frag = ToolsgetItemIcon(cur_item.iType,cur_item.iTone)
            local  maskedCal = maskedHeroWithSprite("res/daota/"..cur_item.iIcon, frament,frag)
        
            --currData[i]._itemData.iNum-currData[i]._itemData.iheroNum
            
            itemtarget:addChild(maskedCal)
            maskedCal:setScale(85/108)
            maskedCal:setPosition(cc.p(itemtarget:getContentSize().width/2,itemtarget:getContentSize().height/2))
            --2.2合成线选择
            local cpslineId = table.maxn(itemCpslist)
            local cps_line = cpsPath_panel:getChildByName("cps_line")
            cps_line:loadTexture("res/HeroSceneUI/item_compose/compose_line"..cpslineId..".png")
            cps_line:removeAllChildren()
            --2.3合成配方
            local itemCps_Model = cpsPath_panel:getChildByName("itemCps_Model")
            
            local doubleItemId = nil
            local state = 1 -- 1 为零不够   2  只有一个，需要区分展示  3 》=2 直接展示所有的数量
            --查找当前物品ID是否存在重复
            for k = 1,table.maxn(itemCpslist),1 do
                --获取查找到的字符串的结束位置 index1
                local _,index1 = string.find(cur_item.iComposeMaterialsStr,itemCpslist[k])
                if nil ~= index1 then
                    --指定的字符串在指定位置开始查找
                    local _,index2 = string.find(cur_item.iComposeMaterialsStr,itemCpslist[k],index1)
                    if nil ~= index2 then
                        doubleItemId = itemCpslist[k]
                        break
                    end
                end
            end
            
            local doubleItemNum
            if  doubleItemId ~= nil then
               doubleItemNum = getBagNumById(tonumber(doubleItemId))
            end
            
        
        
            if itemCpslist[1] ~= nil then
                       for i=1,cpslineId,1 do
                            local itemCps = itemCps_Model:clone()
                            cps_line:addChild(itemCps)
                            print("itemCpslist[i]==="..itemCpslist[i])
                            local result = getBagDataById(tonumber(itemCpslist[i]))
                            local frament,frag = ToolsgetItemIcon(result.iType,result.iTone)
                            local  maskedCal = maskedHeroWithSprite("res/daota/"..result.iIcon, frament,frag)
                            itemCps:setPosition(cc.p(0,-0))
                            itemCps:addChild(maskedCal)
                            maskedCal:setScale(50/108)
                            maskedCal:setPosition(cc.p(itemCps:getContentSize().width/2,itemCps:getContentSize().height/2+2))
                            itemCps:addTouchEventListener(_itemCpsEvent)
                            itemCps:setTag(result.iId)
                            
                            local currNum = getBagNumById(tonumber(itemCpslist[i]))
                            local item_num = itemCps:getChildByName("item_num")
--                            if tonumber(itemCpslist[i]) == doubleItemId then
                                --颜色设置
                                if currNum == 0 then  --0个
                                    item_num:setString(currNum)
                                    item_num:setColor(cc.c3b(245,28,33))
                                    isConfirm = isConfirm .. currNum
                                    print("currNum===0  isConfirm====="..isConfirm)
                                elseif currNum == 1 then -- 1个
--                                    print("doubleItemId========"..doubleItemId)
                                    if tonumber(itemCpslist[i]) == tonumber(doubleItemId)  then
                                        print("doubleItemNum========"..doubleItemNum)
                                        if doubleItemNum == 1 then
                                            item_num:setString(currNum)
                                            item_num:setColor(cc.c3b(255,255,255))
                                            isConfirm = isConfirm .. doubleItemNum
                            print("doubleItemNum == 1  isConfirm====="..isConfirm)
                                            doubleItemNum = 0
                                        else
                                            item_num:setString(0)
                                            item_num:setColor(cc.c3b(245,28,33))
                                            isConfirm = isConfirm .. "0"
                            print("doubleItemNum == 1 else  isConfirm====="..isConfirm)  
                                        end
                                    else
                                        item_num:setString(currNum)
                                        item_num:setColor(cc.c3b(255,255,255))
                                        isConfirm = isConfirm .. currNum
                    print("doubleItemNum !=1   isConfirm====="..isConfirm)  
                                    end
                                    
                                else --》=2个
                                    item_num:setString(currNum)
                                    item_num:setColor(cc.c3b(255,255,255))
                                    isConfirm = isConfirm .. currNum
                    print("currNum =2   isConfirm====="..isConfirm)  
                                end
                                
                                --合成道具位置
                             if cpslineId == 1 then
                                    itemCps:setPosition(cc.p(97,-25))
                                    
                            elseif cpslineId == 2 then
                                  if i == 1 then
                                             itemCps:setPosition(cc.p(127,-25))
                                  elseif i == 2 then
                                            itemCps:setPosition(cc.p(7,-25))
                                  end
                            elseif cpslineId == 3 then
                                    if i == 1 then
                                        itemCps:setPosition(cc.p(4,-25))
                                    elseif i == 2 then
                                        itemCps:setPosition(cc.p(97,-25))
                                    elseif i == 3 then
                                        itemCps:setPosition(cc.p(190,-25))
                                    end
                            elseif cpslineId == 4 then
                                    if i == 1 then
                                        itemCps:setPosition(cc.p(5,-25))
                                    elseif i == 2 then
                                        itemCps:setPosition(cc.p(85,-25))
                                    elseif i == 3 then
                                        itemCps:setPosition(cc.p(165,-25))
                                    elseif i == 4 then
                                        itemCps:setPosition(cc.p(245,-25))
                                    end
                            end
                            
                       end
              end
              
      elseif cur_item.thingsFrom ~= "null" then   --如果物品获取来源不为空
        print("如果物品获取来源不为空")
            getPath_panel:setVisible(true)
            cpsPath_panel:setVisible(false)
            --3获取途径
            --3.1道具图标
                local itemframe1 = getPath_panel:getChildByName("itemframe1")
                itemframe1:removeAllChildren()
                    local frament,frag = ToolsgetItemIcon(cur_item.iType,cur_item.iTone)
                    local  maskedCal = maskedHeroWithSprite("res/daota/"..cur_item.iIcon, frament,frag)
                itemframe1:addChild(maskedCal)
                maskedCal:setScale(50/108)
                maskedCal:setPosition(cc.p(itemframe1:getContentSize().width/2,itemframe1:getContentSize().height/2))
            --3.2道具途径表
                local pathBtnModel = getPath_panel:getChildByName("pathBtnModel")
                local pathlistview = getPath_panel:getChildByName("path_listview")
                local itemPathlist = lua_string_split(cur_item.thingsFrom,"_")
                for i=1,table.maxn(itemPathlist),1 do 
                    local pathBtn = pathBtnModel:clone()
                    pathlistview:pushBackCustomItem(pathBtn)
                end
                
    elseif cur_item.iComposeTargetId ~= "null" then   --如果物品碎片不为空
        getPath_panel:setVisible(false)
        cpsPath_panel:setVisible(true)
        local cps_line = cpsPath_panel:getChildByName("cps_line")
        cps_line:loadTexture("res/HeroSceneUI/item_compose/compose_line1.png")
        cps_line:removeAllChildren()
        
        local itemCps = cpsPath_panel:getChildByName("itemCps_Model"):clone()
        cps_line:addChild(itemCps)


        --2.1被合成道具
        local itemtarget = cpsPath_panel:getChildByName("itemtarget")
        itemtarget:removeAllChildren()
        local frament,frag = ToolsgetItemIcon(cur_item.iType,cur_item.iTone)
        local  maskedCal = maskedHeroWithSprite("res/daota/"..cur_item.iIcon, frament,frag)
        itemtarget:addChild(maskedCal)
        maskedCal:setScale(85/108)
        maskedCal:setPosition(cc.p(itemtarget:getContentSize().width/2,itemtarget:getContentSize().height/2))
        --碎片
        local result = getBagDataById(tonumber(cur_item.iComposeTargetId))
        local frament,frag = ToolsgetItemIcon(result.iType,result.iTone)
        local  maskedCal = maskedHeroWithSprite("res/daota/"..result.iIcon, frament,frag)
        itemCps:setPosition(cc.p(0,-0))
        itemCps:addChild(maskedCal)
        maskedCal:setScale(50/108)
        maskedCal:setPosition(cc.p(itemCps:getContentSize().width/2,itemCps:getContentSize().height/2+2))
        itemCps:addTouchEventListener(_itemCpsEvent)
        itemCps:setTag(result.iId)
        
        itemCps:setPosition(cc.p(8,-25))
        
        --碎片标示2
        local sign = cc.Sprite:create("res/HeroSceneUI/star_yellow.png")
        itemCps:addChild(sign)
        sign:setPosition(cc.p(itemCps:getContentSize().width/2,5))
        --
        local currNum = getBagNumById(tonumber(result.iId))
        local item_num = itemCps:getChildByName("item_num")
        local item_sum = itemCps:getChildByName("cos_num")
        item_num:setString(currNum)
        item_sum:setString("/"..result.iComposeTargetNum)
        --                            if tonumber(itemCpslist[i]) == doubleItemId then
        --颜色设置
        if currNum <  result.iComposeTargetNum then  
            item_num:setColor(cc.c3b(245,28,33))
            isConfirm = isConfirm .. "0"
            print("setColor===111====isConfirm===="..isConfirm)
        else --》=2个
            item_num:setString(currNum)
            item_num:setColor(cc.c3b(255,255,255))
            isConfirm = isConfirm .. "1"
            print("setColor===222====isConfirm===="..isConfirm)
        end
    end

end

local function buttonInit()
    --1.关闭
    local close_btn = ui_widget:getChildByName("Itm_cps_Panel"):getChildByName("close_btn")
    local function _closeEvent(sender,eventType)
        local _button = sender
        --        cclog("tag====".. _button:getTag()) 
        if eventType == ccui.TouchEventType.began then
            _button:setScale(0.9)
        elseif eventType == ccui.TouchEventType.moved then
            --移动按钮没有操作
            _button:setScale(0.9)
        elseif eventType == ccui.TouchEventType.canceled then   
            _button:setScale(1)
        elseif eventType == ccui.TouchEventType.ended then     --end之后的回调
            _button:setScale(1)
            ui_widget:removeFromParent()
        end
    end  
    close_btn:addTouchEventListener(_closeEvent)
    
    --2 确认合成
    local confirm_btn = ui_widget:getChildByName("Itm_cps_Panel"):getChildByName("cpsPath_panel"):getChildByName("confirm_btn")
    local function _confirmEvent(sender,eventType)
        local _button = sender
        --        cclog("tag====".. _button:getTag()) 
        if eventType == ccui.TouchEventType.began then
            _button:setScale(0.9)
        elseif eventType == ccui.TouchEventType.moved then
            --移动按钮没有操作
            _button:setScale(0.9)
        elseif eventType == ccui.TouchEventType.canceled then   
            _button:setScale(1)
        elseif eventType == ccui.TouchEventType.ended then     --end之后的回调
            _button:setScale(1)
            local index = string.find(isConfirm,"0")
            print("index ------- isConfirm======="..isConfirm)
            
            if nil ~= index and index >=1 then
                --提示材料不足
            else
                if cur_item.iComposeTargetId == "null" then
                    local itemArr = lua_string_split(cur_item.iComposeMaterialsStr,"_")
                        for i=1,table.maxn(itemArr),1 do
                            addDataToBag(tonumber(itemArr[i]),-1)
                        end
                else
                    local result = getBagDataById(tonumber(cur_item.iComposeTargetId))
                    addDataToBag(tonumber(cur_item.iComposeTargetId),-tonumber(result.iComposeTargetNum))
                end
                --iComposeTargetId
                addDataToBag(cur_item.iId,1)
                CpsInit(cur_item.iId)
                print("set '' ------- isConfirm======="..isConfirm)
                UpdateHeroItemPanel()
            end
        end
    end  
    confirm_btn:addTouchEventListener(_confirmEvent)
    --碎片返回
    local back_btn = ui_widget:getChildByName("Itm_cps_Panel"):getChildByName("getPath_panel"):getChildByName("back_btn")
    local function _backEvent(sender,eventType)
        local _button = sender
        --        cclog("tag====".. _button:getTag()) 
        if eventType == ccui.TouchEventType.began then
            _button:setScale(0.9)
        elseif eventType == ccui.TouchEventType.moved then
            --移动按钮没有操作
            _button:setScale(0.9)
        elseif eventType == ccui.TouchEventType.canceled then   
            _button:setScale(1)
        elseif eventType == ccui.TouchEventType.ended then     --end之后的回调
            _button:setScale(1)


                local listnum = table.maxn(cur_itemlist)
                if listnum == 1 then 
                    ui_widget:removeFromParent()
                elseif listnum>1 then
                selecedChange(cur_itemlist[listnum-1].iId)
                end
        end
    end  
    back_btn:addTouchEventListener(_backEvent)
    
end

function HeroItemCps(_ui_widget,_pui,_cur_item,_hro_item_panel,_heroObj,_framID)
    cur_itemlist = {}
    ui_widget = _ui_widget
    pui = _pui
    cur_item = getBagDataById(_cur_item._itemData.iId)
    table.insert(cur_itemlist,cur_item)
    selecedInit(_cur_item._itemData.iId)
    
    heroObj =_heroObj 
    framID = _framID 
    hro_item_panel = _hro_item_panel

    buttonInit()
    CpsInit(cur_item.iId)
end
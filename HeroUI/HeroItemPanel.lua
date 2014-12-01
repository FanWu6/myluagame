require "src/HeroUI/HeroNPanel/HeroOwnItem"   --已装备英雄列表
require "src/HeroUI/HeroNPanel/HeroItemCps"   --道具合成
local ui_widget
local heroObj
local framID
local hro_item_panel

local cur_item --当前所要更花的物品对象
local cur_itemlist--当前物品列表
local RichLabel = require "src/HeroUI/RichLabel"
local nameArr = {"攻击力","护甲","吸血","魔法抗性","生命力","能量恢复","生命恢复","力量","敏捷","智力","攻击速度","物理闪避","力量，敏捷，智力"}

local function sortLevelByType(a,b) 
    if (a._itemData.iNum ~=0 and b._itemData.iNum ~= 0) then
        if (a._itemData.iTone == b._itemData.iTone) then
            return a._itemData.iId > b._itemData.iId
        else
            return a._itemData.iTone>b._itemData.iTone
        end
    elseif (a._itemData.iNum ==0 and b._itemData.iNum ~= 0) or  (a._itemData.iNum ~=0 and b._itemData.iNum == 0) then
        return a._itemData.iNum > b._itemData.iNum
    else
        if  a._itemData.iTone == b._itemData.iTone then
            return a._itemData.iId < b._itemData.iId
        else
            return a._itemData.iTone < b._itemData.iTone
        end
    end
end 
--根据不同的页签获取不同的数据并排序
local function getDataByType(type)     --1.装备 2.卷轴 3.灵魂石 4.消耗品 5.碎片
    local result = {}
    for i,v in ipairs(bagItemData) do
        --5为碎片，背包不展示
        if type > 0 and v._itemData.iType ~= 5 and v._itemData.iType == type then
            table.insert(result,v)
        elseif type == 0 and v._itemData.iType ~= 5 then
            table.insert(result,v)
        end
    end
    table.sort(result,sortLevelByType)
    return result
end

local function itemInfoInit(itemId)
       local hroitem_Info = ui_widget:getChildByName("hroItm_Panel"):getChildByName("hroitm_infoPanel")
       --图标1
       local itm_fra1 = hroitem_Info:getChildByName("itm_fra1")
       itm_fra1:removeAllChildren()
       --
       local result
       if itemId ~= nil then
               result = getTestDataById(itemId)
               --当前物品对象
               cur_item = result
       else
           result = cur_itemlist[1]
           cur_item = result
       end
               --当前装备的装备图标
               if heroObj._heroData["itemfra"..framID] ~=nil then
                   local xx = ccui.ImageView:create("res/daota/"..result._itemData.iIcon..".jpg")
                   itm_fra1:addChild(xx)
                   xx:setEnabled(false)
                   xx:setScale(50/78)
                   xx:setPosition(cc.p(itm_fra1:getContentSize().width/2,itm_fra1:getContentSize().height/2+2))
               end
               --当前装备的装备名字
               if heroObj._heroData["itemfra"..framID] ~=nil then
                   local item_name1 = hroitem_Info:getChildByName("itm_name1")
                   item_name1:setString(result._itemData.iName)
                   item_name1:setVisible(true)
               else
                   local item_name1 = hroitem_Info:getChildByName("itm_name1")
                   item_name1:setVisible(false)
               end
               --要更换的装备图标
                if result ~=nil then
                    local itm_fra2 = hroitem_Info:getChildByName("itm_fra2")
                     itm_fra2:removeAllChildren()
                    local xx1 = ccui.ImageView:create("res/daota/"..result._itemData.iIcon..".jpg")
                    itm_fra2:addChild(xx1)
                    xx1:setEnabled(false)
                    xx1:setScale(94/78)
                    xx1:setPosition(cc.p(itm_fra2:getContentSize().width/2,itm_fra2:getContentSize().height/2+2))
                end
                --名字2
                if result ~= nil then
                    local item_name2 = hroitem_Info:getChildByName("itm_name2")
                    item_name2:setString(result._itemData.iName)
                    item_name2:setVisible(true)
                else
                    local item_name2 = hroitem_Info:getChildByName("itm_name2")
                    item_name2:setVisible(false)
                end
                --数量
                if result ~= nil then
                    local item_num = hroitem_Info:getChildByName("item_num")
                    item_num:setString(result._itemData.iNum)
                    item_num:setVisible(true)
                else
                    local item_num = hroitem_Info:getChildByName("item_num")
                    item_num:setVisible(false)
                end
                
    --属性
                if result ~= nil then
                    local descInfoView = hroitem_Info:getChildByName("descInfoView")
                    descInfoView:removeAllItems()
                    for i=1,5,1 do
                        local attrType = result._itemData["attrType"..i]
                        if attrType ~= "null" and attrType ~= 0  then
                            local name = nameArr[attrType]
                            local value = result._itemData["attr"..i]
                            local params = {
                                text = "[fontColor=f75d85 fontSize=20]"..name.."[/fontColor]".."[fontColor=FF1EB007 fontSize=20]+"..value.."[/fontColor]",
                                dimensions = cc.size(400, 151)
                            }
                            local testLabel = RichLabel:create(params)
                            local layout = ccui.Layout:create()
                            layout:setSize(cc.size(400,30))
                            layout:addChild(testLabel)
                            testLabel:setPosition(cc.p(5,30))
                            descInfoView:pushBackCustomItem(layout)
                        end
                    end
                else 
                    local descInfoView = hroitem_Info:getChildByName("descInfoView")
                    descInfoView:setVisible(false)
                end
            --道具描述
            if result ~= nil then
                local descInfoView2 = hroitem_Info:getChildByName("descInfoView2")

                    
                       
                --创建text
                local text = descInfoView2:getChildByName("descTextt")
                text:setString(cur_item._itemData.iDesc)
                --换行
                local width = text:getVirtualRendererSize().width
                local height = text:getVirtualRendererSize().height
                text:setSize(cc.size(390,math.ceil(width/390)*(height)))
                text:ignoreContentAdaptWithSize(false)
--                descInfoView2:pushBackCustomItem(text)


            else 
                local descInfoView2 = hroitem_Info:getChildByName("descInfoView2")
                descInfoView2:setVisible(false)
            end
            
                
--          end
end

local function ScrollInit()  --装备栏初始化
    local scrollview = ui_widget:getChildByName("hroItm_Panel"):getChildByName("item_scrollview")
    scrollview:removeAllChildren()
    local currData = getDataByType(1)
    cur_itemlist = currData
--    local listnum = table.maxn(currData)
    local listnum = table.maxn(currData)
    
    local itemlines = math.ceil(listnum/5)
    local itemModel = ui_widget:getChildByName("hroItm_Panel"):getChildByName("itemBtnModel")
    local itemSize = itemModel:getSize()
    
    scrollview:setInnerContainerSize(cc.size(525,20+itemlines*itemSize.height+(itemlines-1)*6))
    
    local function _itemEvent(sender,eventType)
        local _button = sender
        if eventType == ccui.TouchEventType.began then
            _button:setScale(0.9) 
        elseif eventType == ccui.TouchEventType.moved then
            _button:setScale(1) 
        elseif eventType == ccui.TouchEventType.ended then --end操作
            _button:setScale(1) 
            local xx = getBagDataById(sender:getTag())
            itemInfoInit(sender:getTag())
            --如果没有该装备，则无效化更换按钮
            if xx.iNum < 1 then
                local genghuan_btn = ui_widget:getChildByName("hroItm_Panel"):getChildByName("hroitm_infoPanel"):getChildByName("genghuan_btn")
                genghuan_btn:setVisible(false)
                local hecheng_btn = ui_widget:getChildByName("hroItm_Panel"):getChildByName("hroitm_infoPanel"):getChildByName("hecheng_btn")
                hecheng_btn:setPosition(cc.p(215,34))
            else
                local genghuan_btn = ui_widget:getChildByName("hroItm_Panel"):getChildByName("hroitm_infoPanel"):getChildByName("genghuan_btn")
                genghuan_btn:setVisible(true)
                genghuan_btn:setPosition(cc.p(306,34))
                local hecheng_btn = ui_widget:getChildByName("hroItm_Panel"):getChildByName("hroitm_infoPanel"):getChildByName("hecheng_btn")
                hecheng_btn:setPosition(cc.p(109,34))
            end
           --
        elseif eventType == ccui.TouchEventType.canceled then
            _button:setScale(1) 
        end
    end  
    
    for i,v in ipairs(currData)do
        local itembtn = itemModel:clone()
        scrollview:addChild(itembtn)
        itembtn:setTag(v._itemData.iId)
        
        local xx = math.floor((i-1)/5)
        itembtn:setPosition(cc.p(itemSize.width/2+(i-xx*5-1)*(itemSize.width-4),scrollview:getInnerContainer():getSize().height-itemSize.height/2-10-(itemSize.height+6)*xx))
        
        --1.图标
        local frament,frag = ToolsgetItemIcon(currData[i]._itemData.iType,currData[i]._itemData.iTone)
        local  maskedCal = maskedHeroWithSprite("res/daota/"..v._itemData.iIcon, frament,frag)
        
        --currData[i]._itemData.iNum-currData[i]._itemData.iheroNum
        if currData[i]._itemData.iNum == 0 then
                darkNode(maskedCal)
        end
        itembtn:addChild(maskedCal)
        maskedCal:setTag(10)
        maskedCal:setPosition(cc.p(itembtn:getContentSize().width/2,itembtn:getContentSize().height/2))
        
        --个数
        if v._itemData.iNum>1 then
            local text_num = ccui.Text:create()
            text_num:setAnchorPoint(1,0.5)
            text_num:setString(v._itemData.iNum)
            if v._itemData.iNum- v._itemData.iheroNum<1 then
                text_num:setColor(ccc3(217,141,10))
            end
            text_num:setFontSize(24)
            text_num:setPosition(maskedCal:getContentSize().width-10,20)
            maskedCal:addChild(text_num,2,10)
        end
        itembtn:addTouchEventListener(_itemEvent)
    end
end


--按钮初始化
local function buttonInit()
    --1.关闭
    local close_btn = ui_widget:getChildByName("hroItm_Panel"):getChildByName("close_btn")
    local function _closeEvent(sender,eventType)
        local _button = sender
        --        cclog("tag====".. _button:getTag()) 
        if eventType == ccui.TouchEventType.began then

        elseif eventType == ccui.TouchEventType.moved then
        --移动按钮没有操作
        elseif eventType == ccui.TouchEventType.canceled then   

        elseif eventType == ccui.TouchEventType.ended then     --end之后的回调
            ui_widget:removeFromParent()
        end
    end  
    close_btn:addTouchEventListener(_closeEvent)
    --2.背包初始化
    ScrollInit()
    --3 更换按钮初始化
    local genghuan_btn = ui_widget:getChildByName("hroItm_Panel"):getChildByName("hroitm_infoPanel"):getChildByName("genghuan_btn")
    local function _genghuanEvent(sender,eventType)
        local _button = sender
        --        cclog("tag====".. _button:getTag()) 
        if eventType == ccui.TouchEventType.began then

        elseif eventType == ccui.TouchEventType.moved then
        --移动按钮没有操作
        elseif eventType == ccui.TouchEventType.canceled then   

        elseif eventType == ccui.TouchEventType.ended then     --end之后的回调
           --如果有自由装备，直接更换
                if cur_item._itemData.iNum-cur_item._itemData.iheroNum > 0 then
                        heroObj._heroData["itemfra"..framID]= cur_item._itemData.iId --改变物品栏的物品ID
                        ui_widget:removeFromParent()
                        HeroDetai_buttonInit() --重置英雄界面
                        heroItmInfo(hro_item_panel,heroObj,framID)
               --如果没有自由装备，弹出英雄框
               else
                        local xx = ccs.GUIReader:getInstance():widgetFromJsonFile("res/HeroSceneUI/HroOwnItem.json")
                        ui_widget:addChild(xx)
                        HeroOwnItem(xx,ui_widget,cur_item,hro_item_panel,heroObj,framID)  --只有前两个参数有用分别是弹出界面和本界面，后面的是为了更新上级参数
                        -- 
               end
        end
    end  
    genghuan_btn:addTouchEventListener(_genghuanEvent)
    --4合成按钮
    local hecheng_btn = ui_widget:getChildByName("hroItm_Panel"):getChildByName("hroitm_infoPanel"):getChildByName("hecheng_btn")
    local function _hechengEvent(sender,eventType)
        local _button = sender
        --        cclog("tag====".. _button:getTag()) 
        if eventType == ccui.TouchEventType.began then

        elseif eventType == ccui.TouchEventType.moved then
        --移动按钮没有操作
        elseif eventType == ccui.TouchEventType.canceled then   

        elseif eventType == ccui.TouchEventType.ended then     --end之后的回调
        
            local xx = ccs.GUIReader:getInstance():widgetFromJsonFile("res/HeroSceneUI/ItemCompose.json")
            ui_widget:addChild(xx)
            HeroItemCps(xx,ui_widget,cur_item,hro_item_panel,heroObj,framID)
            -- 
        end
    end  
    hecheng_btn:addTouchEventListener(_hechengEvent)
end

function UpdateHeroItemPanel()
    HeroItemPanel(ui_widget,hro_item_panel,heroObj,framID)
end



function HeroItemPanel(_ui_widget,_hro_item_panel,_heroObj,_framID)
    ui_widget = _ui_widget
    heroObj =_heroObj 
    framID = _framID 
    hro_item_panel = _hro_item_panel
    buttonInit()
    itemInfoInit(heroObj._heroData["itemfra"..framID])
end
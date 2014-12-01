local ui_widget
local pui
local cur_item
local heroObj
local framID
local hro_item_panel
--根据英雄等级，品阶，ID排序
local function sortLevelByType(a,b) 
    if (a._heroData.rlvl == b._heroData.rlvl) then
        if (a._heroData.gradation==b._heroData.gradation) then
            return a._heroData.roleId > b._heroData.roleId
        else 
            return a._heroData.gradation>b._heroData.gradation
        end
    else
        return a._heroData.rlvl > b._heroData.rlvl
    end
end 
--根据不同的页签获取不同的数据并排序
local function getDataByType(heroType,heroisOpen)
    local result = {}
    local ipairsObj
    if heroisOpen == true then
        ipairsObj = userOpeheroData
    else
        ipairsObj = userLockheroData
    end

    for i,v in ipairs(ipairsObj) do
        if heroType == "all" then
            table.insert(result,v)
        elseif heroType == "qianpai" and v._heroData.standSlot == 0 then
            table.insert(result,v)
        elseif heroType == "zhongpai" and v._heroData.standSlot == 1 then
            table.insert(result,v)
        elseif heroType == "houpai" and v._heroData.standSlot == 2 then
            table.insert(result,v)
        end
    end
    table.sort(result,sortLevelByType)
    return result
end

local function listInit()
    local hoI_panel = ui_widget:getChildByName("Itm_cps_Panel"):getChildByName("hoI_panel")
    local listview = hoI_panel:getChildByName("hero_listview")
    local heroBtnModel = hoI_panel:getChildByName("heroBtnModel")
    --
    local heroopenlist = getDataByType("all",true)
    
    local function _hEvent(sender,eventType)
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
        end
    end  
    
    for i,v in ipairs(heroopenlist) do
        for j=1,6,1 do
            if v._heroData["itemfra"..j] == cur_item._itemData.iId then
                print("v._heroData[itemfra..j===="..v._heroData.roleId)
                local heroBtn = heroBtnModel:clone()
                --1.名称
                heroBtn:getChildByName("hroName_text"):setString(v._heroData.roleName)
                --2.头像
                local heroFrame = heroBtn:getChildByName("hro_image")
                heroFrame:setLocalZOrder(1)
                local xx = ccui.ImageView:create("res/heroHeadpic/"..v._heroData.headpic)
                heroBtn:addChild(xx)
                xx:setPosition(cc.p(heroFrame:getPosition()))
                xx:setScale(40/104)
                listview:pushBackCustomItem(heroBtn)
                
                heroBtn:addTouchEventListener(_hEvent)
            end
        end
    end
    --
    local heroFrame = hoI_panel:getChildByName("heroframe")
    heroFrame:setLocalZOrder(1)
    local xx = ccui.ImageView:create("res/heroHeadpic/"..heroObj._heroData.headpic)
    hoI_panel:addChild(xx)
    xx:setPosition(cc.p(heroFrame:getPosition()))
    xx:setScale(40/104)

end

local function buttonInit()
    --1.关闭
    local close_btn = ui_widget:getChildByName("Itm_cps_Panel"):getChildByName("close_btn")
    local back_btn = ui_widget:getChildByName("Itm_cps_Panel"):getChildByName("hoI_panel"):getChildByName("back_btn")
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
    back_btn:addTouchEventListener(_closeEvent)
    --2.名字和图标
    local hoI_panel = ui_widget:getChildByName("Itm_cps_Panel"):getChildByName("hoI_panel")
    local heroName = ui_widget:getChildByName("Itm_cps_Panel"):getChildByName("heroname")
    local heroframe = hoI_panel:getChildByName("")
    heroName:setString(heroObj._heroData.roleName)
end

function HeroOwnItem(_ui_widget,_pui,_cur_item,_hro_item_panel,_heroObj,_framID)  --只有前两个参数有用分别是弹出界面和本界面，后面的是为了更新上级参数  
     ui_widget = _ui_widget
     pui = _pui
     cur_item = _cur_item
     heroObj =_heroObj 
     framID = _framID 
     hro_item_panel = _hro_item_panel
     
    buttonInit()
    listInit()
end
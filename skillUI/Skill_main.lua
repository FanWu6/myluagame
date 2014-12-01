
require "src/pkg_lua/slider_scroll"

local testData 
local size = cc.Director:getInstance():getVisibleSize()
local origin = cc.Director:getInstance():getVisibleOrigin()
local skillscene
local ui_widget

local _pscroll = nil
local _pslider = nil
local _pdetail = nil
local _currentpage = 1 --当前所在页
local _sliderScale =nil  --滑动条缩放比例  (比例为可视尺寸/滑动区域尺寸)
local _itemData=nil
local menuUIinstance = nil

--对数据根据品质和id排序
local function sortLevelByType(a,b) 
    if (a._itemData.iTone == b._itemData.iTone) then
        return a._itemData.iId > b._itemData.iId
    else
        return a._itemData.iTone>b._itemData.iTone
    end
end 
--根据不同的页签获取不同的数据并排序
local function getDataByType(type)
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

function paclage_scrollInit_change(type,_page,_Name,_Num)   --背包内物品改变
    _currentpage = _page
    print("page======".._page)
    local currData = getDataByType(_currentpage-1)
    local item_num = table.maxn(currData)
    local item_id --物品id
    local item_sum --单个物品数量

    if type == "delete" then
        _pscroll:getChildByName(_Name):removeFromParent()
        if 25*2+(math.modf((item_num-1)/4))*100+55>=400 then
            _pscroll:setInnerContainerSize(cc.size(370,25*2+(math.modf((item_num-1)/4))*100+55))
        else
            _pscroll:setInnerContainerSize(cc.size(370,400))
        end

        for i=0,_pscroll:getChildrenCount()-1,1 do
            local _btn = _pscroll:getChildren()[i+1]
            local line_num = math.modf(i/4)
            _btn:setPosition(cc.p(140+(i-line_num*4-1)*90,_pscroll:getInnerContainer():getSize().height-50-line_num*100))
        end
    elseif type == "change" then
        local _btn = _pscroll:getChildByName(_Name)
        local mask = _btn:getChildByTag(10)
        mask:getChildByTag(10):setString(_Num)
    end

end

function package_scrollInit_update(_page) --背包内物品初始化
    --背包初始化
    --    local package_category=5 --背包分页
    --
    _pscroll:removeAllChildren()
    _currentpage = _page

    print("page======".._page)

    local currData = getDataByType(_currentpage-1)
    cclog("NEWNEWNEW")
    local item_num = table.maxn(currData)
    local item_id --物品id
    local item_sum --单个物品数量

    if 25*2+(math.modf((item_num-1)/4))*100+55>=400 then
        _pscroll:setInnerContainerSize(cc.size(370,25*2+(math.modf((item_num-1)/4))*100+55))
    else
        _pscroll:setInnerContainerSize(cc.size(370,400))
    end
    --测试用
    --    if _page == 2 then
    --    item_num = 10
    --    elseif _page == 3 then
    --    item_num = 4
    --    elseif _page == 4 then
    --    item_num =50
    --    elseif _page == 5 then
    --        item_num =1
    --    end

    -- 背包按钮
    local function _ptouchEvent(sender,eventType)
        local _button = sender
        if eventType == ccui.TouchEventType.began then
            cclog("tag====".. _button:getPositionX())
            _button:setScale(0.9) 
        elseif eventType == ccui.TouchEventType.moved then
            _button:setScale(1) 
        elseif eventType == ccui.TouchEventType.ended then --end操作
            _button:setScale(1) 
            --
            --end操作
            local itemID = _button:getTag()
            local currItemData = getBagDataById(itemID)
            SkillDetailInit(_pdetail,currItemData,2,_currentpage) --package_detal  层，数据，界面打开类型
            testData[1] = _pdetail
            testData[2] = currItemData
            testData[3] = 2
            testData[4] = _currentpage

            --
        elseif eventType == ccui.TouchEventType.canceled then
            _button:setScale(1) 
        end
    end  
    if 25*2+(math.modf((item_num-1)/4))*100+55>=400 then
        _pscroll:setInnerContainerSize(cc.size(370,25*2+(math.modf((item_num-1)/4))*100+55))
    else
        _pscroll:setInnerContainerSize(cc.size(370,400))
    end --设置滚动区域 (公式：20*2+（行数-1）*100+getContenSize().height)

    _pscroll:setBounceEnabled(false)
    cclog("ContainerSize=========".._pscroll:getInnerContainer():getSize().height)


    for i=0,item_num-1,1 do

        local frament,frag = ToolsgetItemIcon(currData[i+1]._itemData.iType,currData[i+1]._itemData.iTone)
        local _ccbutton = ccui.Button:create()
        _ccbutton:setTouchEnabled(true)
        _ccbutton:loadTextures(frament,frament,"")
        --_ccbutton:setPosition(cc.p(_pscroll:getInnerContainer():getSize().width-10,200)
        _ccbutton:setAnchorPoint(0.5,0.5)
        local line_num = math.modf(i/4)
        _pscroll:addChild(_ccbutton,3)
        _ccbutton:setName(currData[i+1]._itemData.iName)

        _ccbutton:setPosition(cc.p(140+(i-line_num*4-1)*90,_pscroll:getInnerContainer():getSize().height-50-line_num*100))  --坐标与ccs上的不一样，有点蛋疼就不研究了
        _ccbutton:setTag(currData[i+1]._itemData.iId)

        local  maskedCal = maskedHeroWithSprite("res/daota/"..currData[i+1]._itemData.iIcon, frament,frag,currData[i+1]._itemData.iNum)
        _ccbutton:addChild(maskedCal)
        maskedCal:setTag(10)
        maskedCal:setPosition(cc.p(_ccbutton:getContentSize().width/2,_ccbutton:getContentSize().height/2))
        _ccbutton:addTouchEventListener(_ptouchEvent)
    end

    --end
    --背包初始化结束
    --
    --
    _pslider.init(_pscroll)
    menuUIinstance:changeData()

end

local function buttonInit()
    package_scrollInit_update(1) --页面初始化（第一页）
--    --分类按钮
--    local function _ctouchEvent(sender,eventType)
--        local _button = sender
--        --        cclog("tag====".. _button:getTag()) 
--        if eventType == ccui.TouchEventType.began then
--            _button:setLocalZOrder(3)
--        elseif eventType == ccui.TouchEventType.moved then
--        --移动按钮没有操作
--        elseif eventType == ccui.TouchEventType.canceled then   
--            _button:setLocalZOrder(0)
--        elseif eventType == ccui.TouchEventType.ended then     --end之后的回调
--            for i=1,5,1 do
--                local _cbutton = ui_widget:getChildByTag(5):getChildByTag(10+i)
--                if _cbutton == _button then else _cbutton:setLocalZOrder(0)
--                end     
--        end
--        --、、、、、、
--        --分类按钮 end之后的回调
--        local _page=_button:getTag()-10
--        cclog("分页Tag==".._page.."页页页页")
--        if _page ~= _currentpage then
--            package_scrollInit_update(_page)
--            --滑动条初始化
--        end
--        --、、、、、、
--        end
--    end  
--    for i=1,5,1 do
--        local _cbutton = ui_widget:getChildByTag(5):getChildByTag(10+i)
--        _cbutton:addTouchEventListener(_ctouchEvent)
--    end
--
--    --图鉴按钮
--    local function _htouchEvent(sender,eventType)
--        if eventType == ccui.TouchEventType.ended then
--            --进入图鉴
--            print("tttt")
--            handbookLogInMain()
--        end
--    end
--    local _hbutton = ui_widget:getChildByName("package_Panel"):getChildByName("handbook_btn")
--    _hbutton:addTouchEventListener(_htouchEvent)
--    --背包滑动
--    --用事件监听会有问题
end


local function main()
    _pdetail:setVisible(false)
    _pdetail:setEnabled(false)

end



--继承BASELAYER后初始化
local LogInSKLLayer = class("LogInSKLLayer",BaseLayer)

function LogInSKLLayer.extend(target)
    local t = tolua.getpeer(target)
    if not t then
        t = {}
        tolua.setpeer(target, t)
    end
    setmetatable(t, LogInSKLLayer)
    return target
end

function LogInSKLLayer:onEnter()
    cclog("LogInSKLLayer:onEnter")
    --菜单初始化
    menuUIinstance = menuUI:createmenuUI("close",true)
    menuUIinstance:setName("menuUIinstance")
    ui_widget:addChild(menuUIinstance,10)
    --按钮初始化
--    if testData[1]== nil then
        buttonInit()
--    end
--
--    if testData[1] ~= nil then
--        DetailInit(testData[1],testData[2],testData[3],testData[4])
--        _pscroll:getInnerContainer():setPositionY(testData[5])
--    end
end

function LogInSKLLayer:onExit()
    cclog("LogInSKLLayer:onExit")
--
    local eventDispatcher = self:getEventDispatcher()
    eventDispatcher:removeEventListener(self._listener)
--
    menuUIinstance= nil
    ui_widget:getChildByName("menuUIinstance"):removeFromParent()
--
--    testData[5] = _pscroll:getInnerContainer():getPositionY()
end

function LogInSKLLayer:init()
    cclog("LogInSKLLayer:init")
end

function LogInSKLLayer.create()
    local layer = LogInSKLLayer.extend(cc.Layer:create())
    cclog("LogInSKLLayer:create")

    if nil ~= layer then
        layer:init()
        local function onNodeEvent(event)
            --enterTransitionFinish

            if "enter" == event then
                layer:onEnter()
            elseif "exit" == event then
                layer:onExit()
            end
        end
        layer:registerScriptHandler(onNodeEvent)
    end

    return layer
end
--继承BASELAYER后初始化 end
function skillLogInMain()
    --runFucn

    local function runFunc()
        testData ={nil}
        local _uilayer = LogInSKLLayer.create()
        skillscene:addChild(_uilayer)
        ui_widget = ccs.GUIReader:getInstance():widgetFromJsonFile("res/Skill_UI/Skill_UI.json")
        print("LOGIN")
        _uilayer:addChild(ui_widget)

        _pscroll = ui_widget:getChildByTag(5):getChildByTag(101) --背包滑动层
        _pdetail = ui_widget:getChildByTag(6) --背包详细信息
        local bg = "res/BagUI_1/bag/scroll_bar_b.png"
        local ps = "res/BagUI_1/bag/scroll_bar_b.png"
        local ts = "res/BagUI_1/bag/scroll_ba.png"
        _pslider = scrollSliderCreate()
        local slider = _pslider:Create(bg,ps,ts,_pscroll)
        ui_widget:addChild(slider)
        slider:setPosition(500,320)
        slider:setScale(1.2,1)

        main()
    end
--    --run
--    skillscene = cc.Scene:create()
--    if cc.Director:getInstance():getRunningScene() then
--        if _uisceneStack[table.maxn(_uisceneStack)] ~= "skillscene" then
--            pushUIScene(skillscene,"skillscene")
--            runFunc()
--           print("xxaasdasdasdas")
--        end
--    else
--        cc.Director:getInstance():runWithScene(skillscene)
--    end

    skillscene = cc.Scene:create()
    if cc.Director:getInstance():getRunningScene() then
        cc.Director:getInstance():replaceScene(skillscene)
        runFunc()
       
    else
        cc.Director:getInstance():runWithScene(skillscene)
        runFunc()
    end

end


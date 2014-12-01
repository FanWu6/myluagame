require "src/shop/ShopBuy"

local ui_widget
local SenceShopTest
local shopList
local menuUIinstance = nil


function SceneShopMain()
    shopList = shopItemData
    print("商店数据刷新======"..table.maxn(shopList))

    local refreshBtn = ui_widget:getChildByName("shopRefreshBtn")
    
    local shopMainPanel = ui_widget:getChildByName("shopMainPanel")
    local shopBuyPanel = ui_widget:getChildByName("shopBuyPanel") 
    local shopListPanel = shopMainPanel:getChildByName("shopListPanel")    
--    local shopList = {{1,"经验药水",1,1000,1,"101.jpg"},{2,"灵魂石",2,2000,2,"102.jpg"},{3,"长笛卷轴",3,3000,1,"107.jpg"},{4,"梅肯卷轴",4,4000,2,"104.jpg"},{5,"远古遗物",5,5000,1,"105.jpg"},{6,"圣殿指环",6,6000,2,"106.jpg"},{7,"力量拳套",7,7000,1,"107.jpg"},{8,"法力之球",8,8000,2,"108.jpg"},{9,"防御指环",3,3000,1,"109.jpg"},{10,"经验耐闹",4,4000,2,"110.jpg"},{11,"小毒球",5,5000,1,"111.jpg"},{12,"贵族头欢",6,6000,2,"112.jpg"}}
    
    --数组--id,name,num,price,type 1：金币 2：钻石,iconImage
    
    local function itemPanelHandle(sender,eventType)
        local _button = sender
        if eventType == ccui.TouchEventType.began then
            _button:setScale(0.9)
        elseif eventType == ccui.TouchEventType.canceled then   
            _button:setScale(1)
        elseif eventType == ccui.TouchEventType.ended then     --end之后的回调
            _button:setScale(1)
            local itemId = _button:getTag();
            openBuyPanel(shopBuyPanel,itemId,menuUIinstance)
        end
    end
    print("测试-------------=="..table.maxn(shopList))
    if table.maxn(shopList)<7 and shopListPanel:getChildByName("itemPanel_"..7) ~= nil  then
        for j=7,12,1 do
            local xx = shopListPanel:getChildByName("itemPanel_"..j)
            xx:removeFromParent()
        end
        shopListPanel:setInnerContainerSize(cc.size(800,380))
    end
    
    for i=1, table.maxn(shopList) do
        
        local shopItem = shopList[i]
        local itemPanel = shopListPanel:getChildByName("itemPanel_"..i)
        itemPanel:setTag(shopItem._itemData.iId)
        local itemId = itemPanel:getTag()
       
        
       
        --1、名字与数量
        local nameText = itemPanel:getChildByName("nameText") 
        if shopItem._itemData.iNum > 1 then
            nameText:setString(shopItem._itemData.iName.." X "..shopItem._itemData.iBuyNum)
        else
            nameText:setString(shopItem._itemData.iName)
        end
        
        local goldText = itemPanel:getChildByName("goldText")
        
    --1 钻石
    --2 金币
    --3 龙鳞币
    --4 角斗士币
        
        --2.价格与货币种类
        if shopItem._itemData.iBuyType == 1 then   
            local goldIcon = itemPanel:getChildByName("goldIcon")
            goldIcon:loadTexture("res/data/ShopUI_1/shop_token_icon.png")
            goldText:setString(shopItem._itemData.iSellPrice)
        elseif shopItem._itemData.iBuyType == 2 then
            goldText:setString(shopItem._itemData.iSellPrice)
        elseif shopItem._itemData.iBuyType == 3 then
        
        elseif shopItem._itemData.iBuyType == 4 then
        
        end
        
       --3.品质
        local frament,frag = ToolsgetItemIcon(shopItem._itemData.iType,shopItem._itemData.iTone)
--        local _ccbutton = ccui.Button:create()
        local _ccbutton = itemPanel:getChildByName("frame")
        _ccbutton:loadTexture(frament)
        _ccbutton:setEnabled(false)
--        _ccbutton:setPosition(130,100)
--        itemPanel:addChild(_ccbutton)
        _ccbutton:removeAllChildren()
        
        local icon
        if shopItem._itemData.iType == 3 then
                icon = "res/daota/Axe"
        else
            icon = "res/daota/"..shopItem._itemData.iIcon
        end
        local  maskedCal = maskedHeroWithSprite(icon, frament,frag,shopItem._itemData.iNum)
        _ccbutton:addChild(maskedCal)
        maskedCal:setPosition(cc.p(_ccbutton:getContentSize().width/2,_ccbutton:getContentSize().height/2))
        itemPanel:addTouchEventListener(itemPanelHandle)
--        _ccbutton:addTouchEventListener(itemPanelHandle)
        
        --4.是否卖光
        local currMask = itemPanel:getChildByName("currMask")
        if shopItem._itemData.iState == 1 then -- 卖光了
            currMask:setVisible(true)
            itemPanel:setEnabled(false)
        else
            currMask:setVisible(false)
            itemPanel:setEnabled(true)
        end
    end
 end



--//添加售罄遮罩
function addImageToBtn(_itemId)--添加遮罩
    local shopListPanel = ui_widget:getChildByName("shopMainPanel"):getChildByName("shopListPanel")  
    local itemPanel = shopListPanel:getChildByTag(_itemId)
    local currMask = itemPanel:getChildByName("currMask")
    currMask:setVisible(true)
    itemPanel:setEnabled(false)
end


--
local function buttonInit()
    local function shoprefresh()
    end

    local refreshbutton = ui_widget:getChildByName("shopMainPanel"):getChildByName("shopRefreshBtn")
    local function refreshHandle(sender,eventType)
        local _button = sender
        if eventType == ccui.TouchEventType.began then
            _button:setScale(0.9)
        elseif eventType == ccui.TouchEventType.canceled then   
            _button:setScale(1)
        elseif eventType == ccui.TouchEventType.ended then     --end之后的回调
            _button:setScale(1)
            local function fuc1()
                CG_HANDLER_RefreshShopFee(1)
            end

            local function fuc2()
                --                shopList = shopItemData
--                SceneShopMain()
                print("跑不跑")
            end
--            CG_HANDLER_RefreshShopFee(1)
--            SceneShopMain()
            sender:runAction(cc.Sequence:create(cc.CallFunc:create(fuc1),cc.CallFunc:create(fuc2)))
        end
    end

    refreshbutton:addTouchEventListener(refreshHandle)
end


local LogInShopLayer = class("LogInShopLayer",BaseLayer)

function LogInShopLayer.extend(target)
    local t = tolua.getpeer(target)
    if not t then
        t = {}
        tolua.setpeer(target, t)
    end
    setmetatable(t, LogInShopLayer)
    return target
end

function LogInShopLayer:onEnter()
    cclog("LogInShopLayer:onEnter")
    
    --菜单初始化
    menuUIinstance = menuUI:createmenuUI("close",true)
    menuUIinstance:setName("menuUIinstance")
    menuUIinstance:changeData()
    ui_widget:addChild(menuUIinstance,10)
end

function LogInShopLayer:onExit()
    cclog("LogInShopLayer:onExit")
    
    menuUIinstance= nil
    ui_widget:getChildByName("menuUIinstance"):removeFromParent()
end

function LogInShopLayer:init()
    cclog("LogInShopLayer:init")

end

function LogInShopLayer.create()
    local layer = LogInShopLayer.extend(cc.Layer:create())
    cclog("LogInShopLayer:create")

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

------------------------------------






------------------------------------- 
--SceneLogInMain
-------------------------------------
function ShopLogInMain()
    --runFunc
    local function runFunc()
        local _uilayer = LogInShopLayer.create()
        ui_widget = ccs.GUIReader:getInstance():widgetFromJsonFile("res/data/ShopUI_1/ShopUI_1.json")
        SenceShopTest:addChild(_uilayer)
        _uilayer:addChild(ui_widget)
--        getShopData()
        SceneShopMain()
        buttonInit()
    end
    --run
    SenceShopTest= cc.Scene:create()
    if cc.Director:getInstance():getRunningScene() then
        if _uisceneStack[table.maxn(_uisceneStack)] ~= "SenceShopTest" then
            pushUIScene(SenceShopTest,"SenceShopTest")
            runFunc()
        end
    else
        cc.Director:getInstance():runWithScene(SenceShopTest)
    end
  
    
end
 

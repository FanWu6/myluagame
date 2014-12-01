local ui_widget
local rechargeDiamondInstance = nil
local rechargeDiamondState
local rechargeDiamondScene = {}; 
local num
local state = 0
local menuUIinstance

local showData = {
    {id = 1,name = "300钻石月度礼包",price="25元",desc="连续30天每天可领120钻石",icon="recharge_monthlycard.png",isLimit = 0,isRecommend = 1,isBuy = 0,iDiamond = 300},
    {id = 2,name = "20000钻石",price="1998元",desc="另赠送5000钻石",icon="recharge_diamond_icon_8.png",isLimit = 1,isRecommend = 1,isBuy = 0,iDiamond = 20000},
    {id = 3,name = "6480钻石",price="648元",desc="另赠送1620钻石",icon="recharge_diamond_icon_7.png",isLimit = 0,isRecommend = 1,isBuy = 0,iDiamond = 6480},
    {id = 4,name = "3280钻石",price="328元",desc="另赠送600钻石",icon="recharge_diamond_icon_6.png",isLimit = 1,isRecommend = 1,isBuy = 0,iDiamond = 3280},
    {id = 5,name = "1980钻石",price="198元",desc="另赠送240钻石",icon="recharge_diamond_icon_5.png",isLimit = 0,isRecommend = 0,isBuy = 0,iDiamond = 1980},
    {id = 6,name = "980钻石",price="98元",desc="另赠送80钻石",icon="recharge_diamond_icon_4.png",isLimit = 1,isRecommend = 0,isBuy = 0,iDiamond = 980},
    {id = 7,name = "300钻石",price="30元",desc="另赠送15钻石",icon="recharge_diamond_icon_3.png",isLimit = 0,isRecommend = 0,isBuy = 0,iDiamond = 300},
    {id = 8,name = "60钻石",price="6元",desc="无",icon="recharge_diamond_icon_2.png",isLimit = 0,isRecommend = 0,isBuy = 0,iDiamond = 60}
}


rechargeDiamondScene.new = function(self) 
    local o = { --可以在此处添加数据
        }; 
    setmetatable(o,self); 
    self.__index = self; 
    return o; 
end

--更新vip充值界面
local function updateVipListPanel()
    local _scrollView = ui_widget:getChildByName("chargeScrollView")
    for i=1,table.maxn(showData),1 do
        local chargeBtn = _scrollView:getChildByName("chargeBtn_"..i)
        local nameTxt = chargeBtn:getChildByName("nameTxt")
        local priceTxt = chargeBtn:getChildByName("priceTxt")
        local descTxt = chargeBtn:getChildByName("descTxt")
        local data = showData[i]
        chargeBtn:setTag(data.iDiamond)
        nameTxt:setString(data.name)
        priceTxt:setString(data.price)
        descTxt:setString(data.desc)
        
        local icon = ccui.ImageView:create("res/jumpSceneUI/"..data.icon)
        chargeBtn:addChild(icon)
        icon:setPosition(cc.p(70,66))
        icon:setEnabled(false)
        if data.isRecommend == 1 then --是否推荐
            local recommend = ccui.ImageView:create("res/jumpSceneUI/recharge_recommende.png")
            chargeBtn:addChild(recommend)
            recommend:setPosition(cc.p(37,96))
            recommend:setEnabled(false)
        end
        
        local function chargeBtnHandle(sender,eventType)
            if eventType == ccui.TouchEventType.began then
                sender:setScale(0.95)
            elseif eventType == ccui.TouchEventType.moved then
                sender:setScale(0.95)
            elseif eventType == ccui.TouchEventType.canceled then
                sender:setScale(1.0)
            elseif eventType == ccui.TouchEventType.ended then 
                sender:setScale(1.0)
                
                local function Diamondfunc()
                    changeUserDataToken(sender:getTag(),1)
                    if menuUIinstance ~= nil then
                        menuUIinstance:changeData()
                    end
                end
                SET_CallBack(PACKET_GC_DiamondRecharge,Diamondfunc)
                CG_HANDLER_DiamondRecharge(sender:getTag())
            end
        end
        chargeBtn:addTouchEventListener(chargeBtnHandle)
    end
end



--滚动之后左右按钮的判断
local function scrollVipInfoPanel(currPage)
    local leftBtnLayer = ui_widget:getChildByName("vipInfoPanel"):getChildByName("leftBtnPanel")
    local rightBtnLayer = ui_widget:getChildByName("vipInfoPanel"):getChildByName("rightBtnPanel")
    local leftVipTxt = ui_widget:getChildByName("vipInfoPanel"):getChildByName("leftBtnPanel"):getChildByName("vipNum")
    local rightVipTxt = ui_widget:getChildByName("vipInfoPanel"):getChildByName("rightBtnPanel"):getChildByName("vipNum")
    
    if currPage == 1 then
        leftBtnLayer:setVisible(false)
        rightBtnLayer:setVisible(true)
        rightVipTxt:setString(currPage+1)
    elseif currPage == 15 then
        rightBtnLayer:setVisible(false)
        leftBtnLayer:setVisible(true)
        leftVipTxt:setString(currPage-1)
    else
        leftBtnLayer:setVisible(true)
        rightBtnLayer:setVisible(true)
        rightVipTxt:setString(currPage+1)
        leftVipTxt:setString(currPage-1)
    end

end

local function pageViewEvent(sender, eventType)
    if eventType == ccui.PageViewEventType.turning then
        local pageView = ui_widget:getChildByName("vipInfoPanel"):getChildByName("contentPageView")
        local currPage = (pageView:getCurPageIndex() + 1)
        scrollVipInfoPanel(currPage)
    end
end 

--更新vip等级详细信息说明界面
local function updateVipInfoPanel()
    local pageView = ui_widget:getChildByName("vipInfoPanel"):getChildByName("contentPageView")
    pageView:setTouchEnabled(true)
    for i=1,15,1 do
        local layout = ccui.Layout:create()
        layout:setSize(cc.size(520, 321))
        layout:setPosition(10,0)
        for j=1,9,1 do
            local label = ccui.Text:create()
            label:setString("每天购买xxx"..j.."次")
            label:setFontSize(20)
            label:setColor(cc.c3b(252, 201, 25))
--            label:setPosition(cc.p(200, 30*j))
            label:setPosition(cc.p(layout:getSize().width / 2, 30*j))
            layout:addChild(label)
        end
        pageView:addPage(layout)
    end
    
    pageView:addEventListenerPageView(pageViewEvent)
    scrollVipInfoPanel(1)
    pageView:scrollToPage(0)
    local vipNum = ui_widget:getChildByName("vipInfoPanel"):getChildByName("titilePanel"):getChildByName("vipNum")
    vipNum:setString("1")
    
end

rechargeDiamondScene.init = function(self,num)
    updateVipListPanel()
end

--切换隐藏界面
local function changeHidePanel()
    local _scrollView = ui_widget:getChildByName("chargeScrollView")
    local _vipInfoView = ui_widget:getChildByName("vipInfoPanel")
    local chargeBtn = ui_widget:getChildByName("bg"):getChildByName("chargeBtn")
    
    if state == 1 then
        _scrollView:setVisible(false)
        _vipInfoView:setVisible(true)
        chargeBtn:setTitleText("充值")
        updateVipInfoPanel()
        state = 0
    else
        _scrollView:setVisible(true)
        _vipInfoView:setVisible(false)
        chargeBtn:setTitleText("特权")
        updateVipListPanel()
        state = 1
    end

end

 rechargeDiamondScene.buttonInit = function(self,num)
 
    local closeBtn = ui_widget:getChildByName("closeBtn")
    local chargeBtn = ui_widget:getChildByName("bg"):getChildByName("chargeBtn")
    
    local leftBtn = ui_widget:getChildByName("vipInfoPanel"):getChildByName("leftBtnPanel"):getChildByName("upBtn")
    local rightBtn = ui_widget:getChildByName("vipInfoPanel"):getChildByName("rightBtnPanel"):getChildByName("downBtn")
    
    
    local function _closeHandle(sender,eventType)
        if eventType == ccui.TouchEventType.ended then 
            print("关闭充值界面")
            ui_widget:removeFromParent()
        end
    end
    closeBtn:addTouchEventListener(_closeHandle)
    
    local function _chargeHandle(sender,eventType)
        if eventType == ccui.TouchEventType.began then
                sender:setScale(0.95)
            elseif eventType == ccui.TouchEventType.moved then
                sender:setScale(0.95)
            elseif eventType == ccui.TouchEventType.canceled then
                sender:setScale(1.0)
            elseif eventType == ccui.TouchEventType.ended then 
                sender:setScale(1.0)
                print("切换充值界面")
                changeHidePanel()
        end
    end
    chargeBtn:addTouchEventListener(_chargeHandle)
    changeHidePanel()
    
    local function _leftBtnHandle(sender,eventType)
        if eventType == ccui.TouchEventType.ended then 
           local infoPageView = ui_widget:getChildByName("vipInfoPanel"):getChildByName("contentPageView")
           
            if infoPageView:getCurPageIndex()>=1 then
               
               local page = infoPageView:getCurPageIndex() - 1
               infoPageView:scrollToPage(page)
               local vipNum = ui_widget:getChildByName("vipInfoPanel"):getChildByName("titilePanel"):getChildByName("vipNum")
               
                    vipNum:setString(page+1)
            end
        end
    end
    leftBtn:addTouchEventListener(_leftBtnHandle)
    
    local function _rightBtnHandle(sender,eventType)
        if eventType == ccui.TouchEventType.ended then 
            local infoPageView = ui_widget:getChildByName("vipInfoPanel"):getChildByName("contentPageView")
            if infoPageView:getCurPageIndex()<15 then
                local page = infoPageView:getCurPageIndex() + 1
                infoPageView:scrollToPage(page)
                local vipNum = ui_widget:getChildByName("vipInfoPanel"):getChildByName("titilePanel"):getChildByName("vipNum")
                if (page+1) >= 15 then
                    vipNum:setString("15")
                else
                    vipNum:setString(page+1)
                end
                
            end
        end
    end
    rightBtn:addTouchEventListener(_rightBtnHandle)
 end

rechargeDiamondScene.Create = function(self)
    ui_widget = ccs.GUIReader:getInstance():widgetFromJsonFile("res/jumpSceneUI/rechargeDiamond.json")
    rechargeDiamondState = "rechargeDiamond"
    num =2
    state = 0
    rechargeDiamondScene.buttonInit(self,num)
    rechargeDiamondScene.init(self,num)
    return ui_widget
end

function rechargeDiamondSceneCreate(_menuUIinstance)
    -- body
    menuUIinstance = _menuUIinstance
    rechargeDiamondInstance = rechargeDiamondScene:new()
    return rechargeDiamondInstance
end
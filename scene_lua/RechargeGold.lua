local menuUIinstance
local vipNum

local ui_widget
local rechargeGoldInstance = nil
local rechargeGoldState
local rechargeGoldScene = {}; 
local num
local info_prototype

rechargeGoldScene.new = function(self) 
    local o = { --可以在此处添加数据
        }; 
    setmetatable(o,self); 
    self.__index = self; 
    return o; 
end


local function updateVipNum()
    vipNum = userMidasFee["_uGoldMakesum"]-userMidasFee["_uGoldMake"]
--    vipNum = userMidasFee["_uGoldMake"]
    local rechargePanel = ui_widget:getChildByName("RechargeGold")
    local goldInfoPanel = rechargePanel:getChildByName("goldInfoPanel") --使用/连续使用界面
    local txtInfoPanel =  rechargePanel:getChildByName("txtInfoPanel") -- 查看vip界面
    local numTxt = rechargePanel:getChildByName("numTxt")       --已使用次数
    local allNumTxt = rechargePanel:getChildByName("allNumTxt") --总次数
    local useBtn = rechargePanel:getChildByName("useBtn")
    local cUseBtn = rechargePanel:getChildByName("cUseBtn")
    
    if vipNum <= 0 then
    
        numTxt:setString(userMidasFee["_uGoldMakesum"])
    else
        numTxt:setString(vipNum)
    end
    allNumTxt:setString("/"..userMidasFee["_uGoldMakesum"]..")")
    local diamond = goldInfoPanel:getChildByName("jewelTxt")
    local gold = goldInfoPanel:getChildByName("goldTxt")
    diamond:setString(userMidasFee["_Makediamond"])                    --钻石  
    gold:setString(userMidasFee["_Makediagold"])                       --金币

    

    if vipNum >= 1 then
        numTxt:setColor(cc.c3b(232,198,109))
        goldInfoPanel:setVisible(true)
        txtInfoPanel:setVisible(false)
    else
        numTxt:setColor(cc.c3b(250,9,13))
        goldInfoPanel:setVisible(false)
        txtInfoPanel:setVisible(true)
    end
    
    
end


local function showInfoPanel(data)
    local infoPanel = ui_widget:getChildByName("infoPanel") 
    infoPanel:setVisible(true)
    local _listView = infoPanel:getChildByName("infoListView")
        for i=1,table.maxn(userMidasUse),1 do
            local item = info_prototype:clone()
            _listView:pushBackCustomItem(item)
            item:getChildByName("useInfoTxt"):setString("使用")
            item:getChildByName("getInfoTxt"):setString("获得")
            item:getChildByName("diamondImg"):loadTexture("res/jumpSceneUI/task_rmb_icon_.png")
        item:getChildByName("goldImg"):loadTexture("res/jumpSceneUI/task_gold_icon_.png")
            item:getChildByName("txtDiamond"):setString(userMidasUse[i]["_Makediamond"])    --需要钻石
            item:getChildByName("txtGold"):setString(userMidasUse[i]["_Makediagold"])     --获得金币
        end
     updateVipNum()
end

rechargeGoldScene.buttonInit = function(self,num)

    local rechargePanel = ui_widget:getChildByName("RechargeGold")
    local useBtn = rechargePanel:getChildByName("goldInfoPanel"):getChildByName("useBtn")
    local cUseBtn = rechargePanel:getChildByName("goldInfoPanel"):getChildByName("cUseBtn")
    local closeBtn = rechargePanel:getChildByName("closeBtn")
    local lookVipBtn = rechargePanel:getChildByName("txtInfoPanel"):getChildByName("useBtn")
    
    
    local function _closeHandle(sender,eventType)
        if eventType == ccui.TouchEventType.ended then 
            print("关闭点金手")
            currUseNum = 0
            ui_widget:removeFromParent()
        end
    end
    closeBtn:addTouchEventListener(_closeHandle)
    
    local function _useBtnHandle(sender,eventType)
        if eventType == ccui.TouchEventType.ended then 
            print("使用点金手")
           --获取钻石   获取金币
           if  useBtn:getTitleText() == "查看VIP"  then
                local rechargeDiamond = rechargeDiamondSceneCreate(menuUIinstance):Create()
                ui_widget:addChild(rechargeDiamond,10,10)
           else 
           
                local changeToken = function(_result)
                    if _result == 10000 then
                            if menuUIinstance ~= nil then
                                menuUIinstance:changeData()
                            end
                            --更新面板次数
                            showInfoPanel(userMidasUse)
                            updateVipNum()
                    elseif _result == 13022 then
                        local xx = DialogshowDialogPanel(13022)
                        cc.Director:getInstance():getRunningScene():addChild(xx,101)
                    end
                 end
--                end
                SET_CallBack(PACKET_GC_MidasTouchUse,changeToken) 
                CG_HANDLER_MidasTouchUse(1)
            end
        end
    end
    useBtn:addTouchEventListener(_useBtnHandle)
    
    
    local function _lookVipBtnHandle(sender,eventType)
        if eventType == ccui.TouchEventType.ended then 
            print("点击打开VIP界面")
            
            local rechargeDiamond = rechargeDiamondSceneCreate(menuUIinstance):Create()
            ui_widget:addChild(rechargeDiamond,10,10)
        end
    end
    lookVipBtn:addTouchEventListener(_lookVipBtnHandle)
    
    local function _cUseBtnHandle(sender,eventType)
        if eventType == ccui.TouchEventType.ended then 
            print("连续使用点金手")
            --获取钻石   获取金币
            if  useBtn:getTitleText() == "查看VIP"  then
                local rechargeDiamond = rechargeDiamondSceneCreate(menuUIinstance):Create()
                ui_widget:addChild(rechargeDiamond,10,10)
            else 
                local changeToken = function(_result)
                    if _result == 10000 then
                        if menuUIinstance ~= nil then
                            menuUIinstance:changeData()
                        end
                        --更新面板次数
                        showInfoPanel(userMidasUse)
                        updateVipNum()
                    elseif _result == 13022 then
                        local xx = DialogshowDialogPanel(13022)
                        cc.Director:getInstance():getRunningScene():addChild(xx,101)
                    end
                end
                --                end
                SET_CallBack(PACKET_GC_MidasTouchUse,changeToken) 
                CG_HANDLER_MidasTouchUse(3)
            end
            
--            for i=1,3,1 do
--                local _data = getDataByNum(currUseNum+i)
--                local booltype = changeUserDataToken(_data[2],2)
--                if booltype then
--                        changeUserDateGold(_data[1],1)
--                        changeGoldMakeNum()
--                        if menuUIinstance ~= nil then
--                            menuUIinstance:changeData()
--                        end
--                        data[i] = _data
--                end
--                    showInfoPanel(userMidasUse)
--                    updateVipNum()
--            end
        end
    end
    cUseBtn:addTouchEventListener(_cUseBtnHandle)
    
end


rechargeGoldScene.init = function(self,_num)
    
    local rechargePanel = ui_widget:getChildByName("RechargeGold")
    local infoPanel = ui_widget:getChildByName("infoPanel")
    infoPanel:setVisible(false)
    local _listView = infoPanel:getChildByName("infoListView")
    
    info_prototype = ui_widget:getChildByName("goldModel")
    --添加点金手图片
    local frament,frag = ToolsgetItemIcon(1,1)
    local  maskedCal = maskedHeroWithSprite("res/jumpSceneUI/midas_icon",frament,frag,1)
    rechargePanel:addChild(maskedCal);
    maskedCal:setPosition(cc.p(rechargePanel:getContentSize().width/2-200,rechargePanel:getContentSize().height/2+190))
    updateVipNum()
end



rechargeGoldScene.Create = function(self)
    ui_widget = ccs.GUIReader:getInstance():widgetFromJsonFile("res/jumpSceneUI/rechargeGold.json")
    rechargeGoldState = "rechargeGold"
    num =2
    vipNum = userMidasFee["_uGoldMakesum"]-userMidasFee["_uGoldMake"]
    rechargeGoldScene.init(self,num)
    rechargeGoldScene.buttonInit(self,num)

    return ui_widget
end

function rechargeGoldSceneCreate(_menuUIinstance)
    -- body
    menuUIinstance = _menuUIinstance
    rechargeGoldInstance = rechargeGoldScene:new()

    return rechargeGoldInstance

end
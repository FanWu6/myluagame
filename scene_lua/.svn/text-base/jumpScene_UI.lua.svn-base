menuUI = class("menuUI")
menuUI.__index = menuUI

local menuinstance
local ui
menuUI._menuStage = nil--(1:打开，2：闭合)
menuUI._menuType = nil --(是否带黑色遮罩)
menuUI.menubtn = nil
menuUI.heroBtn = nil 
menuUI.pkgBtn = nil
menuUI.fragBtn = nil
menuUI.taskBtn  = nil
menuUI.todoBtn  = nil

menuUI.btn_Panel = nil
menuUI._menubg = nil

menuUI.backBtn = nil

menuUI.goldBtn = nil
menuUI.diamondBtn = nil 
menuUI.vatalityBtn = nil

menuUI.UserInfo = nil

function menuUI:extend(target)  
    local t = tolua.getpeer(target)  
    if not t then  
        t = {}  
        tolua.setpeer(target, t)  
    end  
    setmetatable(t, menuUI)  
    return target  
end  

function menuUI:menuChangeAction()  --状态改变
    --按钮遮罩
    local function maskVis()
        if self._menuType then
            if self._menuStage == "close" then
                local menuMask = ui:getChildByName("menuMask_Panel")
                menuMask:setVisible(false)
            elseif self._menuStage == "open" then
                local menuMask = ui:getChildByName("menuMask_Panel")
                menuMask:setVisible(true)
            end
        end
    end

    if self._menuStage == "close" and self.heroBtn:getPositionY() == self.menubtn:getPositionY()+200 then --and heroBtn:getPositionY() == -115
        self.menubtn:loadTextures("res/jumpSceneUI/main_up_button.png","res/jumpSceneUI/main_up_button.png","")
        local x = self.menubtn:getPositionX()

        local action1 = cc.EaseBackOut:create(cc.MoveTo:create(0.3,cc.p(x,495)))
        local action2 = cc.EaseBackOut:create(cc.MoveTo:create(0.3,cc.p(x,495-100)))
        local action3 = cc.EaseBackOut:create(cc.MoveTo:create(0.3,cc.p(x,495-100*2)))
        local action4 = cc.EaseBackOut:create(cc.MoveTo:create(0.3,cc.p(x,495-100*3)))
        local action5 = cc.EaseBackOut:create(cc.MoveTo:create(0.3,cc.p(x,495-100*4)))
        local fade1 = cc.FadeIn:create(0.3)
        local function VisibleTrue(btn)
--            btn:setVisible(true)
        end

        self.heroBtn:runAction(cc.Sequence:create(cc.DelayTime:create(0.09),action1,VisibleTrue(self.heroBtn)))
        self.pkgBtn:runAction(cc.Sequence:create(cc.DelayTime:create(0.07),action2,VisibleTrue(self.pkgBtn)))
        self.fragBtn:runAction(cc.Sequence:create(cc.DelayTime:create(0.05),action3,VisibleTrue(self.fragBtn)))
        self.taskBtn:runAction(cc.Sequence:create(cc.DelayTime:create(0.03),action4,VisibleTrue(self.taskBtn)))
        self.todoBtn:runAction(cc.Sequence:create(cc.DelayTime:create(0.0),action5,VisibleTrue(self.todoBtn)))
       
        self.heroBtn:runAction(cc.Sequence:create(cc.DelayTime:create(0.09),fade1))
        self.pkgBtn:runAction(cc.Sequence:create(cc.DelayTime:create(0.07),fade1:clone()))
        self.fragBtn:runAction(cc.Sequence:create(cc.DelayTime:create(0.05),fade1:clone()))
        self.taskBtn:runAction(cc.Sequence:create(cc.DelayTime:create(0.03),fade1:clone()))
        self.todoBtn:runAction(cc.Sequence:create(cc.DelayTime:create(0.0),fade1:clone()))

        local action6 = cc.EaseBounceOut:create(cc.ScaleTo:create(0.3,1,1))
        self._menubg:runAction(action6)
        self._menuStage = "open"
        maskVis()
elseif self._menuStage == "open" and self.heroBtn:getPositionY() == 495 then --and heroBtn:getPositionY() == menubtn:getPositionY()+20
    self.menubtn:loadTextures("res/jumpSceneUI/main_down_button.png","res/jumpSceneUI/main_down_button.png","")
    local x = self.menubtn:getPositionX()
    local y = self.menubtn:getPositionY()+200

    local action1 = cc.EaseBackIn:create(cc.MoveTo:create(0.3,cc.p(x,y)))
    local fade1 = cc.EaseBounceOut:create(cc.FadeOut:create(0.3))
    local function VisibleFalse(btn)
    --           btn:setVisible(false)
    end

    self.heroBtn:runAction(cc.Sequence:create(cc.DelayTime:create(0.09),action1:clone(),VisibleFalse(self.heroBtn)))
    self.pkgBtn:runAction(cc.Sequence:create(cc.DelayTime:create(0.07),action1:clone(),VisibleFalse(self.pkgBtn)))
    self.fragBtn:runAction(cc.Sequence:create(cc.DelayTime:create(0.05),action1:clone(),VisibleFalse(self.fragBtn)))
    self.taskBtn:runAction(cc.Sequence:create(cc.DelayTime:create(0.03),action1:clone(),VisibleFalse(self.taskBtn)))
    self.todoBtn:runAction(cc.Sequence:create(cc.DelayTime:create(0.0),action1,VisibleFalse(self.todoBtn)))

    self.heroBtn:runAction(cc.Sequence:create(cc.DelayTime:create(0.09),fade1))
    self.pkgBtn:runAction(cc.Sequence:create(cc.DelayTime:create(0.07),fade1:clone()))
    self.fragBtn:runAction(cc.Sequence:create(cc.DelayTime:create(0.05),fade1:clone()))
    self.taskBtn:runAction(cc.Sequence:create(cc.DelayTime:create(0.03),fade1:clone()))
    self.todoBtn:runAction(cc.Sequence:create(cc.DelayTime:create(0.0),fade1:clone()))
    local action6 = cc.EaseBackIn:create(cc.ScaleTo:create(0.3,1,0))
    self._menubg:runAction(action6)
    self._menuStage = "close"
        maskVis()
end
end

function menuUI:changeData()
    --   if type == "gold" then
    local gold_num = ui:getChildByName("gold"):getChildByName("gold_num")
    gold_num:setString(MyUserData._userData._uGold)
    --    elseif type == "diamond" then
    local diamond_num = ui:getChildByName("diamond"):getChildByName("diamond_num")
    diamond_num:setString(MyUserData._userData._uJewel)
    --    elseif type == "vatality" then
    local vatality_num = ui:getChildByName("vatality"):getChildByName("vatality_num")
    vatality_num:setString(MyUserData._userData._uPP)
    local vatality_sum = ui:getChildByName("vatality"):getChildByName("vatality_sum")
    vatality_sum:setString("/"..MyUserData._userData._uPhysical)
    --    end
    

end


function menuUI:changeUserData()
    --更改名字
    self.UserInfo:getChildByName("UserName_btn"):setTitleText(MyUserData._userData._uName)
    --更改头像
    if self.UserInfo:getChildByTag(419)then
        self.UserInfo:getChildByTag(419):removeFromParent()
        print("删掉之前的--------")
    end
    
    local frag = "res/userInfo/main_head_frame_silver.png"
    local frament = "res/userInfo/main_head_mas.png"
    local  maskedCal = maskedHeroWithSprite("res/userInfo/head/"..MyUserData._userData._uIcon,frament,frag,1)
    self.UserInfo:addChild(maskedCal)
    maskedCal:setPosition(cc.p(52,24))
    maskedCal:setTag(419)
    --更改等级
    self.UserInfo:getChildByName("UserLvl"):setString(MyUserData._userData._uLevel)
    --更改VIP
end


function reChargeGoldPanel(_menuinstance)
    local Mins = _menuinstance or menuUI
    print("打开点金手")
    local rechargeGold = rechargeGoldSceneCreate(Mins):Create()
    return rechargeGold
end

function reChargeDiamondPanel(_menuinstance)
    local Mins = _menuinstance or menuUI
    print("打开购买钻石")
    local rechargeDiamond = rechargeDiamondSceneCreate(Mins):Create()
    return rechargeDiamond
end


function reChargePower(_menuinstance)
    local Mins = _menuinstance or menuinstance
    Mins:changeData()
end


function menuUI:init(state)
    local function _menuTouchEvent(sender,eventType)
        if eventType == ccui.TouchEventType.began then
        --            shop_light:setVisible(true)
        elseif eventType == ccui.TouchEventType.moved then
        --            shop_light:setVisible(false)
        elseif eventType == ccui.TouchEventType.canceled then
        --            shop_light:setVisible(false)
        elseif eventType == ccui.TouchEventType.ended then 
            --            shop_light:setVisible(false)
            print("主菜单")
            menuUI:menuChangeAction()
        end
    end
    self.menubtn:addTouchEventListener(_menuTouchEvent)    
    
    local function _heroTouchEvent(sender,eventType)
        if eventType == ccui.TouchEventType.began then
        --            shop_light:setVisible(true)
        elseif eventType == ccui.TouchEventType.moved then
        --            shop_light:setVisible(false)
        elseif eventType == ccui.TouchEventType.canceled then
        --            shop_light:setVisible(false)
        elseif eventType == ccui.TouchEventType.ended then 
            --            shop_light:setVisible(false)
            print("英雄")
            HeroSceneLogIn()
        end
    end
    self.heroBtn:addTouchEventListener(_heroTouchEvent)
    
    
    local function _pkgTouchEvent(sender,eventType)
        if eventType == ccui.TouchEventType.began then
        --            shop_light:setVisible(true)
        elseif eventType == ccui.TouchEventType.moved then
        --            shop_light:setVisible(false)
        elseif eventType == ccui.TouchEventType.canceled then
        --            shop_light:setVisible(false)
        elseif eventType == ccui.TouchEventType.ended then 
            --            shop_light:setVisible(false)
            print("背包")
            local changeToken = function(_result)   
                packageLogInMain()
            end
            SET_CallBack(PACKET_GC_BagList,changeToken)
            CG_HANDLER(PACKET_CG_BagList)  --背包列表
        end
    end
    self.pkgBtn:addTouchEventListener(_pkgTouchEvent)

    local function _fragTouchEvent(sender,eventType)
        if eventType == ccui.TouchEventType.began then
        --            shop_light:setVisible(true)
        elseif eventType == ccui.TouchEventType.moved then
        --            shop_light:setVisible(false)
        elseif eventType == ccui.TouchEventType.canceled then
        --            shop_light:setVisible(false)
        elseif eventType == ccui.TouchEventType.ended then 
            --            shop_light:setVisible(false)
            print("碎片")
            fragLogInMain()
        end
    end
    self.fragBtn:addTouchEventListener(_fragTouchEvent)

    local function _backTouchEvent(sender,eventType)
        if eventType == ccui.TouchEventType.began then
        --            shop_light:setVisible(true)
        elseif eventType == ccui.TouchEventType.moved then
        --            shop_light:setVisible(false)
        elseif eventType == ccui.TouchEventType.canceled then
        --            shop_light:setVisible(false)
        elseif eventType == ccui.TouchEventType.ended then 
            --            shop_light:setVisible(false)
            --            SceneMainLogIn()
            --              cc.Director:getInstance():popScene()
            popUIScene()
        end
    end
    self.backBtn:addTouchEventListener(_backTouchEvent)  

    local function _taskTouchEvent(sender,eventType)
        if eventType == ccui.TouchEventType.began then
        --            shop_light:setVisible(true)
        elseif eventType == ccui.TouchEventType.moved then
        --            shop_light:setVisible(false)
        elseif eventType == ccui.TouchEventType.canceled then
        --            shop_light:setVisible(false)
        elseif eventType == ccui.TouchEventType.ended then 
            --            shop_light:setVisible(false)
            print("任务")
            --            SceneMainLogIn()
            local xx = taskSceneCreate():Create()
            ui:addChild(xx,10,10)
        end
    end
    self.taskBtn:addTouchEventListener(_taskTouchEvent)

    local function _todoTouchEvent(sender,eventType)
        if eventType == ccui.TouchEventType.began then
        --            shop_light:setVisible(true)
        elseif eventType == ccui.TouchEventType.moved then
        --            shop_light:setVisible(false)
        elseif eventType == ccui.TouchEventType.canceled then
        --            shop_light:setVisible(false)
        elseif eventType == ccui.TouchEventType.ended then 
            --            shop_light:setVisible(false)
            print("任务")
            --            SceneMainLogIn()
            local xx = luasocketTestMain()
            ui:addChild(xx,10,10)
        end
    end
    self.todoBtn:addTouchEventListener(_todoTouchEvent)
    
    self.goldBtn = ui:getChildByName("gold"):getChildByName("add_gold") -- 打开点金手
    self.diamondBtn = ui:getChildByName("diamond"):getChildByName("add_diamond") --打开钻石购买界面
    self.vatalityBtn = ui:getChildByName("vatality"):getChildByName("add_vatality") -- 打开购买体力界面
    
    local function _goldTouchEvent(sender,eventType)
        if eventType == ccui.TouchEventType.ended then 
            print("打开点金手")
            local changeToken = function(_result)   

                if _result == 10000 then
                     local rechargeGold = reChargeGoldPanel(self)
                     ui:addChild(rechargeGold,10,10)
                end
            end
            SET_CallBack(PACKET_GC_MidasTouchFee,changeToken)
            CG_HANDLER(PACKET_CG_MidasTouchFee)
        end
    end
    self.goldBtn:addTouchEventListener(_goldTouchEvent)

    local function _diamondTouchEvent(sender,eventType)
        if eventType == ccui.TouchEventType.ended then 
            print("打开钻石")
            local rechargeDia = reChargeDiamondPanel(self)
            ui:addChild(rechargeDia,10,10)
        end
    end
    self.diamondBtn:addTouchEventListener(_diamondTouchEvent)

    local function _vatalityTouchEvent(sender,eventType)
        if eventType == ccui.TouchEventType.ended then 
            print("弹出兑换体力框")
            
            local aaa = function()
                --查看购买体力界面

                local okBtnFunction =  function(sender,eventType)
                    local dd = sender:getParent():getParent():getParent():getParent()
                    if eventType == ccui.TouchEventType.ended then 
                        local booltype = changeUserDataToken(50,2)
                        if booltype then
                            --本地
                                changeUserDataUPP(120,1)
                                self:changeData()
                            --
                            local changeToken = function(_result)   
                                changeUserDataToken(PhysicalFee["diamond"],2)
                                 if _result == 13022 then
                                    local xx = DialogshowDialogPanel(13022)
                                    cc.Director:getInstance():getRunningScene():addChild(xx,101)
                                 elseif _result == 10000 then
                                    self:changeData()
                                 else 
                                     print("其他错误..........") 
                                 end
                            end
                            SET_CallBack(PACKET_GC_BuyPhysical,changeToken)
                            CG_HANDLER_BuyPhysical(PhysicalFee["diamond"])
                        end
                        changeUserDataToken(PhysicalFee["diamond"],2)
                        dd:removeFromParent()
                    end
                end
                local canleBtnFunction =  function(sender,eventType)
                    local dd = sender:getParent():getParent():getParent():getParent()
                    if eventType == ccui.TouchEventType.ended then 
                        dd:removeFromParent()
                    end
                end
                local dialog = DialogshowDialogPanel("确认花费"..PhysicalFee["diamond"].."钻石购买120点体力，是否继续？（今日已购买"..PhysicalFee["usedtimes"].."次）","取消","确定",okBtnFunction,canleBtnFunction)
                ui:addChild(dialog,ui:getContentSize().width/2,ui:getContentSize().height/2)
            end
      
            SET_CallBack(PACKET_GC_BuyPhysicalFee,aaa) 
            CG_HANDLER(PACKET_CG_BuyPhysicalFee)
        end
    end
    self.vatalityBtn:addTouchEventListener(_vatalityTouchEvent)

    if self._menuType == false then 
        self.backBtn:setVisible(false)
        self.UserInfo:setVisible(true)
    end
    
    local function _userinfoTouchEvent(sender,eventType)
        if eventType == ccui.TouchEventType.ended then 
            print("用户信息")
            --查看设置界面
            local userInfo = userInfoSceneCreate(self.UserInfo):Create()
            ui:addChild(userInfo,10,10)
        end
    end
    self.UserInfo:getChildByName("UserInfoBtn"):addTouchEventListener(_userinfoTouchEvent)
    --名字
    self.UserInfo:getChildByName("UserName_btn"):setTitleText(MyUserData._userData._uName)
    --头像
 
    local frag = "res/userInfo/main_head_frame_silver.png"
    local frament = "res/userInfo/main_head_mas.png"
    local  maskedCal = maskedHeroWithSprite("res/userInfo/head/"..MyUserData._userData._uIcon,frament,frag,1)
    self.UserInfo:addChild(maskedCal)
    maskedCal:setPosition(cc.p(52,24))
    maskedCal:setTag(419)
    --等级
     self.UserInfo:getChildByName("UserLvl"):setString(MyUserData._userData._uLevel)
    
    menuUI:menuStageChange(state)
end


function menuUI:menuStageChange(state)  --状态改变
    if state == "open" then
        self.menubtn:loadTextures("res/jumpSceneUI/main_up_button.png","res/jumpSceneUI/main_up_button.png","")
        self.heroBtn:setPositionY(495)
        self.pkgBtn:setPositionY(495-100*1)
        self.fragBtn:setPositionY(495-100*2)
        self.taskBtn:setPositionY(495-100*3)
        self.todoBtn:setPositionY(495-100*4)
elseif state == "close" then
    self.menubtn:loadTextures("res/jumpSceneUI/main_down_button.png","res/jumpSceneUI/main_down_button.png","")
    local y = self.menubtn:getPositionY()+200
    self.heroBtn:setPositionY(y)
    self.pkgBtn:setPositionY(y)
    self.fragBtn:setPositionY(y)
    self.taskBtn:setPositionY(y)
    self.todoBtn:setPositionY(y)

    self._menubg:setScale(1,0)
end
end
--创建HeroRole对象方法  
function menuUI:createmenuUI(state,booltype)  
    local menuinstance = menuUI:extend(ccs.GUIReader:getInstance():widgetFromJsonFile("res/jumpSceneUI/jumpSceneUI_1.json")) 
    ui = menuinstance:getChildByName("jumpScene_Panel")
--    menuinstance:setVisible(false)
    ui:setAnchorPoint(cc.p(0.5,0.5))
    ui:setPosition(cc.p(1136/2,640/2))
--menuinstance:setScale(0.94)
--    local size    = cc.Director:getInstance():getVisibleSize() -- 屏幕分辨率大小
    local origin  = cc.Director:getInstance():getVisibleOrigin() -- 从画布的某个点显示
    local glView = cc.Director:getInstance():getOpenGLView()
    local size = glView:getFrameSize()
    local SCREEN_WIDTH= 1136
    local SCREEN_HEIGHT = (640*(size.width/1136))
    local SCLAE_MINI = 960/1136


print("sizeWW=="..size.width.."sizeHH=="..size.height)

    local SCALE_MAX = math.max(size.width/SCREEN_WIDTH, size.height/SCREEN_HEIGHT)
    print("SCALE_MAX=="..SCALE_MAX)
    local SCALE_MIN = math.min(size.width/SCREEN_WIDTH, size.height/SCREEN_HEIGHT)
    print("SCALE_MIN=="..SCALE_MIN)
    local SCALE_MIDDLE = SCLAE_MINI*(SCALE_MAX + SCALE_MIN)/2
    print("SCALE_MIDDLE==="..SCALE_MIDDLE)


    -- 如果origin.x不等于0，表示是左右是被裁过的，把activePanel的x位置设置到屏幕里的0的位置
    if origin.x ~= 0 then
--        ui:setPositionX(ui:getPositionX() + origin.x)
--        ui:setPositionY(ui:getPositionY() + origin.y+((640-(640*(960/1136))))/2)
--    ui:setScale(SCALE_MIDDLE)
--print("asdsdas")
    end

    -- y的设置理解同上，上下被裁过的
--    if origin.y ~= 0 then
--        ui:setPositionY(ui:getPositionY() + origin.y+(640-(640*(960/1136))))
--        print("xxx")
--    end

    -- 通过上面两个判断设置，ui在显示起始位置被固定好了，接下来设置ui的大小等于屏幕的大小，就大功告成了
--    ui:setPositionX(ui:getPositionX() + origin.x)
--     ui:setPositionY(ui:getPositionY() + origin.y)
    self.heroBtn = ui:getChildByName("Panel_menu"):getChildByName("btn_Panel"):getChildByName("heromenu_btn")
    self.pkgBtn = ui:getChildByName("Panel_menu"):getChildByName("btn_Panel"):getChildByName("pkgmenu_btn")
    self.fragBtn = ui:getChildByName("Panel_menu"):getChildByName("btn_Panel"):getChildByName("fragmenu_btn")
    self.taskBtn = ui:getChildByName("Panel_menu"):getChildByName("btn_Panel"):getChildByName("taskmenu_btn")
    self.todoBtn = ui:getChildByName("Panel_menu"):getChildByName("btn_Panel"):getChildByName("todomenu_btn")
    
--    self.heroBtn:setVisible(false)
--    self.pkgBtn:setVisible(false)
--    self.fragBtn:setVisible(false)
--    self.taskBtn:setVisible(false)
--    self.todoBtn:setVisible(false)
    
    
    self.backBtn = ui:getChildByName("back_btn")

    self.btn_Panel = ui:getChildByName("Panel_menu"):getChildByName("btn_Panel")
    self._menubg = ui:getChildByName("Panel_menu"):getChildByName("btn_Panel"):getChildByName("bg")
    self.menubtn = ui:getChildByName("Panel_menu"):getChildByName("btn_Panel"):getChildByName("menu_btn")
    
    self.UserInfo = ui:getChildByName("UserInfoPanel")
    
    self._menuStage = state
    self._menuType = booltype
    menuUI:init(state)
    return menuinstance  
end 


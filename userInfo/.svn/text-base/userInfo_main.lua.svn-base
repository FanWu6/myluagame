
require "src/userInfo/SystemSetting"
require "src/userInfo/ChangeName"
require "src/userInfo/ChangeFrame"
require "src/userInfo/ChangeHeadImage"

local ui_widget
local userInfoInstance = nil
local userInfoState
local userInfoScene = {}; 
local num
local currUseNum = 0

local userInfoPanel

userInfoScene.new = function(self) 
    local o = { --可以在此处添加数据
        }; 
    setmetatable(o,self); 
    self.__index = self; 
    return o; 
end

userInfoScene.buttonInit = function(self)

    local userInfoPanel = ui_widget:getChildByName("userInfoPanel")
    local changeNameBtn = userInfoPanel:getChildByName("changeNameBtn")
    local changeHeadBtn = userInfoPanel:getChildByName("changeHeadBtn")
    local changeFrameBtn = userInfoPanel:getChildByName("changeFrameBtn")
    local guildPanel = userInfoPanel:getChildByName("guildPanel")
    local exitGuildBtn = guildPanel:getChildByName("exitGuildBtn")
    local systemBtn = userInfoPanel:getChildByName("systemBtn")
    local closeBtn = userInfoPanel:getChildByName("closeBtn")

    local function _closeHandle(sender,eventType)
        if eventType == ccui.TouchEventType.ended then 
            print("关闭信息界面")
            currUseNum = 0
            ui_widget:getParent():getParent():changeUserData()
            
            ui_widget:removeFromParent()
        end
    end
    closeBtn:addTouchEventListener(_closeHandle)
--
    local function _changeNameBtnHandle(sender,eventType)
        if eventType == ccui.TouchEventType.ended then 
            print("打开修改昵称界面")
            local panel = ui_widget:getChildByName("changeNamePanel")
            showChangeNamePanel(self,panel)
        end
    end
    changeNameBtn:addTouchEventListener(_changeNameBtnHandle)
    
    local function _changeHeadBtnHandle(sender,eventType)
        if eventType == ccui.TouchEventType.ended then 
            print("打开修改头像界面")
            local panel = ui_widget:getChildByName("changeHeadPanel")
            showChangeHeadPanel(self,panel)
        end
    end
    changeHeadBtn:addTouchEventListener(_changeHeadBtnHandle)
    
    local function _changeFrameBtnHandle(sender,eventType)
        if eventType == ccui.TouchEventType.ended then 
            print("打开修改头像框界面")
            local panel =  ui_widget:getChildByName("changeFramePanel")
            showChangeFramePanel(self,panel)

        end
    end
    changeFrameBtn:addTouchEventListener(_changeFrameBtnHandle)
    
    
    local function _exitGuildBtnHandle(sender,eventType)
        if eventType == ccui.TouchEventType.ended then 
            print("退出公会")
            local okBtnFunction =  function(sender,eventType)
                local dd = sender:getParent():getParent():getParent():getParent()
                if eventType == ccui.TouchEventType.ended then 
                    dd:removeFromParent()
                    changeUserGuild()
                    local guildPanel =  ui_widget:getChildByName("userInfoPanel"):getChildByName("guildPanel")
                    guildPanel:setVisible(false)
                end
            end
            local canleBtnFunction =  function(sender,eventType)
                local dd = sender:getParent():getParent():getParent():getParent()
                if eventType == ccui.TouchEventType.ended then 
                    dd:removeFromParent()
                end
            end
            local dialog = DialogshowDialogPanel("退出公会后1小时内无法加入任何公会，48小时内无法回到原公会，同事7天内只能加入3此公会，是否退出?","取消","确定",okBtnFunction,canleBtnFunction)
            ui_widget:addChild(dialog,ui_widget:getContentSize().width/2,ui_widget:getContentSize().height/2)
        end
    end
    exitGuildBtn:addTouchEventListener(_exitGuildBtnHandle)
    
    local function _systemBtnHandle(sender,eventType)
        if eventType == ccui.TouchEventType.ended then 
            print("打开设置界面")
            local panel = ui_widget:getChildByName("systemPanel")--:getVisible()
            local systemPanel  = systemPanelSceneCreate():Create()
            ui_widget:addChild(systemPanel,10,10)
        end
    end
    systemBtn:addTouchEventListener(_systemBtnHandle)

end
userInfoScene.updateHeadImg = function(self)
    local userInfoPanel = ui_widget:getChildByName("userInfoPanel")
    local frag = "res/userInfo/main_head_frame_silver.png"
    local frament = "res/userInfo/main_head_mas.png"
    local  maskedCal = maskedHeroWithSprite("res/userInfo/head/"..MyUserData._userData._uIcon,frament,frag,1)
    userInfoPanel:addChild(maskedCal);
    maskedCal:setPosition(cc.p(userInfoPanel:getContentSize().width/2-225,userInfoPanel:getContentSize().height/2+180))

end

userInfoScene.updateNameTxt = function(self)
    print("updateNameTxt====="..MyUserData._userData._uName)
    local userInfoPanel = ui_widget:getChildByName("userInfoPanel")
    local nameTxt = userInfoPanel:getChildByName("nameTxt")
    nameTxt:setString(MyUserData._userData._uName)
end

userInfoScene.init = function(self)

    local userInfoPanel = ui_widget:getChildByName("userInfoPanel")
    local guildPanel = userInfoPanel:getChildByName("guildPanel")
    --添加头像
    userInfoScene.updateNameTxt(self)
   
    userInfoScene.updateHeadImg(self)
    
    local teamLevelTxt = userInfoPanel:getChildByName("teamLevelTxt")
    teamLevelTxt:setString(MyUserData._userData._uLevel)
    
    local teamExpTxt = userInfoPanel:getChildByName("teamExpTxt")
    local currLevelExp = getUserExpByLv(MyUserData._userData._uLevel)
    teamExpTxt:setString(MyUserData._userData._uExp.."/"..currLevelExp)
    
    local heroLevelTxt = userInfoPanel:getChildByName("heroLevelTxt")
    heroLevelTxt:setString(MyUserData._userData._uLevel)
    
    local userIdTxt = userInfoPanel:getChildByName("userIdTxt")
    userIdTxt:setString(MyUserData._userData._uId)
    
    if MyUserData._userData._uGuild == 0 then
        guildPanel:setVisible(false)
        
    else
        guildPanel:setVisible(true)
        local guildNameTxt = guildPanel:getChildByName("guildNameTxt")
        guildNameTxt:setString("天下无敌")
        local guildIdTxt =  guildPanel:getChildByName("guildIDTxt")
        guildIdTxt:setString(MyUserData._userData._uGuild)
    end
    
end



userInfoScene.Create = function(self)
    ui_widget = ccs.GUIReader:getInstance():widgetFromJsonFile("res/userInfo/UserInfoPanel.json")
    userInfoState = "userInfo"
    num =2
    userInfoScene.buttonInit(self)
    userInfoScene.init(self)

    return ui_widget
end

function userInfoSceneCreate(_userInfoPanel)
    -- body
    userInfoPanel = _userInfoPanel
    userInfoInstance = userInfoScene:new()

    return userInfoInstance

end
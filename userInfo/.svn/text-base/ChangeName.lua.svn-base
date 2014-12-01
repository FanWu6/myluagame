local _changeNamePanel
local _parent = nil


local nameData = {"催眠的神光守卫","永生的神巫医","无情的帅精灵","焕发的拽狙击手","寡欢的小魂守卫","振奋的狂军兵团","害羞的仙士兵","俗气的狂剑客","金属的怪痛女王","冷酷的仙红龙","风尘的灵巫医","寡欢的霸隐刺客","古怪的拽风灵","上路炫怒法师","时髦的矮人","邋遢的炫蜥蜴","好色的仙士兵","开朗的突击兵","纯洁的炫预言者","虎背的老侏儒"}
local function randonNameStr()
    local num =  math.random(1,20)
    local nameTxt = _changeNamePanel:getChildByName("NameCg_Panel"):getChildByName("bg"):getChildByName("nameTxt")
    nameTxt:setString(nameData[num])
end

local function buttonInit()
    local changeBtn = _changeNamePanel:getChildByName("NameCg_Panel"):getChildByName("bg"):getChildByName("changeBtn")
    local cancleBtn = _changeNamePanel:getChildByName("NameCg_Panel"):getChildByName("bg"):getChildByName("cancleBtn")
    local okBtn = _changeNamePanel:getChildByName("NameCg_Panel"):getChildByName("bg"):getChildByName("okBtn")

    local function _changeBtnHandle(sender,eventType)
        if eventType == ccui.TouchEventType.ended then 
            print("随机名字")
            randonNameStr()
        end
    end
    changeBtn:addTouchEventListener(_changeBtnHandle)

    local function _cancleBtnHandle(sender,eventType)
        if eventType == ccui.TouchEventType.ended then 
            print("取消")
            _changeNamePanel:setVisible(false)
        end
    end
    cancleBtn:addTouchEventListener(_cancleBtnHandle)

    local function _okBtnHandle(sender,eventType)
        if eventType == ccui.TouchEventType.ended then 
            print("确定，打开提示框")
            --获取钻石   获取金币
            local okBtnFunction =  function(sender,eventType)
                local dd = sender:getParent():getParent():getParent():getParent()
                if eventType == ccui.TouchEventType.ended then 
                    local nameTxt = _changeNamePanel:getChildByName("NameCg_Panel"):getChildByName("bg"):getChildByName("nameTxt")
                    local name = nameTxt:getString()
                    changeUserDataName(name)
                    local booltype = changeUserDataToken(100,2)
                    if booltype then 
                        local nameTxt = _changeNamePanel:getChildByName("NameCg_Panel"):getChildByName("bg"):getChildByName("nameTxt")
                        local name = nameTxt:getString()
                        changeUserDataName(name)
                        _parent:updateNameTxt()
                    end
                    dd:removeFromParent()
                    _changeNamePanel:setVisible(false)
                    
                end
            end
            local canleBtnFunction =  function(sender,eventType)
                local dd = sender:getParent():getParent():getParent():getParent()
                if eventType == ccui.TouchEventType.ended then 
                    dd:removeFromParent()
                end
            end
            local dialog = DialogshowDialogPanel("改名需要花费100钻石，是否继续","取消","确定",okBtnFunction,canleBtnFunction)
            _changeNamePanel:addChild(dialog,_changeNamePanel:getContentSize().width/2,_changeNamePanel:getContentSize().height/2)
        end
    end
    okBtn:addTouchEventListener(_okBtnHandle)
end


local function _closeHandle(sender,eventType)
    if eventType == ccui.TouchEventType.ended then 
        print("关闭界面")
        _changeNamePanel:setVisible(false)
    end
end


function showChangeNamePanel(parent,changeNamePanel)
    _changeNamePanel = changeNamePanel
    _parent = parent
    _changeNamePanel:setVisible(true)
    buttonInit()
    randonNameStr()
    _changeNamePanel:addTouchEventListener(_closeHandle)
end

local blackListPanel
local blackListInstance = nil
local blackListState
local blackListScene = {};

blackListScene.new = function(self) 
    local o = {}
    setmetatable(o,self); 
    self.__index = self; 
    return o; 
end

blackListScene.removeBlackListLine = function(self,id)
    removeUserDataById(id)
    blackListScene.init(self)
end

local function _closePanelHandle(sender,eventType)
    if eventType == ccui.TouchEventType.ended then 
        print("关闭黑名单界面")
        blackListPanel:removeFromParent()
    end
end

blackListScene.buttonInit = function(self)

    local innerPanel = blackListPanel:getChildByName("blackListPanel")
    innerPanel:addTouchEventListener(_closePanelHandle)
    local _listView = innerPanel:getChildByName("bg"):getChildByName("blackListView")
    local info_prototype = _listView:getChildByName("blackListLine")
    _listView:setItemModel(info_prototype)
    _listView:removeAllItems()

    
    local closeBtn = blackListPanel:getChildByName("blackListPanel"):getChildByName("bg"):getChildByName("closeBtn")
    
    local function _closeHandle(sender,eventType)
        if eventType == ccui.TouchEventType.ended then 
            print("关闭黑名单界面")
            blackListPanel:removeFromParent()
        end
    end
    closeBtn:addTouchEventListener(_closeHandle)
    
end




blackListScene.init= function(self)
    local currBlackData = userBlackList
    local _listView = blackListPanel:getChildByName("blackListPanel"):getChildByName("bg"):getChildByName("blackListView")
    local count = table.getn(_listView:getItems())
   
    if count>0 then _listView:removeAllItems() end
    
    for i=1,table.maxn(currBlackData),1 do
        _listView:pushBackDefaultItem()
        local frag = "res/userInfo/main_head_frame_silver.png"
        local frament = "res/userInfo/main_head_mas.png"
        local  maskedCal = maskedHeroWithSprite("res/userInfo/head/"..currBlackData[i]._userData._uIcon,frament,frag,1)
        maskedCal:setScale(0.7)
        _listView:getItem(i-1):addChild(maskedCal);
        maskedCal:setPosition(cc.p(_listView:getItem(i-1):getContentSize().width/2-250,_listView:getItem(i-1):getContentSize().height/2))

        _listView:getItem(i-1):getChildByName("levelTxt"):setString(currBlackData[i]._userData._uLevel)
        _listView:getItem(i-1):getChildByName("nameTxt"):setString(currBlackData[i]._userData._uName)

        local function _removeBtnHandle(sender,eventType)
            if eventType == ccui.TouchEventType.ended then 
                print("关闭黑名单界面.."..currBlackData[i]._userData._uName)
                blackListScene.removeBlackListLine(self,currBlackData[i]._userData._uId)
            end
        end
        _listView:getItem(i-1):getChildByName("removeBtn"):addTouchEventListener(_removeBtnHandle)
    end
    
end


blackListScene.Create = function(self)
    blackListPanel = ccs.GUIReader:getInstance():widgetFromJsonFile("res/userInfo/blackListPanel.json")
    blackListState = "blackList"
    blackListScene.buttonInit(self)
    blackListScene.init(self)
    return blackListPanel
end

function blackListSceneCreate()
    -- body

    blackListInstance = blackListScene:new()

    return blackListInstance

end
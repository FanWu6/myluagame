local ui_widget
local taskInstance = nil
local taskState
local taskScene = {}; 
local num 

taskScene.new = function(self) 
    local o = { --可以在此处添加数据
        }; 
    setmetatable(o,self); 
    self.__index = self; 
    return o; 
end

taskScene.buttonInit = function(self)
    local _panel =  ui_widget:getChildByName("task"):getChildByName("taskPanel")
    _panel:setPosition(cc.p(920,550))
    local _listView = ui_widget:getChildByName("task"):getChildByName("taskPanel"):getChildByName("task_listview")
    local btn_prototype = _listView:getChildByName("task")
    _listView:removeItem(0)

    _listView:setItemModel(btn_prototype)  --设置原型
    --关闭
    local btn_close = ui_widget:getChildByName("task"):getChildByName("taskPanel"):getChildByName("close_btn")
    local function _closeTouchEvent(sender,eventType)
        if eventType == ccui.TouchEventType.began then
        --            shop_light:setVisible(true)
        elseif eventType == ccui.TouchEventType.moved then
        --            shop_light:setVisible(false)
        elseif eventType == ccui.TouchEventType.canceled then
        --            shop_light:setVisible(false)
        elseif eventType == ccui.TouchEventType.ended then 
            --            shop_light:setVisible(false)
            ui_widget:removeFromParent()
        end
    end

    btn_close:addTouchEventListener(_closeTouchEvent)
    --
    
    --分页
    local taskpage_btn = ui_widget:getChildByName("task"):getChildByName("taskPanel"):getChildByName("taskPage")
    local dailytaskpage_btn = ui_widget:getChildByName("task"):getChildByName("taskPanel"):getChildByName("dailytaskPage")
    local function _pageTouchEvent(sender,eventType)
        if eventType == ccui.TouchEventType.began then
            sender:setLocalZOrder(2)
        elseif eventType == ccui.TouchEventType.moved then

        elseif eventType == ccui.TouchEventType.canceled then
            sender:setLocalZOrder(2)
        elseif eventType == ccui.TouchEventType.ended then 
            local state = sender:getName()
            if state== "taskPage" then 
                taskpage_btn:setLocalZOrder(2)
                dailytaskpage_btn:setLocalZOrder(0)
            else
                taskpage_btn:setLocalZOrder(0)
                dailytaskpage_btn:setLocalZOrder(2)
            end
            --end操作
            if state ~= taskState then 
            --init(state)
            taskState = state
            print("跳转")
--                num = num +1
            taskScene.init(self,num)
                _listView:scrollToTop(0.05,false) 
            end
        end
    end

    taskpage_btn:addTouchEventListener(_pageTouchEvent)
    dailytaskpage_btn:addTouchEventListener(_pageTouchEvent)
    --
    --任务完成
    local _Succeedpanel =  ui_widget:getChildByName("task_success")
    local function _confirmTouchEvent(sender,eventType)
        if eventType == ccui.TouchEventType.began then

        elseif eventType == ccui.TouchEventType.moved then

        elseif eventType == ccui.TouchEventType.canceled then

        elseif eventType == ccui.TouchEventType.ended then 
            _Succeedpanel:setVisible(false)
        end
    end
    local _confimrBtn = _Succeedpanel:getChildByName("bg"):getChildByName("confirm_btn")
    _confimrBtn:addTouchEventListener(_confirmTouchEvent)
    --
end

taskScene.taskSucceed = function(self,_tId,_tNextId,type)
    local _Succeedpanel =  ui_widget:getChildByName("task_success")
    _Succeedpanel:setVisible(true)
        if _tNextId ~= nil then
        TaskRemove(_tId,_tNextId,type)
        TaskDataUpdate(_tNextId,type)
             taskScene.init(self,1)
        end
end

taskScene.init = function(self,_num)
    local _panel =  ui_widget:getChildByName("task"):getChildByName("taskPanel")
    _panel:setPosition(cc.p(920,550))
     local _listView = ui_widget:getChildByName("task"):getChildByName("taskPanel"):getChildByName("task_listview")

    
   _listView:removeAllItems()
    
    local function _taskTouchEvent(sender,eventType)
        if eventType == ccui.TouchEventType.began then
                  sender:setScale(0.95)
        elseif eventType == ccui.TouchEventType.moved then
                  sender:setScale(0.95)
        elseif eventType == ccui.TouchEventType.canceled then
            sender:setScale(1.0)
        elseif eventType == ccui.TouchEventType.ended then 
            sender:setScale(1.0)
            local tag = sender:getTag()
            for i,v in ipairs(UsertaskData) do
                if v._tId == tag  then
                    if v._tCurrState == 1 then
                        taskScene.taskSucceed(self,v._tId,v._tNextId,v._tType)
                    end
                end
            end
        end
    end
    local currStageData = Config._userData._uCurStage_normal[1]
    for i=1,table.maxn(UsertaskData),1 do
        _listView:pushBackDefaultItem()
        if UsertaskData[i]._tCurrState == 1 then
            _listView:getItem(i-1):loadTextureNormal("res/TaskUI/task_board_finishe.png")
            _listView:getItem(i-1):loadTexturePressed("res/TaskUI/task_board_finishe.png")
            _listView:getItem(i-1):getChildByName("task_num"):setVisible(false)
            _listView:getItem(i-1):getChildByName("jump_btn"):setVisible(false)
            local getRewardImage = ccui.ImageView:create("res/TaskUI/task_get_reward_button.jpg")
            _listView:getItem(i-1):addChild(getRewardImage)
            getRewardImage:setPosition(cc.p(550,65))
        end
        _listView:getItem(i-1):setTag(UsertaskData[i]._tId)
        _listView:getItem(i-1):getChildByName("taskimage"):loadTexture("res/TaskUI/"..UsertaskData[i]._tIcon..".png")
        _listView:getItem(i-1):getChildByName("title_text"):setString(UsertaskData[i]._tName)
        _listView:getItem(i-1):getChildByName("task_text"):setString(UsertaskData[i]._tDesc)
        _listView:getItem(i-1):getChildByName("rewardImage"):loadTexture("res/TaskUI/"..UsertaskData[i]._tIcon..".png")
        _listView:getItem(i-1):getChildByName("reward_text"):setString("X"..UsertaskData[i]._tJewel)
        
        _listView:getItem(i-1):addTouchEventListener(_taskTouchEvent)
    end
end


taskScene.Create = function(self)
    ui_widget = ccs.GUIReader:getInstance():widgetFromJsonFile("res/TaskUI/TaskUI.json")
    taskState = "taskPage"
    num =2
    taskScene.buttonInit(self)
    taskScene.init(self,num)
  
    return ui_widget
end


function taskSceneCreate()
    -- body

    taskInstance = taskScene:new()

    return taskInstance

end
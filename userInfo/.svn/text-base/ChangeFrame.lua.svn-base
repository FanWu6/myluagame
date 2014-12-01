local changeFramePanel
local _parent = nil


local function _closeHandle(sender,eventType)
    if eventType == ccui.TouchEventType.ended then 
        print("关闭界面")
        changeFramePanel:setVisible(false)
    end
end


function showChangeFramePanel(parent,panel)
    print("asdsdsadsadasds[]=====")
    changeFramePanel = panel
    _parent = parent
    changeFramePanel:setVisible(true)
    changeFramePanel:addTouchEventListener(_closeHandle)
end


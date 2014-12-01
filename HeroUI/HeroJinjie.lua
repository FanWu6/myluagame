function HeroJinjie(jinjiePanel,iName)
    --1.关闭按钮
    local close_btn=jinjiePanel:getChildByName("close_btn")
        local function _closeEvent(sender,eventType)
            local _button = sender
            if eventType == ccui.TouchEventType.began then
            elseif eventType == ccui.TouchEventType.moved then
            --移动按钮没有操作
            elseif eventType == ccui.TouchEventType.canceled then   

            elseif eventType == ccui.TouchEventType.ended then     --end之后的回调
                  jinjiePanel:setVisible(false)
            end
        end  
        close_btn:addTouchEventListener(_closeEvent)
    --2.确认按钮
    local confirm_btn=jinjiePanel:getChildByName("confirm_btn")
    --3.英雄名字
    local hroname_fra=jinjiePanel:getChildByName("hroname_fra") --英雄名字
    hroname_fra:setString(iName)
end
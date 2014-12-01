--根据错误码打开指定的界面
local function DialogerrorGoToPanel(id)
    print("为什么没弹！！！！！！！")
    if id == 13004 then --金币不足 点金手界面
        local xx = reChargeGoldPanel()
        cc.Director:getInstance():getRunningScene():addChild(xx,101)
    elseif id == 13022 then -- 钻石不足 充值界面
        local xx = reChargeDiamondPanel()
        cc.Director:getInstance():getRunningScene():addChild(xx,101)
    elseif id == 12009 then --体力不足
    
            local booltpe =    changeUserDataToken(50,2)
                if booltpe then
                 changeUserDataUPP(120,1)
                 reChargePower()
                end

    end
end

--展示带按钮提示框。包括（错误码，消费提示，金币，体力，钻石，特权不够提示）  
function DialogshowDialogPanel(contentStr,cancleBtnStr,okBtnStr,okBtnFunction,canleBtnFunction)
    local dialog = ccs.GUIReader:getInstance():widgetFromJsonFile("res/dialog/dialog_1.json")
    local contenLayer = dialog:getChildByName("dialogPanel"):getChildByName("dialogB_Panel"):getChildByName("bg")

    local _okBtnFunction
    local _cancleBtnFunction = function(sender,eventType)
        local dd = sender:getParent():getParent():getParent():getParent()
        if eventType == ccui.TouchEventType.ended then 
            dd:removeFromParent()
        end
    end

    local _cancleBtnStr = cancleBtnStr or "取消"
    local _okBtnStr = okBtnStr or "确定"

    local contentLabel = contenLayer:getChildByName("contentLabel")
    local cancleBtn = contenLayer:getChildByName("cancleBtn")
    cancleBtn:setTitleText(_cancleBtnStr)
    local okBtn = contenLayer:getChildByName("okBtn")
    okBtn:setTitleText(_okBtnStr)

    if nil == tonumber(contentStr) then  --字符串
        contentLabel:setString(contentStr)
        if nil == okBtnFunction then
                okBtn:addTouchEventListener(_cancleBtnFunction)
            else
                okBtn:addTouchEventListener(okBtnFunction)
        end

        if nil == canleBtnFunction then
                cancleBtn:addTouchEventListener(_cancleBtnFunction)
            else
                cancleBtn:addTouchEventListener(canleBtnFunction)
        end

     else -- 错误码  获取错误码信息
        local error = getErrorByResult(tonumber(contentStr))
                contentLabel:setString(error.desc)
        print("ddddssss----------")
                _okBtnFunction = function(sender,eventType)
                    local dd = sender:getParent():getParent():getParent():getParent()
                        if eventType == ccui.TouchEventType.ended then 
                            dd:removeFromParent()
                            --跳转到指定界面
                             DialogerrorGoToPanel(tonumber(contentStr))
                        end
                    end
        
        
                cancleBtn:addTouchEventListener(_cancleBtnFunction)
                okBtn:addTouchEventListener(_okBtnFunction)
--            end
        end
    return dialog
end

--展示没有按钮的提示框
--
function showNoButtonTipPanel(contentStr)

    local image = ccui.ImageView:create()
    image:setScale9Enabled(true)
    image:loadTexture("res/dialog/main_vit_tip.png")
    local content = ccui.Text:create()
    content:setString(contentStr)
    content:setFontSize(20)
    local width =  content:getVirtualRendererSize().width
    content:setSize(cc.size(width,30))
    image:setSize(cc.size(width+10,40))
    content:setPosition(image:getContentSize().width/2,image:getContentSize().height/2)
    image:addChild(content)

    local function removeMySelf()
        image:removeFromParent()
    end
    
    local action1 = cc.FadeOut:create(1)
    local delay = cc.DelayTime:create(1)

    image:runAction(cc.Sequence:create(delay,action1,cc.CallFunc:create(removeMySelf)))
    content:runAction( cc.Sequence:create(delay,action1:clone()))
    return image

end

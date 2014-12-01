--通用工具帮助类
--添加时注明日期


--********************************
--*********wangwei add************
--********************************
-- cclog
cclog = function(...)
    print(string.format(...))
end

function pairsByKeys (t, f)
	local a = {}
	for n in pairs(t) do table.insert(a, n) end
		table.sort(a, f)
		local i = 0                 -- iterator variable
		local iter = function ()    -- iterator function
		i=i+1
		if a[i] == nil then return nil else return a[i], t[a[i]]
		end
	end
	return iter
end


--屏幕适配 i5 i4 
function screenScaleMaker ( image )
	local _dat = 1

	local _image_size = image:getContentSize()

	if DesignResolutionSize.winType == WIN_TYPE_IPHONE5 then

        local _datW = DesignResolutionSize.width/_image_size.width
        local _datH = DesignResolutionSize.height/_image_size.height

        if _datW >= _datH then
            _dat = _datW
        else
            _dat = _datH
        end
    elseif DesignResolutionSize.winType == WIN_TYPE_IPHONE4 then

        local _datW = DesignResolutionSize.width/_image_size.width
        local _datH = DesignResolutionSize.height/_image_size.height

        if _datW <= _datH then
            _dat = _datW
        else
            _dat = _datH
        end
    end

    -- cclog("_dat!!!!!! = ".._dat)
	return _dat
end

--********************************
--*********chenqiang add**********
--********************************

 

function Split(szFullString, szSeparator)  --分割字符串
    local nFindStartIndex = 1  
    local nSplitIndex = 1  
    local nSplitArray = {}  
    while true do  
       local nFindLastIndex = string.find(szFullString, szSeparator, nFindStartIndex)  
       if not nFindLastIndex then  
        nSplitArray[nSplitIndex] = string.sub(szFullString, nFindStartIndex, string.len(szFullString))  
        break  
       end  
       nSplitArray[nSplitIndex] = string.sub(szFullString, nFindStartIndex, nFindLastIndex - 1)  
       nFindStartIndex = nFindLastIndex + string.len(szSeparator)  
       nSplitIndex = nSplitIndex + 1  
    end  
    return nSplitArray  
end 



local CanShowToast = true



function ToastTool(TWord,HaveBG,BGRes,AddScene,AddPosx,AddPosy,Duration)

    if CanShowToast == true then 

        CanShowToast = false 

        local ToastLayer = cc.Layer:create()
        ToastLayer:setPosition(AddPosx,AddPosy)

               --  local _SandText = ccui.Text:create()  
            -- _SandText:setString(PSendWord[i][1])
            -- _SandText:ignoreContentAdaptWithSize(false)
            -- _SandText:setAnchorPoint(cc.p(0,1))  
            -- _SandText:setFontSize(20)
            -- _SandText:setFontName(FONT_MANAGER.Mail.Font)
        local ToastWord = ccui.Text:create()  
        ToastWord:setString(TWord)
        ToastWord:setFontSize(20)
        -- ToastWord:setFontName(FONT_MANAGER.Mail.Font)


        -- cc.Label:createWithSystemFont(TWord, "Helvetica", 24)   
        local ToastBG
        if HaveBG == true then 
            ToastBG = cc.Scale9Sprite:create(BGRes)
            ToastBG:setContentSize(cc.size(ToastWord:getContentSize().width+10,ToastWord:getContentSize().height+5))
            ToastLayer:addChild(ToastBG)
            ToastWord:setPosition(ToastBG:getContentSize().width/2,ToastBG:getContentSize().height/2)
            ToastBG:addChild(ToastWord)
        elseif HaveBG == false then 

            ToastLayer:addChild(ToastWord)

        end 
        local scheduler2 = cc.Director:getInstance():getScheduler()
        local schedulerEntry2 = nil

        function RemoveToast(dt)
            cclog("RemoveToast")
            ToastLayer:removeFromParent()
            scheduler2:unscheduleScriptEntry(schedulerEntry2)
            CanShowToast = true 
        end

        local scheduler = cc.Director:getInstance():getScheduler()
        local schedulerEntry = nil
        function StartRemoveToast(dt)

            cclog("StartRemoveToast")
            
            ToastBG:runAction(cc.Sequence:create(cc.DelayTime:create(0),cc.FadeOut:create(1.1)))
            ToastWord:runAction(cc.Sequence:create(cc.DelayTime:create(0),cc.FadeOut:create(1.1)))
            schedulerEntry2 = scheduler:scheduleScriptFunc(RemoveToast, 1.1, false)
            scheduler:unscheduleScriptEntry(schedulerEntry)
        end
        schedulerEntry = scheduler:scheduleScriptFunc(StartRemoveToast, Duration, false)

        AddScene:addChild(ToastLayer)
        cclog("ToastTool")

    end
end


--********************************
--*********wufan add**************
--********************************


--[[

example:
    local dog = maskedSpriteWithSprite("res/CW.jpg","res/avatar_head_bg.pvr.ccz","res/main_head_frame_gold.png")
]]--

--遮罩层
function maskedSpriteWithSprite(textureSprite,maskSprite,frameSprite)--{
    local mask = cc.Sprite:create(maskSprite)--蓝色边框里面涂成白色，然后把边框去掉
    local cal =cc.Sprite:create(textureSprite)--英雄  

    local rt = cc.RenderTexture:create(mask:getContentSize().width,mask:getContentSize().height)

    mask:setPosition(mask:getContentSize().width/2,mask:getContentSize().height/2)
    cal:setPosition(mask:getContentSize().width/2,mask:getContentSize().height/2)

    mask:setBlendFunc(gl.ONE,gl.ZERO)
    cal:setBlendFunc(gl.DST_ALPHA,gl.ZERO)
    -- 4
    rt:begin()
    mask:visit()
    cal:visit()
    rt:endToLua()

    -- 5
    local retval= cc.Sprite:createWithTexture(rt:getSprite():getTexture())
    retval:setFlippedY(true)
    
    --6 add frame 
    local frame = cc.Sprite:create(frameSprite)--frame
    retval:addChild(frame,1)
    frame:setPosition(retval:getContentSize().width/2,retval:getContentSize().height/2)
    
    --7
    return retval
end





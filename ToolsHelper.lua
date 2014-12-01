--通用工具帮助类
--添加时注明日期


--********************************
--*********wangwei add************
--********************************
-- cclog
cclog = function(...)
    print(string.format(...))
end

function __G__TRACKBACK__(msg)
    cclog("----------------------------------------")
    cclog("LUA ERROR: " .. tostring(msg) .. "\n")
    cclog(debug.traceback())
    cclog("----------------------------------------")
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

function lua_string_split(str, split_char)   --字符串分割
    local sub_str_tab = {};
    while (true) do
        local pos = string.find(str, split_char);
        if (not pos) then
            sub_str_tab[#sub_str_tab + 1] = str;
            break;
        end
        local sub_str = string.sub(str, 1, pos - 1);
        sub_str_tab[#sub_str_tab + 1] = sub_str;
        str = string.sub(str, pos + 1, #str);
    end

    return sub_str_tab;
end



--********************************
--*********wufan add**************
--********************************


--[[

example:
    local dog = maskedSpriteWithSprite("res/CW.jpg","res/avatar_head_bg.pvr.ccz","res/main_head_frame_gold.png")
]]--

--遮罩层
function maskedHeroWithSprite(textureSprite,maskSprite,frameSprite,num)--{
    local mask = cc.Sprite:create(maskSprite)--蓝色边框里面涂成白色，然后把边框去掉
    local cal =cc.Sprite:create(textureSprite..".jpg")--英雄  
    cal:setScale(108/78)
--    print("textureSprite===="..textureSprite)

    local rt = cc.RenderTexture:create(mask:getContentSize().width,mask:getContentSize().height)

    mask:setPosition(mask:getContentSize().width/2,mask:getContentSize().height/2)
    cal:setPosition(cal:getContentSize().width/2+4,cal:getContentSize().height/2+4)

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
    if frameSprite ~= nil then
        local frame = cc.Sprite:create(frameSprite)--frame
        retval:addChild(frame,1)
        frame:setPosition(retval:getContentSize().width/2,retval:getContentSize().height/2-2)
    end

    --7 add num
    if nil~=num and  num>1 then
        local text_num = ccui.Text:create()
        text_num:setAnchorPoint(1,0.5)
        text_num:setString(num)
        text_num:setFontSize(20)
        text_num:setPosition(retval:getContentSize().width-10,20)
        retval:addChild(text_num,2,10)
    end
    --8
    return retval
end
--物品框管理
function ToolsgetItemIcon(iType,iTone)  
    local frament = nil
    local frag = nil
    if iType == 3 or iType == 5 then -- 棱形
--        frament = "res/daota/fragment2.png" -- 底部形状
--        frag = "res/daota/fragment_frame_" --外部框框
        frament = "res/daota/fragment_new.png" -- 底部形状
        frag = "res/daota/item_frame"
    else 
--        frament = "res/daota/equip_stenci.png" -- 底部形状
--        frag = "res/daota/equip_frame_"
        frament = "res/daota/fragment_new.png" -- 底部形状
        frag = "res/daota/item_frame"
    end

    if iTone == 1 then
        frag = string.format("%s%s",frag,".png")
    elseif iTone == 2 then
        frag = string.format("%s%s",frag,".png")
    elseif iTone == 3 then
        frag = string.format("%s%s",frag,".png")
    elseif iTone == 4 then
        frag = string.format("%s%s",frag,".png")
    else
        frag = string.format("%s%s",frag,".png")
    end
    return frament,frag
end

--置灰shader
function darkNode(node)
   
        
    local vsh = "res/shader/StoneShader.vsh"
    local fsh = "res/shader/StoneShader.fsh"

    local pProgram = cc.GLProgram:create(vsh,fsh)
    node:setGLProgram(pProgram)
    pProgram:bindAttribLocation(cc.ATTRIBUTE_NAME_POSITION,cc.VERTEX_ATTRIB_POSITION)
    pProgram:bindAttribLocation(cc.ATTRIBUTE_NAME_COLOR,cc.VERTEX_ATTRIB_COLOR)
    pProgram:bindAttribLocation(cc.ATTRIBUTE_NAME_TEX_COORD,cc.VERTEX_ATTRIB_FLAG_TEX_COORDS)
    pProgram:link()
    pProgram:updateUniforms()
end



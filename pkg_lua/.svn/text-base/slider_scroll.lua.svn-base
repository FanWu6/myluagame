local sliderInstance = nil
local ui_slider
local _pscroll
local _sliderScale
local scrollSlider = {}; 

scrollSlider.new = function(self) 
    local o = { --可以在此处添加数据
        }; 
    setmetatable(o,self); 
    self.__index = self; 
    return o; 
end

local function sliderControl(_silder,_scroll)
    local scroll_percent = (-_scroll:getInnerContainer():getPositionY())/
        (_scroll:getInnerContainer():getSize().height-_scroll:getSize().height)
--print("哈哈哈哈哈")
--_scroll:setScale(1.5)
    ui_slider:setValue(15*_sliderScale+(100-30*_sliderScale)*(1-scroll_percent))
end

local function update(dt)
    sliderControl(ui_slider,_pscroll)
end

scrollSlider.init = function(pscroll) --滑动层，
    local pscrollInnerSizeH = pscroll:getSize().height  --滑动层高度
    local sliderScale
    if pscrollInnerSizeH/pscroll:getInnerContainer():getSize().height <1
    then
        sliderScale =  pscrollInnerSizeH/pscroll:getInnerContainer():getSize().height
        ui_slider:getThumbSprite():setOpacity(255)
        ui_slider:getBackgroundSprite():setOpacity(255)
    else                                                --如果不需滑动，则不显示
        sliderScale =1
        ui_slider:getThumbSprite():setOpacity(0)
        ui_slider:getBackgroundSprite():setOpacity(0)
    end
    _sliderScale = sliderScale

    ui_slider:getThumbSprite():setTextureRect(cc.rect(0,0,105*sliderScale,5))  --初始化滑动块大小

    ui_slider:setValue(15*sliderScale) --初始化滑动块位置

    pscroll:getInnerContainer():setPositionY(-(pscroll:getInnerContainer():getSize().height-pscrollInnerSizeH))  --初始化滑动区域位置
end

scrollSlider.Create = function(self,bg,ps,ts,pscroll)
    _pscroll = pscroll
    local bg = cc.Sprite:create(bg)
    local ps = cc.Sprite:create(ps)
    local ts = cc.Sprite:create(ts,cc.rect(0,0,105,5))

    ui_slider = cc.ControlSlider:create(bg,ps,ts)

    ui_slider:setLocalZOrder(2)
    ui_slider:setAnchorPoint(0.5,0.5)
    ui_slider:setMinimumValue(0)
    ui_slider:setMaximumValue(100)
    ui_slider:setRotation(90)
    ui_slider:setEnabled(false)
    ui_slider:getThumbSprite():setOpacity(255)
    
    ui_slider:scheduleUpdateWithPriorityLua(update,0)
    scrollSlider.init(pscroll)
    return ui_slider
end


function scrollSliderCreate()
    -- body
    sliderInstance = scrollSlider:new()
    return sliderInstance
end
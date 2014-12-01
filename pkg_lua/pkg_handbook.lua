local handbookscene
local ui_widget
local _pbuttonTag = 101
local _cur_page =1

local function handBookPageInit(pages)
  local item_num = 67      --每类的道具总数
  local item_pages = math.ceil(item_num/12)  --每类的页数
  if _cur_page<1 then   _cur_page = 1 
  return
  elseif _cur_page>item_pages then _cur_page = item_pages
  return
  end
  
    local _container = ui_widget:getChildByName("_containerPanel") 
    local  function invisble()   --切换页面的时候有一个效果
        _container:setVisible(false)
    end
    local  delay = cc.DelayTime:create(0.05)
    local  function visble()
        _container:setVisible(true)
    end
     
    _container:runAction(cc.Sequence:create(cc.CallFunc:create(invisble),delay,cc.CallFunc:create(visble)))--cc.CallFunc:create(remove_child),
    _container:removeAllChildren()
    
    _cur_page =pages
  local text_cur_page = ui_widget:getChildByName("Label_page_cur")
  local text_all_page = ui_widget:getChildByName("Label_page_all")
  text_cur_page:setString(_cur_page.."/")
  text_all_page:setString(item_pages)   
     
    local table_handbook ={}
    local table_itemInfo={id=1,name="灵魂石(白虎)",frag_name="frag1.png",num=1,detail="小白虎",price=4000} --id,名称，数量，detail,价格
    table.insert(table_handbook,table_itemInfo)
    local function _handButtonInit()
        local _handBg = ccui.Button:create("res/handbook_Ui_1/handbook_equip_b.png","res/handbook_Ui_1/handbook_equip_b.png","")
        local _hand_maskcal = maskedHeroWithSprite("res/daota/"..table_handbook[1].id, 
            "res/daota/".."fragment2.png",
            "res/daota/"..table_handbook[1].frag_name)
            _handBg:addChild(_hand_maskcal)
            _hand_maskcal:setPosition(cc.p(_handBg:getContentSize().width/2,_handBg:getContentSize().height/2+15))
        local _hand_text = ccui.Text:create()
        _hand_text:setString(table_handbook[1].name)
        _hand_text:setFontSize(20)
        _hand_text:setColor(cc.c3b(128,0,2))
        _handBg:addChild(_hand_text)
        _hand_text:setPosition(cc.p(_handBg:getContentSize().width/2,_handBg:getContentSize().height/2-50))
        return _handBg
     end
     
     local count
    if (item_num-_cur_page*12)>=0 then count=12 else count= item_num-(_cur_page-1)*12 end
     for i=1,count,1 do
        local spr = _handButtonInit()
        _container:addChild(spr)
        if i==1 then spr:setPosition(cc.p(83,373))
        elseif  i==2 then spr:setPosition(cc.p(246,373))
        elseif  i==3 then spr:setPosition(cc.p(83,227))
        elseif  i==4 then spr:setPosition(cc.p(246,227))
        elseif  i==5 then spr:setPosition(cc.p(83,81))
        elseif  i==6 then spr:setPosition(cc.p(246,81))
        
        elseif  i==7 then spr:setPosition(cc.p(454,373))
        elseif  i==8 then spr:setPosition(cc.p(616,373))
        elseif  i==9 then spr:setPosition(cc.p(454,227))
        elseif  i==10 then spr:setPosition(cc.p(616,227))
        elseif  i==11 then spr:setPosition(cc.p(454,81))
        elseif  i==12 then spr:setPosition(cc.p(616,81))
        end
    end
end

local function titleChange(btnTag) 
    local title_text = ui_widget:getChildByName("label_title")
    local _str
    local action1 = cc.FadeOut:create(0.3)
    local action1Back = cc.FadeIn:create(0.1)
    local function changeStr()
       if btnTag == 101 then
          _str = "全  部" 
          elseif btnTag == 102 then
          _str = "力  量"
        elseif btnTag == 103 then
            _str = "敏  捷"
        elseif btnTag == 104 then
            _str = "智  力"
        elseif btnTag == 105 then
            _str = "最大生命值"
        elseif btnTag == 106 then
            _str = "物理攻击力"
        elseif btnTag == 107 then
            _str = "魔法强度"
        elseif btnTag == 108 then
            _str = "物理护甲"
        elseif btnTag == 109 then
            _str = "物理暴击 魔法暴击"
        elseif btnTag == 110 then
            _str = "每场战斗后恢复生命值"
        elseif btnTag == 111 then
            _str = "每场战斗后补充能量"
        elseif btnTag == 112 then
            _str = "治疗技能效果提高"
       end
        title_text:setString(_str)
    end
    title_text:runAction(cc.Sequence:create( action1,cc.CallFunc:create(changeStr), action1Back))
end

local function buttonInit()
--返回按钮
   local function _btouchEvent(sender,eventType)
      if eventType == ccui.TouchEventType.ended then 
        packageLogInMain()    --end之后的回调
       end
   end
   local _backbutton = ui_widget:getChildByName("back_button")
   _backbutton:addTouchEventListener(_btouchEvent)
--返回按钮 end
   
--分页按钮
   local function _pbuttonEnd(sender)  
        if sender:getTag()<=106 then   --改变按钮normal贴图
            sender:loadTextureNormal("res/handbook_Ui_1/handbook_left_select.png")
        else
            sender:loadTextureNormal("res/handbook_Ui_1/handbook_right_select.png")
        end
        
        local _cbutton = ui_widget:getChildByTag(_pbuttonTag) --回复之前改变的按钮状态
        _cbutton:setLocalZOrder(1)
        _cbutton:setScale(1)
        _cbutton:setTitleColor(cc.c3b(255,255,255))
        if _cbutton:getTag()<=106 then
            _cbutton:loadTextureNormal("res/handbook_Ui_1/handbook_left.png")
        else
            _cbutton:loadTextureNormal("res/handbook_Ui_1/handbook_right.png")
        end 
        _pbuttonTag = sender:getTag()

        --改变标题
        titleChange(_pbuttonTag)
   end

   local function _ptouchEvent(sender,eventType)
     if sender:getTag()~=_pbuttonTag then       --如果已经在当前页，则点击无效
        
            --        cclog("tag====".. _button:getTag()) 
            if eventType == ccui.TouchEventType.began then
            sender:setLocalZOrder(2)
            sender:setScale(1.1)
            sender:setTitleColor(cc.c3b(191,1,31))
        elseif eventType == ccui.TouchEventType.moved then
         --移动按钮没有操作
        elseif eventType == ccui.TouchEventType.canceled then   
            sender:setLocalZOrder(1)
        elseif eventType == ccui.TouchEventType.ended then 
            _pbuttonEnd(sender)  --改变分页按钮状态
            handBookPageInit(1)
        
        end    -- 触摸事件if end
     end       --判断是否当前页end
   end         --function-end
    for i=1,12,1 do
        local _cbutton = ui_widget:getChildByTag(100+i)
        _cbutton:addTouchEventListener(_ptouchEvent)
    end
--分页按钮end

--翻页
   local function _stouchEvent(sender,eventType)
       if eventType == ccui.TouchEventType.ended then 
            if sender:getName()=="page_scroll_left" then
                _cur_page = _cur_page-1
            else 
                _cur_page = _cur_page+1
            end
           handBookPageInit(_cur_page)
       end
   end
  local _button_scroll_left = ui_widget:getChildByName("page_scroll_left")
  local _button_scroll_right = ui_widget:getChildByName("page_scroll_right")
  _button_scroll_left:addTouchEventListener(_stouchEvent)
  _button_scroll_right:addTouchEventListener(_stouchEvent)
--
   handBookPageInit(1)
end


--//////////////////////////////
--继承BASELAYER后初始化
local LogInBOOKLayer = class("LogInBOOKLayer",BaseLayer)

function LogInBOOKLayer.extend(target)
    local t = tolua.getpeer(target)
    if not t then
        t = {}
        tolua.setpeer(target, t)
    end
    setmetatable(t, LogInBOOKLayer)
    return target
end

function LogInBOOKLayer:onEnter()
    cclog("LogInBOOKLayer:onEnter")
    buttonInit()   --按钮初始化
    
end

function LogInBOOKLayer:onExit()
    cclog("LogInBOOKLayer:onExit")

    local eventDispatcher = self:getEventDispatcher()
    eventDispatcher:removeEventListener(self._listener)

end

function LogInBOOKLayer:init()
    cclog("LogInBOOKLayer:init")

end

function LogInBOOKLayer.create()
    local layer = LogInBOOKLayer.extend(cc.Layer:create())
    cclog("LogInBOOKLayer:create")

    if nil ~= layer then
        -- layer:initExtend()
        local function onNodeEvent(event)
            --enterTransitionFinish

            if "enter" == event then
                layer:onEnter()
            elseif "exit" == event then
                layer:onExit()
            end
        end
        layer:registerScriptHandler(onNodeEvent)
    end

    return layer
end
--继承BASELAYER后初始化 end

function handbookLogInMain()
    --runFunc
    local function runFunc()
        local _uilayer = LogInBOOKLayer.create()
        handbookscene:addChild(_uilayer)
        ui_widget = ccs.GUIReader:getInstance():widgetFromJsonFile("res/handbook_Ui_1/handbook_Ui_1.json")
        print("LOGIN")
        _uilayer:addChild(ui_widget)

    end
    --run
    handbookscene = cc.Scene:create()
    if cc.Director:getInstance():getRunningScene() then
     if _uisceneStack[table.maxn(_uisceneStack)] ~= "handbookscene" then
        pushUIScene(handbookscene,"handbookscene")
        runFunc()
        end
    else
        cc.Director:getInstance():runWithScene(handbookscene)
    end
    
  
  

end
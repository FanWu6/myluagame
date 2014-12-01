require "Cocos2d"
require "Cocos2dConstants"
require "src/stg_lua/Stage_detail"

-- for CCLuaEngine traceback

--\\\\\\\\\
local stgscene
local ui_widget
local _pageview
local _pageview_ace
local _curpage   --当前页数
local _curlevel  --当前第几关卡
local _curStage  --normal/ace
local menuUIinstance = nil
--//////////

function ArrowChange(type)   --箭头更新
    local _btn_right = ui_widget:getChildByName("stage_ui"):getChildByName("btn_right")
    local _btn_left = ui_widget:getChildByName("stage_ui"):getChildByName("btn_left")
    local pageview_pre
    if type == "normal" then
        _curpage = _pageview:getCurPageIndex()+1
        pageview_pre = _pageview
    elseif type == "ace" then
        _curpage = _pageview_ace:getCurPageIndex()+1
        pageview_pre = _pageview_ace
    end

    if pageview_pre:getChildrenCount() ~=1 then
        if _curpage == 1 then _btn_left:setVisible(false) _btn_right:setVisible(true)
        elseif _curpage == pageview_pre:getChildrenCount() then _btn_right:setVisible(false) _btn_left:setVisible(true)
        else
            _btn_right:setVisible(true)
            _btn_left:setVisible(true)
        end
    elseif pageview_pre:getChildrenCount() ==1 then
        _btn_left:setVisible(false)
        _btn_right:setVisible(false)
    end
end



local function titleArrowChange(type) --标题更新
    ArrowChange(type)
    
    if type == "normal" then
    _curpage = _pageview:getCurPageIndex()+1
   
    elseif type == "ace" then
        _curpage = _pageview_ace:getCurPageIndex()+1
      
    end
    
 
    local action1 = cc.FadeOut:create(0.3)
    local action1Back = cc.FadeIn:create(0.1)
    local map_title = ui_widget:getChildByName("stage_ui"):getChildByName("map_title_text")
    local function changeStr()
        if _curpage == 1 then map_title:loadTexture("res/Stageselect_UI/maptitle-chapter1.png")
        elseif _curpage ==2 then map_title:loadTexture("res/Stageselect_UI/maptitle-chapter2.png") print("xxxxx")
        elseif _curpage ==3 then map_title:loadTexture("res/Stageselect_UI/maptitle-chapter3.png")
        end
    end

    map_title:runAction(cc.Sequence:create( action1,cc.CallFunc:create(changeStr), action1Back))
    --箭头改变
end

local function frameBgChange(type) -- 背景淡入淡出
    local _stage_frame = ui_widget:getChildByName("stage_frame")
    
    local _stage_nor_bg = _pageview:getPage(_pageview:getCurPageIndex())
    local _stage_ace_bg = _pageview_ace:getPage(_pageview_ace:getCurPageIndex())
    

    local action1 = cc.FadeOut:create(0.3)
    local action1Back = cc.FadeIn:create(0.1)
    local seq = cc.Sequence:create(action1,action1Back)
    local seq2 = cc.Sequence:create(action1Back,action1)
    if type == "normal" then
        local function changeStr()
         _stage_frame:loadTexture("res/Stageselect_UI/stage-map-frame.png")
           
        end
        _stage_frame:runAction(cc.Sequence:create(action1:clone(),cc.CallFunc:create(changeStr),action1Back:clone()))
        for i=1,_stage_nor_bg:getChildrenCount(),1 do
            _stage_nor_bg:getChildren()[i]:runAction(seq:clone())
            for j=1,_stage_nor_bg:getChildren()[i]:getChildrenCount(),1 do
                _stage_nor_bg:getChildren()[i]:getChildren()[j]:runAction(seq:clone())
            end
        end
        for i=1,_stage_ace_bg:getChildrenCount(),1 do
            _stage_ace_bg:getChildren()[i]:runAction(seq2:clone())
            for j=1,_stage_ace_bg:getChildren()[i]:getChildrenCount(),1 do
                _stage_ace_bg:getChildren()[i]:getChildren()[j]:runAction(seq2:clone())
            end
        end
    elseif type == "ace" then 
        local function changeStr()
            _stage_frame:loadTexture("res/Stageselect_UI/stage-map-elite-frame.png")
        end
        _stage_frame:runAction(cc.Sequence:create(action1:clone(),cc.CallFunc:create(changeStr),action1Back:clone()))
--        _stage_ace_bg:getChildByName("stage_1_path"):runAction(seq)
--        _stage_ace_bg:runAction(cc.Sequence:create(action1,action1Back))
        for i=1,_stage_nor_bg:getChildrenCount(),1 do
            _stage_nor_bg:getChildren()[i]:runAction(seq2:clone())
            for j=1,_stage_nor_bg:getChildren()[i]:getChildrenCount(),1 do
                _stage_nor_bg:getChildren()[i]:getChildren()[j]:runAction(seq2:clone())
            end
        end
        for i=1,_stage_ace_bg:getChildrenCount(),1 do
            _stage_ace_bg:getChildren()[i]:runAction(seq:clone())
            for j=1,_stage_ace_bg:getChildren()[i]:getChildrenCount(),1 do
                _stage_ace_bg:getChildren()[i]:getChildren()[j]:runAction(seq:clone())
            end
        end
    end
end


function levelBtnInit(Stage_num,Stage_type)  --关卡初始化
    local function _ltouchEvent(sender,eventType)
        if eventType == ccui.TouchEventType.began then
            sender:setScale(0.9)
        elseif eventType == ccui.TouchEventType.moved then
        --移动按钮没有操作
        elseif eventType == ccui.TouchEventType.canceled then
            sender:setScale(1.0)
        elseif eventType == ccui.TouchEventType.ended then
            sender:setScale(1.0)
            local str = lua_string_split(sender:getName(),"_")
            local _stage = tonumber(str[2])
            local _level
            if Stage_type == "normal" then
            _level = tonumber(str[3])
            elseif Stage_type =="ace" then 
            _level = tonumber(str[5])
            end
            
--            print("xx=="..str[2])
            showDetail(menuUIinstance,ui_widget,_stage,_level,Stage_type)
        end
    end


    --/////////////   --普通关卡更新
     local function levelBtnUpdate_normal()
        local currStageData = Config._userData._uCurStage_normal[Stage_num+1]
        local _btnList = _pageview:getPage(Stage_num)
        local bbb = _btnList:getChildren()
        for i=1,_btnList:getChildrenCount(),1 do  --
            
            local index
            local _btn
            local str = lua_string_split(bbb[i]:getName(),"_")
            if str[1] =="btn" then
                index = tonumber(str[3])
                _btn = bbb[i]
                
            
--                print("index=======".. Stage_num)

        if currStageData[index].state =="keyida" then    --状态是可以打
                        _btn:setBright(true)
                        _btn:setTouchEnabled(true)
                elseif currStageData[index].state =="bukeyi" then  --状态是不可以打
                        _btn:setTouchEnabled(false)
                        _btn:setBright(false)
                elseif currStageData[index].state =="dawanle" then --状态是打完了
                    if currStageData[index].type == "big"  then --大关卡
                    _btn:removeAllChildren()
                    local star_bg = ccui.ImageView:create("res/Stageselect_UI/stageselect_star_b.png")
                            _btn:addChild(star_bg)
                            star_bg:setPosition(cc.p(_btn:getSize().width/2,_btn:getSize().height/2-55))
   
                        if currStageData[index].star==1 then  --1星
                                local spr = ccui.ImageView:create("res/Stageselect_UI/stageselect_sta.png")
                                spr:setPosition(cc.p(_btn:getSize().width/2,_btn:getSize().height/2-55))
                        _btn:addChild(spr)
                        elseif currStageData[index].star==2 then --2星
                            local spr1 = ccui.ImageView:create("res/Stageselect_UI/stageselect_sta.png")
                        spr1:setPosition(cc.p(_btn:getSize().width/2+13,_btn:getSize().height/2-55))
                            _btn:addChild(spr1)
                            local spr2 = ccui.ImageView:create("res/Stageselect_UI/stageselect_sta.png")
                            spr2:setPosition(cc.p(_btn:getSize().width/2-13,_btn:getSize().height/2-55))
                            _btn:addChild(spr2)
                        elseif currStageData[index].star==3 then --3星
                            local spr1 = ccui.ImageView:create("res/Stageselect_UI/stageselect_sta.png")
                            spr1:setPosition(cc.p(_btn:getSize().width/2,_btn:getSize().height/2-55))
                            _btn:addChild(spr1)
                            local spr2 = ccui.ImageView:create("res/Stageselect_UI/stageselect_sta.png")
                            spr2:setPosition(cc.p(_btn:getSize().width/2-25,_btn:getSize().height/2-51))
                            _btn:addChild(spr2)
                            local spr3 = ccui.ImageView:create("res/Stageselect_UI/stageselect_sta.png")
                            spr3:setPosition(cc.p(_btn:getSize().width/2+25,_btn:getSize().height/2-51))
                            _btn:addChild(spr3)
                        end
                        --currStageData[i].type =="small" then   --如果没星，则是小关卡，则以后都不能打了，改变其disabled资源
                else 
                    _btn:loadTextureDisabled("res/Stageselect_UI/stagecircle_elit.png")
                    _btn:setTouchEnabled(false)
                    _btn:setBright(false)  
                end
                end
                _btn:addTouchEventListener(_ltouchEvent)
        end
       end
        
    end
    --///////////// 精英关卡更新
    

    
    --////
    local function levelBtnUpdate_ace()
        local currStageData = Config._userData._uCurStage_ace[Stage_num+1]
        local _btnList = _pageview_ace:getPage(Stage_num)
        local bbb = _btnList:getChildren()
        print("初始化第"..Stage_num+1)
        
     
        for i=1,_btnList:getChildrenCount(),1 do  --
            
            local index
            local _btn
            local str = lua_string_split(bbb[i]:getName(),"_")
            if str[4] =="a" then
                index = tonumber(str[5])
                _btn = bbb[i]
                
            
--                print("index=======".. i)

            if currStageData[index].state =="keyida" then    --状态是可以打
                _btn:setBright(true)
                _btn:setTouchEnabled(true)
            elseif currStageData[index].state =="bukeyi" then  --状态是不可以打
                _btn:setTouchEnabled(false)
                _btn:setBright(false)
            elseif currStageData[index].state =="dawanle" then --状态是打完了
                if currStageData[index].type == "big"  then --大关卡
                    _btn:removeAllChildren()
                    local star_bg = ccui.ImageView:create("res/Stageselect_UI/stageselect_star_b.png")
                    _btn:addChild(star_bg)
                    star_bg:setPosition(cc.p(_btn:getSize().width/2,_btn:getSize().height/2-55))
                        if currStageData[index].star==1 then  --1星
                        local spr = ccui.ImageView:create("res/Stageselect_UI/stageselect_sta.png")
                        spr:setPosition(cc.p(_btn:getSize().width/2,_btn:getSize().height/2-55))
                        _btn:addChild(spr)
                    elseif currStageData[index].star==2 then --2星
                        local spr1 = ccui.ImageView:create("res/Stageselect_UI/stageselect_sta.png")
                        spr1:setPosition(cc.p(_btn:getSize().width/2+13,_btn:getSize().height/2-55))
                            _btn:addChild(spr1)
                            local spr2 = ccui.ImageView:create("res/Stageselect_UI/stageselect_sta.png")
                        spr2:setPosition(cc.p(_btn:getSize().width/2-13,_btn:getSize().height/2-55))
                        _btn:addChild(spr2)
                    elseif currStageData[index].star==3 then --3星
                        local spr1 = ccui.ImageView:create("res/Stageselect_UI/stageselect_sta.png")
                            spr1:setPosition(cc.p(_btn:getSize().width/2,_btn:getSize().height/2-55))
                            _btn:addChild(spr1)
                        local spr2 = ccui.ImageView:create("res/Stageselect_UI/stageselect_sta.png")
                        spr2:setPosition(cc.p(_btn:getSize().width/2-25,_btn:getSize().height/2-51))
                        _btn:addChild(spr2)
                        local spr3 = ccui.ImageView:create("res/Stageselect_UI/stageselect_sta.png")
                            spr3:setPosition(cc.p(_btn:getSize().width/2+25,_btn:getSize().height/2-51))
                            _btn:addChild(spr3)
                        end
                        --Config._userData._uCurStage_normal[i].type =="small" then   --如果没星，则是小关卡，则以后都不能打了，改变其disabled资源
                    else 
                    _btn:loadTextureDisabled("res/Stageselect_UI/stagecircle_elit.png")
                    _btn:setTouchEnabled(false)
                    _btn:setBright(false)  
                 end
                end
                _btn:addTouchEventListener(_ltouchEvent)
        end
        end
    end
    
    
    

    if Stage_type=="normal" then levelBtnUpdate_normal()
       end
       
    if Stage_type=="ace" then levelBtnUpdate_ace()
    end       

end

local function buttonInit()  --按钮初始化
--//精英
    for i=0,_pageview_ace:getChildrenCount()-1,1 do
        levelBtnInit(i,"ace")
    end
--//普通
    --关卡按钮初始化
    for i=0,_pageview:getChildrenCount()-1,1 do
        levelBtnInit(i,"normal")
    end
    
    

--关卡按钮初始化end

--普通/精英切换
    local _btn_normal = ui_widget:getChildByName("stage_ui"):getChildByName("btn_normal")
    local _btn_ace = ui_widget:getChildByName("stage_ui"):getChildByName("btn_ace")
    local function _ptouchEvent(sender,eventType)
       if eventType == ccui.TouchEventType.began then

        elseif eventType == ccui.TouchEventType.moved then
        --移动按钮没有操作
        elseif eventType == ccui.TouchEventType.canceled then

        elseif eventType == ccui.TouchEventType.ended then
            local _btn = sender
            if _btn:getName() == "btn_normal" and _curStage=="ace" then   --切换到普通关卡
--                 _curpage = _pageview:getCurPageIndex()+1
                _btn_normal:loadTextureNormal("res/Stageselect_UI/stageselect_difficulty_button_selecte.png")
                _btn_ace:loadTextureNormal("res/Stageselect_UI/stageselect_difficulty_button_norma.png")
                _pageview_ace:setLocalZOrder(0)
            _pageview:setLocalZOrder(1)
            _curStage ="normal"
            if _curStage=="normal" then
            titleArrowChange("normal")
            end
                frameBgChange("normal")
            _pageview:setEnabled(true)
            _pageview_ace:setEnabled(false)
            
        elseif _btn:getName() == "btn_ace" and _curStage=="normal"then  --切换到精英关卡
--            _curpage = _pageview_ace:getCurPageIndex()+1
                _btn_ace:loadTextureNormal("res/Stageselect_UI/stageselect_difficulty_button_selecte.png")
                _btn_normal:loadTextureNormal("res/Stageselect_UI/stageselect_difficulty_button_norma.png")
            _pageview_ace:setLocalZOrder(1)
            _pageview:setLocalZOrder(0)
            _curStage="ace"
            if _curStage=="ace" then
            titleArrowChange("ace")
            end
            frameBgChange("ace")
            _pageview:setEnabled(false)
            _pageview_ace:setEnabled(true)
            
            end
        end
    end
    
    _btn_normal:addTouchEventListener(_ptouchEvent)
    _btn_ace:addTouchEventListener(_ptouchEvent)
    
    
    --滑页事件初始化    
    local function _npageViewEvent(sender, eventType)
        if eventType == ccui.PageViewEventType.turning then
            local pageView = sender
            local pageInfo = string.format("page %d " , pageView:getCurPageIndex() + 1)
            
            
                if pageView:getName()=="stage_pageview_nor"then
                    if _curStage == "normal" and _curpage ~= _pageview:getCurPageIndex()+1 then
                         titleArrowChange("normal")
                    end
                elseif pageView:getName()=="stage_pageview_ace"then
                     if _curStage == "ace"and _curpage ~= _pageview_ace:getCurPageIndex()+1 then
                         titleArrowChange("ace")
                            end
                        end
                    end
                end
    _pageview:addEventListenerPageView(_npageViewEvent) 
    _pageview_ace:addEventListenerPageView(_npageViewEvent)
    if _curStage == "normal" then
    titleArrowChange("normal")
    end
    --箭头初始化
    local function _atouchEvent(sender,eventType)
        if eventType == ccui.TouchEventType.ended  then 
          if _curStage=="normal" then
            if (sender:getName() == "btn_right") and (_curpage< _pageview:getChildrenCount()) then
                _pageview:scrollToPage(_pageview:getCurPageIndex()+1)
                print("右翻")
            elseif  (sender:getName() == "btn_left") and(_curpage>1)then
                _pageview:scrollToPage(_pageview:getCurPageIndex()-1)
                print("左翻")
             end
          elseif _curStage=="ace" then
            if (sender:getName() == "btn_right") and (_curpage< _pageview_ace:getChildrenCount()) then
                _pageview_ace:scrollToPage(_pageview_ace:getCurPageIndex()+1)
                print("右翻")
            elseif  (sender:getName() == "btn_left") and(_curpage>1)then
                _pageview_ace:scrollToPage(_pageview_ace:getCurPageIndex()-1)
                print("左翻")
            end
          end   
      end
    end
    
    local _btn_right = ui_widget:getChildByName("stage_ui"):getChildByName("btn_right")
    _btn_right:addTouchEventListener(_atouchEvent)
    local _btn_left = ui_widget:getChildByName("stage_ui"):getChildByName("btn_left")
    _btn_left:addTouchEventListener(_atouchEvent)
    local move1 = cc.MoveBy:create(0.7,cc.p(10,0))
    local move1_r = move1:reverse()
    local seq1  = cc.Sequence:create(move1,move1_r)
    _btn_left:runAction(cc.RepeatForever:create(seq1)) 
    
    local move2 = cc.MoveBy:create(0.7,cc.p(-10,0))
local move2_r = move2:reverse()
    local seq2  = cc.Sequence:create(move2,move2_r)
    _btn_right:runAction(cc.RepeatForever:create(seq2)) 
    
    if _curpage == 1 then _btn_left:setVisible(false)
    elseif _curpage == _pageview:getChildrenCount() then _btn_right:setVisible(false)
    else
        _btn_right:setVisible(true)
        _btn_left:setVisible(true)
    end
end

--继承BASELAYER后初始化
local LogInSTGLayer = class("LogInSTGLayer",BaseLayer)

function LogInSTGLayer.extend(target)
    local t = tolua.getpeer(target)
    if not t then
        t = {}
        tolua.setpeer(target, t)
    end
    setmetatable(t, LogInSTGLayer)
    return target
end

function LogInSTGLayer:onEnter()
    cclog("LogInSTGLayer:onEnter")
    --菜单初始化
    menuUIinstance = menuUI:createmenuUI("close",true)
    menuUIinstance:setName("menuUIinstance")
    ui_widget:addChild(menuUIinstance,10)
    menuUIinstance:changeData()
    --按钮初始化
    buttonInit()

end

function LogInSTGLayer:onExit()
    cclog("LogInSTGLayer:onExit")

    local eventDispatcher = self:getEventDispatcher()
    eventDispatcher:removeEventListener(self._listener)

    menuUIinstance= nil
    ui_widget:getChildByName("menuUIinstance"):removeFromParent()

end

function LogInSTGLayer:init()
    cclog("LogInSTGLayer:init")
end

function LogInSTGLayer.create()
    local layer = LogInSTGLayer.extend(cc.Layer:create())
    cclog("LogInSTGLayer:create")

    if nil ~= layer then
               layer:init()
        local function onNodeEvent(event)

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

function stageSelectLogIn()
    collectgarbage("collect")
    -- avoid memory leak
    collectgarbage("setpause", 100)
    collectgarbage("setstepmul", 5000)
    
    --runFunc
    local function runFunc()

        ui_widget = ccs.GUIReader:getInstance():widgetFromJsonFile("res/Stageselect_UI/Stageselect_UI_1.json")
        local _uilayer = LogInSTGLayer.create()
        stgscene:addChild(_uilayer)
        _uilayer:addChild(ui_widget)

        _pageview = ui_widget:getChildByName("stage_pageview_nor")
        _pageview_ace = ui_widget:getChildByName("stage_pageview_ace")

        _curStage = "normal"
        print("_uYXFB====="..MyUserData._userData._uYXFB)

        for i=1,MyUserData._userData._uPTFB,1 do
            if MyUserData._userData._uPTFB<2 then
                local xx = ccs.GUIReader:getInstance():widgetFromJsonFile("res/Stageselect_UI/stageselect_map"..tostring(i+1)..".json")
                _pageview:addPage(xx)
            end
        end


        for i=1,MyUserData._userData._uYXFB,1 do
            if MyUserData._userData._uYXFB<2 then
                local xx = ccs.GUIReader:getInstance():widgetFromJsonFile("res/Stageselect_UI/stageselect_map"..tostring(i+1)..".json")
                for i=1,xx:getChildrenCount(),1 do
                    local _btn = xx:getChildren()[i]
                    local str = lua_string_split(_btn:getName(),"_")
                    if str[4]=="b" then
                        _btn:loadTextureDisabled("res/Stageselect_UI/stagecircle_elit.png")
                        _btn:setTouchEnabled(false)
                        _btn:setBright(false) 
                    end
                end
                _pageview_ace:addPage(xx)
            end
        end
        _pageview_ace:scrollToPage(MyUserData._userData._uYXFB)
        _pageview:scrollToPage(MyUserData._userData._uPTFB)

        local _stage_ace_bg = _pageview_ace:getPage(_pageview_ace:getCurPageIndex())

        _pageview_ace:setEnabled(false)
        for i=1,_stage_ace_bg:getChildrenCount(),1 do
            _stage_ace_bg:getChildren()[i]:setOpacity(0)
        end
        --    ConfigData.readData()
        --ConfigData._userData._uCurStage_normal =1 
        --ConfigData:saveData()
        --    print("xx=="..ConfigData._userData._uCurStage_normal)
        _curpage =1
        _curlevel = Config._userData._uCurStage_normal

        buttonInit()

    end 
    -- run
    stgscene = cc.Scene:create()


    if cc.Director:getInstance():getRunningScene() then
         if _uisceneStack[table.maxn(_uisceneStack)] ~= "stgscene" then
                 pushUIScene(stgscene,"stgscene")
                 runFunc()
        end
    else
        cc.Director:getInstance():runWithScene(stgscene)
    end
    
    
end


--local status, msg = xpcall(stageSelectLogIn, __G__TRACKBACK__)
--if not status then
--    error(msg)
--end

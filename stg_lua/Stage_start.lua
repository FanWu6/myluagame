local ui_widget
local fightlist = {}  --出站列表
local current_type = "all"

local heroopenlist

local fightBtnlist = {}

local pos = {}
local isClicked = true
--
local isFirEnter --是否第一次进界面
--根据英雄等级，品阶，ID排序
local function sortLevelByType(a,b) 
    if (a._heroData.rlvl == b._heroData.rlvl) then
        if (a._heroData.gradation==b._heroData.gradation) then
            return a._heroData.roleId > b._heroData.roleId
        else 
            return a._heroData.gradation>b._heroData.gradation
        end
    else
        return a._heroData.rlvl > b._heroData.rlvl
    end
end 
--根据不同的页签获取不同的数据并排序
local function getDataByType(heroType,heroisOpen)
    local result = {}
    local ipairsObj
    if heroisOpen == true then
        ipairsObj = userOpeheroData
    else
        ipairsObj = userLockheroData
    end

    for i,v in ipairs(ipairsObj) do
        if heroType == "all" then
            table.insert(result,v)
        elseif heroType == "qianpai" and v._heroData.standSlot == 0 then
            table.insert(result,v)
        elseif heroType == "zhongpai" and v._heroData.standSlot == 1 then
            table.insert(result,v)
        elseif heroType == "houpai" and v._heroData.standSlot == 2 then
            table.insert(result,v)
        end
    end
    table.sort(result,sortLevelByType)
    return result
end
--
local function getheroObj(_heroId)  --获取当前所点击的英雄对象
    local heroopenlist = getDataByType("all",true)
    local heroObj
    for i,v in ipairs(heroopenlist) do
        if v._heroData.roleId == _heroId then
           heroObj = v
           return heroObj
        end
    end
end
--

--
local function updatefightlist(_heroBtn,_heroId,_Opacity)  --更新出战列表
    local index = -1    
    --更新蒙版以及出战列表
    local _heroObj = getheroObj(_heroId)
    if table.maxn(fightlist) == 0 then    --如果列表为空，则先添加
        local fighthero = DeepCopy(_heroObj)
        table.insert(fightlist,fighthero)
        fighthero._heroData.heroBtn = _heroBtn
        fighthero._heroData.isBattled = true
    else
--            for i,v in ipairs(fightlist) do
              for i =1,table.maxn(fightlist),1 do
                if fightlist[i]._heroData.roleId == _heroId then   --所点击的英雄在出战列表里
                    index = i
                    table.remove(fightlist,index)
                    break;     
                else 
                   if i == table.maxn(fightlist) then  --所点击的英雄NO在出战列表里
                         if table.maxn(fightlist) <5 then
                             local _heroObj = getheroObj(_heroId)
                             local fighthero = DeepCopy(_heroObj)
                             table.insert(fightlist,fighthero)
                             print(_heroObj._heroData.roleId)
                             print(table.maxn(fightlist))
                             
                            fighthero._heroData.heroBtn = _heroBtn
                            fighthero._heroData.isBattled = true
                         else
                             print("出战的满了")
                         end
                   end                                    
                end
            end
    end
    --根据英雄站位，ID排序
    local function sortstandSlotByType(a,b) 
        if (a._heroData.standSlot==b._heroData.standSlot) then
            return a._heroData.roleId > b._heroData.roleId
        else 
            return a._heroData.standSlot>b._heroData.standSlot
        end
    end 
    
    --重新排序出战列表
    for i,v in ipairs(fightlist) do
        table.sort(fightlist,sortLevelByType)
    end
    --重置位置
    local function resetClick()
        isClicked = true
        print("111")
    end
    
    
    for i=1,table.maxn(fightlist),1 do
        local move = cc.MoveTo:create(0.2,pos[i])
--            fightlist[i]._heroData.heroBtn:runAction(move)
        local scale_ease1 = cc.EaseBackOut:create(move)
        fightlist[i]._heroData.heroBtn:runAction(scale_ease1)
    end
    
    if _Opacity == 255 then
        ui_widget:runAction(cc.Sequence:create(cc.DelayTime:create(0.25),cc.CallFunc:create(resetClick)))
    else
        ui_widget:runAction(cc.Sequence:create(cc.DelayTime:create(0.2),cc.CallFunc:create(resetClick)))
    end
    
end

--选择条
local function heroStartListInit(_heroOpebtn)    --传入的英雄按钮，在第几个位置
    local stage_hselec = ui_widget:getChildByName("stagehro_Panel"):getChildByName("stage_hselecbg")
    local mengban = _heroOpebtn:getChildByName("hero_mengban")
    
    if isClicked then
                --英雄按钮点击:
                local function btnClicked(sender,eventType)  
                    local _button = sender
                    --        cclog("tag====".. _button:getTag()) 
                    if eventType == ccui.TouchEventType.began then
                    elseif eventType == ccui.TouchEventType.moved then
                    --移动按钮没有操作                                                                                                             
                    elseif eventType == ccui.TouchEventType.canceled then   
                    elseif eventType == ccui.TouchEventType.ended then    
                         if isClicked then
                        
                                local ui_widget1 = ccs.GUIReader:getInstance():widgetFromJsonFile("res/HeroSceneUI/HeroDetailUI.json")
                                ui_widget:addChild(ui_widget1,11)
                                local function getheroObj()  --获取当前所点击的英雄对象
                                    local heroObj
                                    for i,v in ipairs(heroopenlist) do
                                        if v._heroData.roleId == sender:getTag() then
                                            heroObj = v
                                            return heroObj
                                        end
                                    end
                                end
                                local layer = cc.Layer:create()
                                ui_widget:addChild(layer)
                                HeroDetailInit(ui_widget1,layer:getEventDispatcher(),getheroObj())
                        
                        end
                    end
                end
                -- 1---5 的位置
                for i=1,5,1 do
                    local hrofra = stage_hselec:getChildByName("stage_hr"..i)
                    pos[i] = hrofra:convertToWorldSpace(cc.p(hrofra:getContentSize().width/2,hrofra:getContentSize().height/2-4))
                end
                --
            
                if mengban:getOpacity() == 0 then    --没打勾
                        if table.maxn(fightlist) <5 then
                        isClicked = false
                            --2.设置位置
                            local xx = _heroOpebtn:clone()
                            xx:setPosition(_heroOpebtn:convertToWorldSpace(cc.p(_heroOpebtn:getContentSize().width/2,_heroOpebtn:getContentSize().height/2)))
                            xx:getChildByName("hero_mengban"):setOpacity(0)
                            ui_widget:addChild(xx)
                            xx:addTouchEventListener(btnClicked)
                            xx:setTag(_heroOpebtn:getTag())
            
                            updatefightlist(xx,_heroOpebtn:getTag(),0)
            --                fightlist[i]._heroData.heroBtn = xx
            --                fightlist[i]._heroData.isBattled = true
                            --显示蒙版
                            _heroOpebtn:getChildByName("hero_mengban"):setOpacity(255)
                        else
                        print("高亮")
                        end
            --            end
                    --
                elseif mengban:getOpacity() == 255    then        --已经打钩  
                    --1 。位置ID
                     print("??====="..table.maxn(fightlist))
                    isClicked = false
                    for i=1,table.maxn(fightlist),1 do
                        if fightlist[i]._heroData.roleId == _heroOpebtn:getTag() then
            --                v._heroData.heroBtn
                            local xx = ui_widget:getChildByTag(_heroOpebtn:getTag())
                            local pos1 = _heroOpebtn:convertToWorldSpace(cc.p(_heroOpebtn:getContentSize().width/2,_heroOpebtn:getContentSize().height/2))
                            print("pos1x======"..pos1.x)
                        print("pos[1].x======"..pos[1].x)

                           
                    local moveback = cc.MoveBy:create(0.2,cc.p((pos1.x-pos[1].x)/4,(pos1.y-pos[1].y)/4))
                            
                            
                            local scale_ease1 = cc.EaseBackOut:create(moveback)
                            local fade = cc.FadeOut:create(0.15)
                            local function remove()
                                xx:removeFromParent()
                            end
                            xx:runAction(cc.Sequence:create(moveback,cc.CallFunc:create(remove)))
                            for i=1,xx:getChildrenCount(),1 do
                                xx:getChildren()[i]:runAction(fade:clone())
                            end
                            xx:runAction(fade)
            --                fightlist[i]._heroData.isBattled = false
            --                fightlist[i]._heroData.heroBtn = nil
                            _heroOpebtn:getChildByName("hero_mengban"):setOpacity(0)
                            updatefightlist(xx,_heroOpebtn:getTag(),255)
            --                table.remove(fightlist,i)
                            break;
                        end
                        end
                 --             
                end
    
    
    --
    end
   
end
--
local function heroStartListCreate(_heroOpebtn)    --传入的英雄按钮，在第几个位置
    local stage_hselec = ui_widget:getChildByName("stagehro_Panel"):getChildByName("stage_hselecbg")
    local listview = ui_widget:getChildByName("stagehro_Panel"):getChildByName("stage_fra2"):getChildByName("heroscroll")
    --英雄按钮点击
    local function btnClicked(sender,eventType)  
        local _button = sender
        --        cclog("tag====".. _button:getTag()) 
        if eventType == ccui.TouchEventType.began then
        elseif eventType == ccui.TouchEventType.moved then
        --移动按钮没有操作                                                                                                             
        elseif eventType == ccui.TouchEventType.canceled then   
        elseif eventType == ccui.TouchEventType.ended then     
            local ui_widget1 = ccs.GUIReader:getInstance():widgetFromJsonFile("res/HeroSceneUI/HeroDetailUI.json")
            ui_widget:addChild(ui_widget1,11)
            local function getheroObj()  --获取当前所点击的英雄对象
                local heroObj
                for i,v in ipairs(heroopenlist) do
                    if v._heroData.roleId == sender:getTag() then
                        heroObj = v
                        return heroObj
                    end
                end
            end
            local layer = cc.Layer:create()
            ui_widget:addChild(layer)
            HeroDetailInit(ui_widget1,layer:getEventDispatcher(),getheroObj())
        end
    end
    -- 1---5 的位置
    for i=1,5,1 do
        local hrofra = stage_hselec:getChildByName("stage_hr"..i)
        pos[i] = hrofra:convertToWorldSpace(cc.p(hrofra:getContentSize().width/2,hrofra:getContentSize().height/2))
    end
    --

        for i,v in ipairs(fightlist) do
                --2.设置位置
            if v._heroData.roleId == _heroOpebtn:getTag() then
                local hrofra = stage_hselec:getChildByName("stage_hr"..i)
                local xx = _heroOpebtn:clone()
--                xx:setPosition(_heroOpebtn:convertToWorldSpace(cc.p(_heroOpebtn:getContentSize().width/2,_heroOpebtn:getContentSize().height/2)))
                xx:setPosition(pos[i])
                xx:getChildByName("hero_mengban"):setOpacity(0)
                ui_widget:addChild(xx)
                xx:addTouchEventListener(btnClicked)
                xx:setTag(v._heroData.roleId)

                v._heroData.heroBtn = xx
                v._heroData.isBattled = true
           end
        end

--    for i=1,table.maxn(fightlist),1 do
----        local move = cc.MoveTo:create(0.5,pos[i])
--        fightlist[i]._heroData.heroBtn:setPosition(pos[i])
--    end

end
--滑动页面
local function StageScrollInit()
    local heroModel  = ui_widget:getChildByName("stagehro_Panel"):getChildByName("stagehro_btn")
    local listview = ui_widget:getChildByName("stagehro_Panel"):getChildByName("stage_fra2"):getChildByName("heroscroll")
    listview:removeAllChildren()
    
    --传入信息表
    print("current_type======"..current_type)
    local heroopenlist = getDataByType(current_type,true)
    
    local openNum = table.maxn(heroopenlist)


    local openlines = math.ceil(openNum/6)
    local opeSize = heroModel:getSize()

    listview:setInnerContainerSize(cc.size(780,12+openlines*opeSize.height+(openlines-1)*2))
    --end
    local function btnClicked(sender,eventType)  --英雄按钮点击
        local _button = sender
        --        cclog("tag====".. _button:getTag()) 
        if eventType == ccui.TouchEventType.began then
        elseif eventType == ccui.TouchEventType.moved then
        --移动按钮没有操作                                                                                                             
        elseif eventType == ccui.TouchEventType.canceled then   
        elseif eventType == ccui.TouchEventType.ended then     
            
                heroStartListInit(_button)
        end
    end


    for i,v in ipairs(heroopenlist) do
        --    for i=1,openNum,1 do    --初始化已开启的英雄

        local heroOpebtn = heroModel:clone()
        listview:addChild(heroOpebtn)
        heroOpebtn:setTag(v._heroData.roleId)
        --
        --
        local xx = math.floor((i-1)/6)  --第几行
        heroOpebtn:setPosition(cc.p(16+opeSize.width/2+(i-xx*6-1)*(opeSize.width+19),listview:getInnerContainer():getSize().height-opeSize.height/2-6-(opeSize.height+2)*xx))
        --信息初始化
        --1.头像
        --        local headspr = cc.Sprite:create("res/heroHeadpic/"..v._heroData.headpic)
        local headspr = ccui.ImageView:create("res/heroHeadpic/"..v._heroData.headpic)
        headspr:setEnabled(false)
        headspr:setScale(90/104)
        heroOpebtn:addChild(headspr)
        headspr:setPosition(cc.p(heroOpebtn:getContentSize().width/2,heroOpebtn:getContentSize().height/2+3))
        --4.等级
        local heroLvl = heroOpebtn:getChildByName("lvl_label")
        heroLvl:setString(v._heroData.rlvl)

        --7.星级
        local heroStar = heroOpebtn:getChildByName("hroStar")
        local sX = heroStar:getPositionX()
        local sY = heroStar:getPositionY()

        if v._heroData.starlvl ==2 then
            local star2 = heroStar:clone()
            heroOpebtn:addChild(star2,2,2)
            heroStar:setPosition(cc.p(sX-heroStar:getContentSize().width/2,sY))
            star2:setPosition(cc.p(sX+heroStar:getContentSize().width/2,sY))
        elseif v._heroData.starlvl ==3 then
            local star2 = heroStar:clone()
            heroOpebtn:addChild(star2,2,2)
            local star3 = heroStar:clone()
            heroOpebtn:addChild(star3,2,2)

            star2:setPosition(cc.p(sX+heroStar:getContentSize().width,sY))
            star3:setPosition(cc.p(sX-heroStar:getContentSize().width,sY))
        elseif v._heroData.starlvl ==4 then
            local star2 = heroStar:clone()
            local star3 = heroStar:clone()
            local star4 = heroStar:clone()
            heroOpebtn:addChild(star2,2,2)
            heroOpebtn:addChild(star3,2,2)
            heroOpebtn:addChild(star4,2,2)

            heroStar:setPosition(cc.p(sX-heroStar:getContentSize().width/2,sY))
            star2:setPosition(cc.p(sX+heroStar:getContentSize().width/2,sY))
            star3:setPosition(cc.p(sX+heroStar:getContentSize().width*3/2,sY))
            star4:setPosition(cc.p(sX-heroStar:getContentSize().width*3/2,sY))
        elseif v._heroData.starlvl ==5 then
            local star2 = heroStar:clone()
            local star3 = heroStar:clone()
            local star4 = heroStar:clone()
            local star5 = heroStar:clone()
            heroOpebtn:addChild(star2,2,2)
            heroOpebtn:addChild(star3,2,2)
            heroOpebtn:addChild(star4,2,2)
            heroOpebtn:addChild(star5,2,2)

            star2:setPosition(cc.p(sX+heroStar:getContentSize().width,sY))
            star3:setPosition(cc.p(sX+heroStar:getContentSize().width*2,sY))
            star4:setPosition(cc.p(sX-heroStar:getContentSize().width,sY))
            star5:setPosition(cc.p(sX-heroStar:getContentSize().width*2,sY))
        end
        
        --4.是否在出战列表中
        --4.1 如果出战则设置灰色
        local hearmengban = heroOpebtn:getChildByName("hero_mengban")
         for i=1,table.maxn(fightlist),1 do
             if fightlist[i]._heroData.roleId == v._heroData.roleId  then
                            hearmengban:setOpacity(255)
             end
         end
         --4.2如果是第一次进界面则创建新的按钮
        if isFirEnter then
                for i=1,table.maxn(fightlist),1 do
                    if fightlist[i]._heroData.roleId == v._heroData.roleId  then
                        hearmengban:setOpacity(255)
        --                heroStartListInit(heroOpebtn)
                        heroStartListCreate(heroOpebtn)
                        print("最新")
                        break
                    end
                end   
         end
        --5注册点击
        heroOpebtn:addTouchEventListener(btnClicked)     
        --6设置标记
        if i == table.maxn(heroopenlist) then
            isFirEnter = false
        end

    end
    --
end

local function buttonInit()
    local closeBtn = ui_widget:getChildByName("stagehro_Panel"):getChildByName("close_btn")
    local function _closeTouch(sender,eventType)
        if eventType == ccui.TouchEventType.began then
        elseif eventType == ccui.TouchEventType.moved then
        --移动按钮没有操作
        elseif eventType == ccui.TouchEventType.canceled then   
        elseif eventType == ccui.TouchEventType.ended then     
            ui_widget:removeFromParent()
        end
    end
    closeBtn:addTouchEventListener(_closeTouch)
    
    --分页按钮
    local pg_change_btn1 = ui_widget:getChildByName("stagehro_Panel"):getChildByName("page_change_btn1")
    local pg_change_btn2 = ui_widget:getChildByName("stagehro_Panel"):getChildByName("page_change_btn2")
    local pg_change_btn3 = ui_widget:getChildByName("stagehro_Panel"):getChildByName("page_change_btn3")
    local pg_change_btn4 = ui_widget:getChildByName("stagehro_Panel"):getChildByName("page_change_btn4")

    local function _ctouchEvent(sender,eventType)
        local _button = sender
        --        cclog("tag====".. _button:getTag()) 
        if eventType == ccui.TouchEventType.began then
            _button:setLocalZOrder(3)
        elseif eventType == ccui.TouchEventType.moved then
        --移动按钮没有操作
        elseif eventType == ccui.TouchEventType.canceled then   
            _button:setLocalZOrder(1)
        elseif eventType == ccui.TouchEventType.ended then     --end之后的回调

            for i=1,4,1 do
                local _cbutton = ui_widget:getChildByTag(798):getChildByTag(10+i)
                    _cbutton:loadTextureNormal("res/Stageselect_UI/page_change_btn2.png")
                if _cbutton == _button then else _cbutton:setLocalZOrder(1)
                    _cbutton:loadTextureNormal("res/Stageselect_UI/page_change_btn1.png")
                end     
            end
            --、、、、、、
            --分类按钮 end之后的回调
            local _page=_button:getTag()-10
            local type 
            if _page == 1 then type = "all"
            elseif _page == 2 then type = "qianpai"
            elseif _page == 3 then type = "zhongpai"
            elseif _page == 4 then type = "houpai"
            end
                if current_type ~= type then
                   current_type = type
                   StageScrollInit()
                    --滑动条初始化
                end
        end
    end  
    pg_change_btn1:addTouchEventListener(_ctouchEvent)
    pg_change_btn2:addTouchEventListener(_ctouchEvent)
    pg_change_btn3:addTouchEventListener(_ctouchEvent)
    pg_change_btn4:addTouchEventListener(_ctouchEvent)
end

function Stagestart(_ui_widget)
    ui_widget = _ui_widget
    current_type = "all"
    heroopenlist = getDataByType(current_type,true)
    isFirEnter = true
    
    
    buttonInit()
    StageScrollInit()
    
   
end
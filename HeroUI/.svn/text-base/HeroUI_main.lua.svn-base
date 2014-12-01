 require "src/HeroUI/HeroDetail"
local RichLabel = require "src/HeroUI/RichLabel"
local heroScene
local ui_widget
local layer
local menuUIinstance = nil

local current_type = "all"
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



function HeroUIscrollInit()  --英雄列表
    local heroOpeModel  = ui_widget:getChildByName("heroList_bg"):getChildByName("heroOpeModel")
    local heroLockModel  = ui_widget:getChildByName("heroList_bg"):getChildByName("heroLockModel")
    local listview = ui_widget:getChildByName("heroList_bg"):getChildByName("herolistview")
    listview:removeAllChildren()
    --传入信息表
    print("current_type======"..current_type)
    local heroopenlist = getDataByType(current_type,true)
    local herolocklist = getDataByType(current_type,false)
    local openNum = table.maxn(heroopenlist)
    local notopennum = table.maxn(herolocklist)


    local openlines = math.ceil(openNum/3)
    local notopenlines = math.ceil(notopennum/3)

    local opeSize = heroOpeModel:getSize()
    local lockSize = heroLockModel:getSize()

    listview:setInnerContainerSize(cc.size(955,150+openlines*opeSize.height+(openlines-1)*6+notopenlines*lockSize.height+(notopenlines-1)*6))
    --end
     local function btnClicked(sender,eventType)  --英雄按钮点击
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
            HeroDetailInit(ui_widget1,layer:getEventDispatcher(),getheroObj(),"hero")
        end
        end


    for i,v in ipairs(heroopenlist) do
--    for i=1,openNum,1 do    --初始化已开启的英雄
       
       local heroOpebtn = heroOpeModel:clone()
        listview:addChild(heroOpebtn)
        heroOpebtn:setTag(v._heroData.roleId)
        --
        heroOpebtn:addTouchEventListener(btnClicked)
        --
        local xx = math.floor((i-1)/3)
        heroOpebtn:setPosition(cc.p(opeSize.width/2+(i-xx*3-1)*(opeSize.width+13),listview:getInnerContainer():getSize().height-opeSize.height/2-10-(opeSize.height+6)*xx))
        --信息初始化
        --1.头像
--        local headspr = cc.Sprite:create("res/heroHeadpic/"..v._heroData.headpic)
        local headspr = ccui.ImageView:create("res/heroHeadpic/"..v._heroData.headpic)
        headspr:setEnabled(false)
        headspr:setScale(90/104)
        heroOpebtn:addChild(headspr)
        headspr:setPosition(heroOpebtn:getChildByName("heroHeadFrame"):getPosition())
        --2.类型
        local heroType = heroOpebtn:getChildByName("heroType")
        if v._heroData.style == 1 then
           heroType:loadTexture("res/HeroSceneUI/strength.png")
        elseif  v._heroData.style == 2 then
            heroType:loadTexture("res/HeroSceneUI/dexterity.png")
        elseif  v._heroData.style == 3 then
            heroType:loadTexture("res/HeroSceneUI/intelligence.png")
        end
        --3.名字
        local heroName = heroOpebtn:getChildByName("heroName")
        heroName:setString(v._heroData.roleName)
        --4.等级
        local heroLvl = heroOpebtn:getChildByName("lvl_label")
        heroLvl:setString("Lv."..v._heroData.rlvl)
        --5.装备
            for i=1,6,1 do
                local item_ = heroOpebtn:getChildByName("item"..i)
                if v._heroData["itemfra"..i] ~= nil then
                    local result = getTestDataById(v._heroData["itemfra"..i])
                    local xx = ccui.ImageView:create("res/daota/"..result._itemData.iIcon..".jpg")
                    heroOpebtn:addChild(xx)
                    xx:setPosition(cc.p(item_:getPositionX(),item_:getPositionY()))
                    xx:setScale(45/78)
                end
            end
        --6.技能
        for i=1,4,1 do
            local skill_ = heroOpebtn:getChildByName("skill"..i)
            if v._heroData["skilfra"..i] ~= nil then
--                local result = getTestDataById(v._heroData["itemfra"..i])
                local xx = ccui.ImageView:create("res/jinengIcon/"..v._heroData["skilfra"..i]..".jpg")
                heroOpebtn:addChild(xx)
                xx:setPosition(cc.p(skill_:getPositionX(),skill_:getPositionY()))
                xx:setScale(45/78)
            end
        end
        --7.星级
        local heroStar = heroOpebtn:getChildByName("heroStar")
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
        
    end
    
    
    --分割线
    local heroCutModel = ui_widget:getChildByName("heroList_bg"):getChildByName("heroCut")
    local heroCut = nil
    if notopennum ~= 0 then --如果英雄全部开启则无分割线
--        local heroCut = listview:getChildByName("heroCut")
        heroCut = heroCutModel:clone()
        listview:addChild(heroCut)
        heroCut:setPosition(cc.p(955/2,listview:getInnerContainer():getSize().height-opeSize.height/2-10-(opeSize.height+6)*(math.floor(1+(openNum-1)/3))+50))
    end
    --分割线end

    for i,v in ipairs(herolocklist) do   --初始化未开启的英雄
        local heroLokbtn = heroLockModel:clone()
        listview:addChild(heroLokbtn)
        local xx = math.floor((i-1)/3)
        heroLokbtn:setPosition(cc.p(lockSize.width/2+(i-xx*3-1)*(lockSize.width+13),heroCut:getPositionY()-(lockSize.height+6)*xx-lockSize.height/2-50))
        
        --1.头像
        local headspr = ccui.ImageView:create("res/heroHeadpic/"..v._heroData.headpic)
        local headspr = cc.Sprite:create("res/heroHeadpic/"..v._heroData.headpic)
        darkNode(headspr)
--        headspr:setEnabled(false)
        headspr:setScale(90/104)
        heroLokbtn:addChild(headspr)
        headspr:setPosition(heroLokbtn:getChildByName("heroHeadFrame"):getPosition())
        --2.类型
        local heroType = heroLokbtn:getChildByName("heroType")
        if v._heroData.style == 1 then
            heroType:loadTexture("res/HeroSceneUI/strength.png")
        elseif  v._heroData.style == 2 then
            heroType:loadTexture("res/HeroSceneUI/dexterity.png")
        elseif  v._heroData.style == 3 then
            heroType:loadTexture("res/HeroSceneUI/intelligence.png")
        end
        --3.名字
        local heroName = heroLokbtn:getChildByName("heroName")
        heroName:setString(v._heroData.roleName)
        --4.星级
        local heroStar = heroLokbtn:getChildByName("heroStar")
        local sX = heroStar:getPositionX()
        local sY = heroStar:getPositionY()
        
        if v._heroData.starlvl ==2 then
            local star2 = heroStar:clone()
            heroLokbtn:addChild(star2,2,2)
            heroStar:setPosition(cc.p(sX-heroStar:getContentSize().width/2,sY))
            star2:setPosition(cc.p(sX+heroStar:getContentSize().width/2,sY))
        elseif v._heroData.starlvl ==3 then
            local star2 = heroStar:clone()
            heroLokbtn:addChild(star2,2,2)
            local star3 = heroStar:clone()
            heroLokbtn:addChild(star3,2,2)

            star2:setPosition(cc.p(sX+heroStar:getContentSize().width,sY))
            star3:setPosition(cc.p(sX-heroStar:getContentSize().width,sY))
        elseif v._heroData.starlvl ==4 then
            local star2 = heroStar:clone()
            local star3 = heroStar:clone()
            local star4 = heroStar:clone()
            heroLokbtn:addChild(star2,2,2)
            heroLokbtn:addChild(star3,2,2)
            heroLokbtn:addChild(star4,2,2)

            heroStar:setPosition(cc.p(sX-heroStar:getContentSize().width/2,sY))
            star2:setPosition(cc.p(sX+heroStar:getContentSize().width/2,sY))
            star3:setPosition(cc.p(sX+heroStar:getContentSize().width*3/2,sY))
            star4:setPosition(cc.p(sX-heroStar:getContentSize().width*3/2,sY))
        elseif v._heroData.starlvl ==5 then
            local star2 = heroStar:clone()
            local star3 = heroStar:clone()
            local star4 = heroStar:clone()
            local star5 = heroStar:clone()
            heroLokbtn:addChild(star2,2,2)
            heroLokbtn:addChild(star3,2,2)
            heroLokbtn:addChild(star4,2,2)
            heroLokbtn:addChild(star5,2,2)

            star2:setPosition(cc.p(sX+heroStar:getContentSize().width,sY))
            star3:setPosition(cc.p(sX+heroStar:getContentSize().width*2,sY))
            star4:setPosition(cc.p(sX-heroStar:getContentSize().width,sY))
            star5:setPosition(cc.p(sX-heroStar:getContentSize().width*2,sY))
        end
    end
    print("hehehehe")
end
--分页按钮
local function buttonInit()
    local pg_change_btn1 = ui_widget:getChildByName("heroList_bg"):getChildByName("pg_change_btn1")
    local pg_change_btn2 = ui_widget:getChildByName("heroList_bg"):getChildByName("pg_change_btn2")
    local pg_change_btn3 = ui_widget:getChildByName("heroList_bg"):getChildByName("pg_change_btn3")
    local pg_change_btn4 = ui_widget:getChildByName("heroList_bg"):getChildByName("pg_change_btn4")

    local function _ctouchEvent(sender,eventType)
        local _button = sender
        --        cclog("tag====".. _button:getTag()) 
        if eventType == ccui.TouchEventType.began then
            _button:setLocalZOrder(3)
        elseif eventType == ccui.TouchEventType.moved then
        --移动按钮没有操作
        elseif eventType == ccui.TouchEventType.canceled then   
            _button:setLocalZOrder(0)
        elseif eventType == ccui.TouchEventType.ended then     --end之后的回调
           local name = _button:getName()
          
                for i=1,4,1 do
                    local _cbutton = ui_widget:getChildByTag(5):getChildByTag(10+i)
                    _cbutton:loadTextureNormal("res/HeroSceneUI/hero_item/page_change_btn2.png")
                    if _cbutton == _button then else _cbutton:setLocalZOrder(0)
                    _cbutton:loadTextureNormal("res/HeroSceneUI/hero_item/page_change_btn1.png")
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
                HeroUIscrollInit()
                    --滑动条初始化
                end
        end
    end  
    pg_change_btn1:addTouchEventListener(_ctouchEvent)
    pg_change_btn2:addTouchEventListener(_ctouchEvent)
    pg_change_btn3:addTouchEventListener(_ctouchEvent)
    pg_change_btn4:addTouchEventListener(_ctouchEvent)

end



--继承BASELAYER后初始化
local HeroSceneLayer = class("HeroSceneLayer",BaseLayer)

function HeroSceneLayer.extend(target)
    local t = tolua.getpeer(target)
    if not t then
        t = {}
        tolua.setpeer(target, t)
    end
    setmetatable(t, HeroSceneLayer)
    return target
end

function HeroSceneLayer:onEnter()
    cclog("HeroSceneLayer:onEnter")
    --菜单初始化
    menuUIinstance = menuUI:createmenuUI("close",true)
    menuUIinstance:setName("menuUIinstance")
    menuUIinstance:changeData()
    ui_widget:addChild(menuUIinstance,10)
end

function HeroSceneLayer:onExit()
    cclog("HeroSceneLayer:onExit")

    local eventDispatcher = self:getEventDispatcher()
    eventDispatcher:removeEventListener(self._listener)
    
    menuUIinstance= nil
    ui_widget:getChildByName("menuUIinstance"):removeFromParent()
end

function HeroSceneLayer:init()
    cclog("HeroSceneLayer:init")

end

function HeroSceneLayer.create()
    local layer = HeroSceneLayer.extend(cc.Layer:create())
    cclog("HeroSceneLayer:create")

    if nil ~= layer then
        layer:init()
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


function HeroSceneLogIn()
    print("英雄runc")
    local function runFunc()
        layer = HeroSceneLayer.create()
        heroScene:addChild(layer)
        ui_widget = ccs.GUIReader:getInstance():widgetFromJsonFile("res/HeroSceneUI/HeroSceneUI.json")
        layer:addChild(ui_widget)
        current_type = "all"
        buttonInit()
        HeroUIscrollInit()
  
--        local strArr = {}
--        strArr[1] = "[image=res/daota/1.jpg][/image][fontColor=f75d85 fontSize=20]hello world[/fontColor][fontColor=fefefe]这是测试代码[/fontColor][fontColor=ff7f00 fontName=ArialRoundedMTBold]看看效果如何[/fontColor][fontColor=3232cd]碉堡了吧!!![/fontColor][fontColor=42426f]哈哈哈哈哈哈!![/fontColor][image=res/daota/1.jpg scale=1.3][/image]" --图片
--        strArr[2] = "[image=wsk1.png][/image][image=wsk1.png][/image][image=wsk1.png][/image][image=wsk1.png][/image][image=wsk1.png][/image]"
--        strArr[3] = "[fontColor=f75d85 fontSize=20]hello world!!!!!![/fontColor]"
--        strArr[4] = "[fontColor=7f00ff fontSize=20]hello world[/fontColor][fontColor=123 fontSize=20]这是测试代码[/fontColor][fontColor=ff7f00 fontName=ArialRoundedMTBold]看看效果如何[/fontColor]"
--
--        local curWidth = 200
--        local curHeight = 200
--
--        local params = {
--            text = strArr[1],
--            dimensions = cc.size(curWidth, curHeight)
--        }
--
--        local testLabel = RichLabel:create(params)
--        testLabel:playFadeInAnim()
--        layer:addChild(testLabel,10)
--        testLabel:setPosition(300,600)
    end

    heroScene = cc.Scene:create()
    if cc.Director:getInstance():getRunningScene() then
        if _uisceneStack[table.maxn(_uisceneStack)] ~= "heroScene" then
            pushUIScene(heroScene,"heroScene")
            runFunc()
        end

    else
        cc.Director:getInstance():runWithScene(heroScene)
    end
    
   

end

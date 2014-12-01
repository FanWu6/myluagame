require "src/HeroUI/heroitemInfo"  --物品窗口
require "src/HeroUI/HeroJinjie"    --进阶窗口
require "src/HeroUI/HeroJinhua"    --进化窗口
require "src/HeroUI/HeroSkillPanel"    --技能
require "src/HeroUI/heroskillinfo"   --技能信息
local ui_widget
local herodetail_Panel
local heroHead_frame

local shengji
local heroObj
FS = {"idle","cheer","beaten","atk01","atk02","death","move","dizzy","skill","ult","play"}
F_STAND = 1
F_CHEER = 2
F_DAMAGED = 3
F_ATTACK1 = 4
F_ATTACK2 = 5
F_DEATH = 6
F_MOVE = 7
F_DIZZY = 8 --眩晕
F_SKILL = 9 --小技能施法
F_ULT = 10 --大技能
F_PLAY = 11 --技能效果的释放
--[[



--]]
--装备栏换图标
local changeItem

local layerEventDispatcher

local function _expBtnEvent(sender,eventType)
    local _button = sender
    --        cclog("tag====".. _button:getTag()) 
    if eventType == ccui.TouchEventType.began then
        _button:setLocalZOrder(3)
    elseif eventType == ccui.TouchEventType.moved then
    --移动按钮没有操作
    elseif eventType == ccui.TouchEventType.canceled then   
        _button:setLocalZOrder(0)
    elseif eventType == ccui.TouchEventType.ended then     --end之后的回调
           --扣除背包物品，添加经验，修改经验界面
        local currLvl = heroObj._heroData.rlvl
        local itemId = _button:getTag()
        local itemNum = getBagNumById(itemId)
        if itemNum>0 then
        
            addDataToBag(itemId,-1)
            changeHeroExp(heroObj,(itemId - 170000)*100)
            local heroPower = herodetail_Panel:getChildByName("heroInfo_bg"):getChildByName("heroExp")
            heroPower:setString("经验:"..heroObj._heroData.rexp.."/"..heroExpData[heroObj._heroData.rlvl]["heroExp"])
            print("之前等级====="..currLvl)
            print("之后等级====="..heroObj._heroData.rlvl)
            if currLvl < heroObj._heroData.rlvl then
                local herolvl = herodetail_Panel:getChildByName("heroInfo_bg"):getChildByName("heroLVL")
                herolvl:setString("等级:"..heroObj._heroData.rlvl)
            end
            shengji()
        end
        
    end
end  

shengji = function ()
    
    for i=1,4,1 do
        
        local item = getBagDataById(170000+i)
        local expImg = herodetail_Panel:getChildByName("herolvlup_bg"):getChildByName("exp_img"..i)
        local expBtn = herodetail_Panel:getChildByName("herolvlup_bg"):getChildByName("exp_btn"..i)
        expBtn:setTag(item.iId)
        --1.图标
        local frament,frag = ToolsgetItemIcon(item.iType,item.iTone)
        local  maskedCal = maskedHeroWithSprite("res/daota/"..item.iIcon, frament,frag)

        --currData[i]._itemData.iNum-currData[i]._itemData.iheroNum
        if item.iNum == 0 then
            darkNode(maskedCal)
        end
        expImg:addChild(maskedCal)
        maskedCal:setTag(10)
        maskedCal:setScale(90/108)
        maskedCal:setPosition(cc.p(expImg:getContentSize().width/2,expImg:getContentSize().height/2))

        --个数
        if item.iNum>1 then
            local text_num = ccui.Text:create()
            text_num:setAnchorPoint(1,0.5)
            text_num:setString(item.iNum)
            text_num:setFontSize(24)
            text_num:setPosition(maskedCal:getContentSize().width-10,20)
            maskedCal:addChild(text_num,2,10)
        end
        expBtn:addTouchEventListener(_expBtnEvent)
    end

end

local function sceneVisible(type)
    local herolvlup = herodetail_Panel:getChildByName("herolvlup_bg")--英雄升级
    local heroDetail=herodetail_Panel:getChildByName("heroDetail_bg")--英雄简介
    local shuxingScroll = herodetail_Panel:getChildByName("shuxingDetail_bg") --英雄属性
    local skl_panel = herodetail_Panel:getChildByName("hro_skl_panel") --英雄技能
    local hero_itemPanel = herodetail_Panel:getChildByName("hro_item_panel") --装备

    herolvlup:setVisible(false)
    heroDetail:setVisible(false)
    shuxingScroll:setVisible(false)
    skl_panel:setVisible(false)
    hero_itemPanel:setVisible(false)

    if type == "jianjie" then
        shuxingScroll:setVisible(true)
        heroDetail:setVisible(true)
    elseif type == "shengji" then
        shuxingScroll:setVisible(true)
        herolvlup:setVisible(true)
    elseif type == "jineng" then
        skl_panel:setVisible(true)
    elseif type == "item" then
        hero_itemPanel:setVisible(true)
    end

end

local function HeroPlist()
    ccs.ArmatureDataManager:getInstance():addArmatureFileInfo("res/HeroArmature/SM.png","res/HeroArmature/SM.plist","res/HeroArmature/SM.xml")
    local _armature = ccs.Armature:create("SM")
    _armature:getAnimation():play("idle")
    ui_widget:addChild(_armature,4)
    _armature:setPosition(cc.p(200,370))
    
    local function onTouchBegan(touch, event)
        local target = event:getCurrentTarget()
        local locationInNode = target:convertToNodeSpace(touch:getLocation())
        local s = target:getContentSize()
        local rect = cc.rect(0, 0, s.width, s.height)

        if cc.rectContainsPoint(rect, locationInNode) then
            return true
        end
        return false
    end
    local function onTouchMoved(touch, event)

    end
    local function onTouchEnded(touch, event)
        local target = event:getCurrentTarget()
        print("sprite onTouchesEnded..")
        local anmition={"atk01","skill","ult"}
        _armature:getAnimation():play(anmition[math.random(1,3)])
        sceneVisible("jianjie")
    end
    
    local listener1 = cc.EventListenerTouchOneByOne:create()
    listener1:setSwallowTouches(true)
    listener1:registerScriptHandler(onTouchBegan,cc.Handler.EVENT_TOUCH_BEGAN )
    listener1:registerScriptHandler(onTouchMoved,cc.Handler.EVENT_TOUCH_MOVED )
    listener1:registerScriptHandler(onTouchEnded,cc.Handler.EVENT_TOUCH_ENDED )
    layerEventDispatcher:addEventListenerWithSceneGraphPriority(listener1, _armature)
    
    local function animationEvent(armatureBack,movementType,movementID)
        local id = movementID
        if movementType == ccs.MovementEventType.complete then
            print(id)           
                if id == "atk01" then
                    armatureBack:getAnimation():play("idle")
                elseif id == "skill" then
                    armatureBack:getAnimation():play("idle")
                elseif id == "ult" then
                    armatureBack:getAnimation():play("idle")
                end
            end
            
     end
       _armature:getAnimation():setMovementEventCallFunc(animationEvent)
 end

function heroInfoInit() --英雄信息初始化
    local heroInfo = herodetail_Panel:getChildByName("heroInfo_bg") --英雄左边
    local shuxingScroll = herodetail_Panel:getChildByName("shuxingDetail_bg"):getChildByName("shuxinglistview") --英雄属性背景
    
    --1.英雄名字
    local heroName = heroInfo:getChildByName("heroName_text")
    heroName:setString(heroObj._heroData.roleName)
    --2.英雄等级
    local herolvl = heroInfo:getChildByName("heroLVL")
    herolvl:setString("等级:"..heroObj._heroData.rlvl)
    --3.英雄战斗力
    local heroPower = heroInfo:getChildByName("heroPower")
    heroPower:setString("战斗力:"..heroObj._heroData.battlepower)
    --4.英雄经验
    local heroPower = heroInfo:getChildByName("heroExp")
    heroPower:setString("经验:"..heroObj._heroData.rexp.."/"..heroExpData[heroObj._heroData.rlvl]["heroExp"])
    --5.英雄类型
    local heroType = heroInfo:getChildByName("heroType")
    if heroObj._heroData.style == 1 then
        heroType:loadTexture("res/HeroSceneUI/strength.png")
    elseif  heroObj._heroData.style == 2 then
        heroType:loadTexture("res/HeroSceneUI/dexterity.png")
    elseif  heroObj._heroData.style == 3 then
        heroType:loadTexture("res/HeroSceneUI/intelligence.png")
    end
    --6.英雄星级    
    for i=1,heroObj._heroData.starlvl,1 do
        local xx = heroInfo:getChildByName("heroStar"..i)
        xx:loadTexture("res/HeroSceneUI/star_yellow.png")
    end
    --7.升级
    local lvlup_btn = heroInfo:getChildByName("lvlup_btn")
    
    --8.英雄进阶经验
    local jhProgressBar= heroInfo:getChildByName("jh_ProgressBar")
    local texLabel = jhProgressBar:getChildByName("jh_label")
    --自己有用的灵魂石个数
    local soulSum
    local soulNum = getBagNumById(heroObj._heroData.soulID)
    if heroObj._heroData.starlvl ==1 then
        texLabel:setString(soulNum.."/"..20)
        soulSum=20
    elseif heroObj._heroData.starlvl == 2 then
        texLabel:setString(soulNum.."/"..50)
        soulSum=50
    elseif heroObj._heroData.starlvl == 3 then
        texLabel:setString(soulNum.."/"..100)
        soulSum=100
    elseif heroObj._heroData.starlvl == 4 then
        texLabel:setString(soulNum.."/"..150)
        soulSum=150
    else
        texLabel:setString("已进化至顶级")
    end
    --4 进度条
    if heroObj._heroData.starlvl ~= 5 then
         if soulNum < soulSum then
        jhProgressBar:setPercent((soulNum/soulSum)*100)
        else
            jhProgressBar:setPercent(100)
        end
    else
        jhProgressBar:setPercent(100)
    end
    --9.英雄技能
    --10.英雄装备
    --11.英雄属性
    local sxModel = herodetail_Panel:getChildByName("shuxingDetail_bg"):getChildByName("sxModelPanel")
    local sxpowGrow = shuxingScroll:getChildByName("sxpowGrow")  --力量成长
    sxpowGrow:getChildByName("bai_num"):setString(heroObj._heroData.powGrow)
    local sxagiGrow = shuxingScroll:getChildByName("sxagiGrow")  --敏捷成长
    sxagiGrow:getChildByName("bai_num"):setString(heroObj._heroData.agiGrow)
    local sxintGrow = shuxingScroll:getChildByName("sxintGrow")  --智力成长
    sxintGrow:getChildByName("bai_num"):setString(heroObj._heroData.intGrow)

    local powerModel = sxModel:clone()  --力量
    powerModel:getChildByName("typeLabel"):setString("力量")
    powerModel:getChildByName("bai_num"):setString(heroObj._heroData.power)
    powerModel:getChildByName("lan_num"):setString("+"..heroObj._heroData.gr_power)
    shuxingScroll:pushBackCustomItem(powerModel)
    powerModel:setName(powerModel)
    local agiModel = sxModel:clone()  --敏捷
    agiModel:getChildByName("typeLabel"):setString("敏捷")
    agiModel:getChildByName("bai_num"):setString(heroObj._heroData.agility)
    agiModel:getChildByName("lan_num"):setString("+"..heroObj._heroData.gr_agility)
    shuxingScroll:pushBackCustomItem(agiModel)
    agiModel:setName("agiModel")
    local intModel = sxModel:clone()  --智力
    intModel:getChildByName("typeLabel"):setString("敏捷")
    intModel:getChildByName("bai_num"):setString(heroObj._heroData.intellect)
    intModel:getChildByName("lan_num"):setString("+"..heroObj._heroData.gr_intellect)
    shuxingScroll:pushBackCustomItem(intModel)
    intModel:setName("intModel")
    local hpModel = sxModel:clone()  --基础生命值·
    hpModel:getChildByName("typeLabel"):setString("基础生命值")
    hpModel:getChildByName("bai_num"):setString(heroObj._heroData.hp)
    hpModel:getChildByName("lan_num"):setString("+"..heroObj._heroData.gr_hp)
    shuxingScroll:pushBackCustomItem(hpModel)
    hpModel:setName("hpModel")
    local phyAtkModel = sxModel:clone()  --物理攻击力
    phyAtkModel:getChildByName("typeLabel"):setString("基础生命值")
    phyAtkModel:getChildByName("bai_num"):setString(heroObj._heroData.phyAtk)
    phyAtkModel:getChildByName("lan_num"):setString("+"..heroObj._heroData.gr_phyAtk)
    shuxingScroll:pushBackCustomItem(phyAtkModel)
    phyAtkModel:setName("phyAtkModel")
    local magAtkModel = sxModel:clone()  --魔法强度
    magAtkModel:getChildByName("typeLabel"):setString("魔法强度")
    magAtkModel:getChildByName("bai_num"):setString(heroObj._heroData.magAtk)
    magAtkModel:getChildByName("lan_num"):setString("+"..heroObj._heroData.gr_magAtk)
    shuxingScroll:pushBackCustomItem(magAtkModel)
    magAtkModel:setName("magAtkModel")
    local phyDefModel = sxModel:clone()  --物理护甲
    phyDefModel:getChildByName("typeLabel"):setString("物理护甲")
    phyDefModel:getChildByName("bai_num"):setString(heroObj._heroData.phyDef)
    phyDefModel:getChildByName("lan_num"):setString("+"..heroObj._heroData.gr_phyDef)
    shuxingScroll:pushBackCustomItem(phyDefModel)
    phyDefModel:setName("magAtkModel")
    local magDefModel = sxModel:clone()  --魔法抗性
    magDefModel:getChildByName("typeLabel"):setString("魔法抗性")
    magDefModel:getChildByName("bai_num"):setString(heroObj._heroData.magDef)
    magDefModel:getChildByName("lan_num"):setString("+"..heroObj._heroData.gr_magDef)
    shuxingScroll:pushBackCustomItem(magDefModel)
    magDefModel:setName("magAtkModel")
    local phyCriModel = sxModel:clone()  --物理暴击
    phyCriModel:getChildByName("typeLabel"):setString("物理暴击")
    phyCriModel:getChildByName("bai_num"):setString(heroObj._heroData.phyCri)
    phyCriModel:getChildByName("lan_num"):setString("+"..heroObj._heroData.gr_phyCri)
    shuxingScroll:pushBackCustomItem(phyCriModel)
    phyCriModel:setName("phyCriModel")
    local magCriModel = sxModel:clone()  --魔法暴击
    magCriModel:getChildByName("typeLabel"):setString("魔法暴击")
    magCriModel:getChildByName("bai_num"):setString(heroObj._heroData.magCri)
    magCriModel:getChildByName("lan_num"):setString("+"..heroObj._heroData.gr_magCri)
    shuxingScroll:pushBackCustomItem(magCriModel)
    magCriModel:setName("magCriModel")
    local dodgeModel = sxModel:clone()  --闪避
    dodgeModel:getChildByName("typeLabel"):setString("闪避")
    dodgeModel:getChildByName("bai_num"):setString(heroObj._heroData.dodge)
    dodgeModel:getChildByName("lan_num"):setString("+"..heroObj._heroData.gr_dodge)
    shuxingScroll:pushBackCustomItem(dodgeModel)
    dodgeModel:setName("dodgeModel")
    local lifeRegeModel = sxModel:clone()  --生命回复
    lifeRegeModel:getChildByName("typeLabel"):setString("生命回复")
    lifeRegeModel:getChildByName("bai_num"):setString(heroObj._heroData.lifeRege)
    lifeRegeModel:getChildByName("lan_num"):setString("+"..heroObj._heroData.gr_lifeRege)
    shuxingScroll:pushBackCustomItem(lifeRegeModel)
    lifeRegeModel:setName("lifeRegeModel")
    local energyRegeModel = sxModel:clone()  --能量回复
    energyRegeModel:getChildByName("typeLabel"):setString("能量回复")
    energyRegeModel:getChildByName("bai_num"):setString(heroObj._heroData.energyRege)
    energyRegeModel:getChildByName("lan_num"):setString("+"..heroObj._heroData.gr_energyRege)
    shuxingScroll:pushBackCustomItem(energyRegeModel)
    energyRegeModel:setName("energyRegeModel")
    local phyIgnoreModel = sxModel:clone()  --物理护甲穿透
    phyIgnoreModel:getChildByName("typeLabel"):setString("物理护甲穿透")
    phyIgnoreModel:getChildByName("bai_num"):setString(heroObj._heroData.phyIgnore)
    phyIgnoreModel:getChildByName("lan_num"):setString("+"..heroObj._heroData.gr_phyIgnore)
    shuxingScroll:pushBackCustomItem(phyIgnoreModel)
    phyIgnoreModel:setName("phyIgnoreModel")
    local magIgnoreModel = sxModel:clone()  --魔法抗性穿透
    magIgnoreModel:getChildByName("typeLabel"):setString("魔法抗性穿透")
    magIgnoreModel:getChildByName("bai_num"):setString(heroObj._heroData.magIgnore)
    magIgnoreModel:getChildByName("lan_num"):setString("+"..heroObj._heroData.gr_magIgnore)
    shuxingScroll:pushBackCustomItem(magIgnoreModel)
    magIgnoreModel:setName("magIgnoreModel")
    local cureGrowModel = sxModel:clone()  --治疗效果提升
    cureGrowModel:getChildByName("typeLabel"):setString("治疗效果提升")
    cureGrowModel:getChildByName("bai_num"):setString(heroObj._heroData.cureGrow)
    cureGrowModel:getChildByName("lan_num"):setString("+"..heroObj._heroData.gr_cureGrow)
    shuxingScroll:pushBackCustomItem(cureGrowModel)
    cureGrowModel:setName("cureGrowModel")
    local getBloodModel = sxModel:clone()  --吸血等级
    getBloodModel:getChildByName("typeLabel"):setString("吸血等级")
    getBloodModel:getChildByName("bai_num"):setString(heroObj._heroData.getBlood)
    getBloodModel:getChildByName("lan_num"):setString("+"..heroObj._heroData.gr_getBlood)
    shuxingScroll:pushBackCustomItem(getBloodModel)
    getBloodModel:setName("getBloodModel")
    
    --11.英雄简洁
end



function HeroDetai_buttonInit()
    local heroInfo = herodetail_Panel:getChildByName("heroInfo_bg") --英雄左边
    local herolvlup = herodetail_Panel:getChildByName("herolvlup_bg")--英雄升级
    local heroDetail=herodetail_Panel:getChildByName("heroDetail_bg")--英雄简介
    local shuxingScroll = herodetail_Panel:getChildByName("shuxingDetail_bg"):getChildByName("shuxinglistview") --英雄属性背景
    local hero_itemPanel = herodetail_Panel:getChildByName("hro_item_Panel") --装备
    --7.升级
    local lvlup_btn = heroInfo:getChildByName("lvlup_btn")
    local function _lvlupEvent(sender,eventType)
        local _button = sender
        --        cclog("tag====".. _button:getTag()) 
        if eventType == ccui.TouchEventType.began then
            _button:setLocalZOrder(3)
        elseif eventType == ccui.TouchEventType.moved then
        --移动按钮没有操作
        elseif eventType == ccui.TouchEventType.canceled then   
            _button:setLocalZOrder(0)
        elseif eventType == ccui.TouchEventType.ended then     --end之后的回调
            sceneVisible("shengji")
            shengji()
        end
    end  
    lvlup_btn:addTouchEventListener(_lvlupEvent)
    --8.1英雄进阶
    local jinjie_panel = ui_widget:getChildByName("jinjie_Panel")
    local jinjie_btn = heroInfo:getChildByName("jinjie_btn")
    local function _jinjieEvent(sender,eventType)
        local _button = sender
        --        cclog("tag====".. _button:getTag()) 
        if eventType == ccui.TouchEventType.began then
            _button:setLocalZOrder(3)
        elseif eventType == ccui.TouchEventType.moved then
        --移动按钮没有操作
        elseif eventType == ccui.TouchEventType.canceled then   
            _button:setLocalZOrder(0)
        elseif eventType == ccui.TouchEventType.ended then     --end之后的回调
            jinjie_panel:setVisible(true)
            HeroJinjie(jinjie_panel,heroObj._heroData.roleName)
        end
    end  
    jinjie_btn:addTouchEventListener(_jinjieEvent)
    --8.2英雄进化
    local jinhua_panel = ui_widget:getChildByName("jinhua_Panel")
    local jinhua_btn = heroInfo:getChildByName("jh_btn")
    local function _jinhuaEvent(sender,eventType)
        local _button = sender
        --        cclog("tag====".. _button:getTag()) 
        if eventType == ccui.TouchEventType.began then
            _button:setLocalZOrder(3)
        elseif eventType == ccui.TouchEventType.moved then
        --移动按钮没有操作
        elseif eventType == ccui.TouchEventType.canceled then   
            _button:setLocalZOrder(0)
        elseif eventType == ccui.TouchEventType.ended then     --end之后的回调
            jinhua_panel:setVisible(true)
            HeroJinhua(jinhua_panel,heroObj)
        end
    end  
    jinhua_btn:addTouchEventListener(_jinhuaEvent)
    --9.英雄技能
    local function _itemEvent(sender,eventType) --技能栏按钮
        local _button = sender
        --        cclog("tag====".. _button:getTag()) 
        if eventType == ccui.TouchEventType.began then

        elseif eventType == ccui.TouchEventType.moved then
        --移动按钮没有操作
        elseif eventType == ccui.TouchEventType.canceled then   

        elseif eventType == ccui.TouchEventType.ended then     --end之后的回调
            local hero_skillPanel = herodetail_Panel:getChildByName("hro_skl_panel") --技能
            sceneVisible("jineng")
            if heroObj._heroData["skilfra"..sender:getTag()-200] ~= nil then
                heroSklInfo(hero_skillPanel,heroObj,sender:getTag()-200)
            else --如果点的技能栏为空则直接跳到换装界面
                local xx = ccs.GUIReader:getInstance():widgetFromJsonFile("res/HeroSceneUI/HeroSkill.json")
                cc.Director:getInstance():getRunningScene():addChild(xx,10)
                HeroSkillPanel(xx,hero_skillPanel,heroObj,sender:getTag()-200)
            end
        end
    end  

    for i=1,4,1 do
        local skill = heroInfo:getChildByName("skillFrame"..i)
        skill:removeAllChildren()
        print(heroObj._heroData["skilfra"..i])
        --heroObj._heroData.
        if heroObj._heroData["skilfra"..i] ~= nil then
--            local result = getTestDataById(heroObj._heroData["skilfra"..i])
            local xx = ccui.ImageView:create("res/jinengIcon/"..heroObj._heroData["skilfra"..i]..".jpg")
            xx:setEnabled(false)
            skill:addChild(xx)
            xx:setPosition(cc.p(skill:getContentSize().width/2,skill:getContentSize().height/2+2))
            xx:setScale(94/78)
        end
        skill:setTag(200+i)
        skill:addTouchEventListener(_itemEvent)

    end
    --10.英雄装备
    local function _itemEvent(sender,eventType) --装备栏按钮
        local _button = sender
        --        cclog("tag====".. _button:getTag()) 
        if eventType == ccui.TouchEventType.began then

        elseif eventType == ccui.TouchEventType.moved then
        --移动按钮没有操作
        elseif eventType == ccui.TouchEventType.canceled then   

        elseif eventType == ccui.TouchEventType.ended then     --end之后的回调
            local hero_itemPanel = herodetail_Panel:getChildByName("hro_item_panel") --装备
            sceneVisible("item")
            if heroObj._heroData["itemfra"..sender:getTag()-100] ~= nil then
                heroItmInfo(hero_itemPanel,heroObj,sender:getTag()-100)
            else --如果点的装备栏为空则直接跳到换装界面
                local xx = ccs.GUIReader:getInstance():widgetFromJsonFile("res/HeroSceneUI/HeroItem.json")
                cc.Director:getInstance():getRunningScene():addChild(xx,10)
                HeroItemPanel(xx,hero_itemPanel,heroObj,sender:getTag()-100)
            end
        end
    end  
    
    for i=1,6,1 do
        local item = heroInfo:getChildByName("itemFrame"..i)
        item:removeAllChildren()
        --heroObj._heroData.
            if heroObj._heroData["itemfra"..i] ~= nil then
                local result = getTestDataById(heroObj._heroData["itemfra"..i])
                local xx = ccui.ImageView:create("res/daota/"..result._itemData.iIcon..".jpg")
                xx:setEnabled(false)
                item:addChild(xx)
                xx:setPosition(cc.p(item:getContentSize().width/2,item:getContentSize().height/2+2))
                xx:setScale(94/78)
            end
                item:setTag(100+i)
                item:addTouchEventListener(_itemEvent)
        
    end
end


function HeroDetailInit(_ui_widget,EventDispatcher,_heroObj,path)
    ui_widget = _ui_widget
    layerEventDispatcher = EventDispatcher
    herodetail_Panel = ui_widget:getChildByName("Herodetail_Panel")
    --当前英雄对象
    heroObj = _heroObj
    
    local closeBtn = _ui_widget:getChildByName("close_btn")
    local function _closeTouch(sender,eventType)
        if eventType == ccui.TouchEventType.began then
        elseif eventType == ccui.TouchEventType.moved then
        --移动按钮没有操作
        elseif eventType == ccui.TouchEventType.canceled then   
        elseif eventType == ccui.TouchEventType.ended then     
          ui_widget:removeFromParent()
          if path == "hero" then
            HeroUIscrollInit()--英雄列表
          else
          end
        end
    end
    closeBtn:addTouchEventListener(_closeTouch)
--    loca
   
    heroInfoInit()
    HeroDetai_buttonInit()
    HeroPlist()           --英雄模型
end
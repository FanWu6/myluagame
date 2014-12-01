--界面，英雄名，灵魂石ID
local RichLabel = require "src/HeroUI/RichLabel"
local heroObj
local soulstonePanel
local stoneNum
local stoneSum

local function _stageBtnEvent(sender,eventType)
    local _button = sender
    if eventType == ccui.TouchEventType.began then
        _button:setScale(0.9)
    elseif eventType == ccui.TouchEventType.moved then
    --移动按钮没有操作
        _button:setScale(0.9)
    elseif eventType == ccui.TouchEventType.canceled then   
        _button:setScale(1)
    elseif eventType == ccui.TouchEventType.ended then     --end之后的回调
        --加灵魂石
        _button:setScale(1)
        addDataToBag(heroObj._heroData.soulID,1)
        print("||||||.."..getBagNumById(heroObj._heroData.soulID))
        stoneNum = getBagNumById(heroObj._heroData.soulID)
        --拥有的灵魂石
        local soulstoneNum =soulstonePanel:getChildByName("stg_panel"):getChildByName("soulstoneNum")
        soulstoneNum:setString(stoneNum)
        if stoneNum>=stoneSum then
            soulstoneNum:setColor(cc.c3b(255,255,255))
        else
            soulstoneNum:setColor(cc.c3b(247,5,9))
        end
    end
end  

function SoulstonePanel(_soulstonePanel,_heroObj,_stoneNum,_stoneSum)
    stoneSum=_stoneSum
    stoneNum= _stoneNum
    soulstonePanel=_soulstonePanel
    print("aaaaa")
    heroObj = _heroObj
    soulstonePanel:setVisible(true)
    local itemObj = getTestDataById(tonumber(heroObj._heroData.soulID))
    print("bbb==.."..heroObj._heroData.soulID)
    
    --英雄名
    local heroName = soulstonePanel:getChildByName("heroname")
    heroName:setString(heroObj._heroData.roleName)
    local stg_panel = soulstonePanel:getChildByName("stg_panel")
    --英雄图标
    local heroframe = stg_panel:getChildByName("heroframe")
    local heroImg = ccui.ImageView:create("res/heroHeadpic/"..heroObj._heroData.headpic)
    heroframe:addChild(heroImg)
    heroImg:setPosition(cc.p(heroframe:getContentSize().width/2,heroframe:getContentSize().height/2))
    heroImg:setScale(80/104)
    --拥有的灵魂石
    local soulstoneNum =stg_panel:getChildByName("soulstoneNum")
    soulstoneNum:setString(stoneNum)
    if stoneNum>=stoneSum then
       soulstoneNum:setColor(cc.c3b(255,255,255))
    else
        soulstoneNum:setColor(cc.c3b(247,5,9))
    end
    --需要灵魂石数量
    local soulstoneSum = stg_panel:getChildByName("soulstoneSum")
    soulstoneSum:setString("/"..stoneSum)
    --章节展示列表
    local stageListView = stg_panel:getChildByName("stage_listview")
    stageListView:removeAllChildren()
    --章节模板
    local stageBtnModel = stg_panel:getChildByName("stageBtnModel")
    
    local thingFramArr = lua_string_split(itemObj._itemData.thingsFrom,"_")
    for i=1,table.maxn(thingFramArr),1 do
        local stageBtn = stageBtnModel:clone()
        local charpterData = getCharpterDataById(tonumber(thingFramArr[i]))
        
        --名称
        local stageName = stageBtn:getChildByName("stageName")
        stageName:setString(charpterData["name"])
        
        local index = math.floor(tonumber(charpterData["id"])/10000)
        --章节
        local id = math.floor((tonumber(charpterData["id"]) - index*10000)/1000)
        
        local textStr = "[fontColor=ffffff fontSize=20]第"..id.."章[/fontColor]"
        if index==5 then
        --次数 Config._userData._uCurStage_ace[Stage_num+1]["剩余次数"]
        --红色
            textStr = textStr.."[fontColor=fc2704 fontSize=20]精英[/fontColor]"
        --次数 白色
            textStr = textStr.."[fontColor=fc2704 fontSize=20](3/3)[/fontColor]"
        else
            textStr = textStr.."[fontColor=ffffff fontSize=20]普通[/fontColor]"
        end
        
        
        local params = {
            text = textStr,
            dimensions = cc.size(169, 27)
        }
        local testLabel = RichLabel:create(params)
        testLabel:setAnchorPoint(cc.p(0,0.5))
        testLabel:setPosition(cc.p(73,57))
        stageBtn:addChild(testLabel)
        stageListView:pushBackCustomItem(stageBtn)
        
        stageBtn:addTouchEventListener(_stageBtnEvent)
        
        
    end 
    
    local close_btn=soulstonePanel:getChildByName("close_btn")
    local function _closeEvent(sender,eventType)
        local _button = sender
        if eventType == ccui.TouchEventType.began then
        elseif eventType == ccui.TouchEventType.moved then
        --移动按钮没有操作
        elseif eventType == ccui.TouchEventType.canceled then   

        elseif eventType == ccui.TouchEventType.ended then     --end之后的回调
            soulstonePanel:setVisible(false)
            updateJinhua()--刷新上级界面
        end
    end  
    close_btn:addTouchEventListener(_closeEvent)
    
end
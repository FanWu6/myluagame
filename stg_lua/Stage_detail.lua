require "src/stg_lua/Stage_output"
require "src/stg_lua/Stage_start"
local stageData={id=1,name="日光森林·山谷大门",desc="没有别的道路可以走，这个洞穴也许能穿过这座山，我闻到了闪电的味道",body=6,monsterList={101,102,103,104,105},itemList={106,107,108,109},state=0,starLevel=3}
local _uiPanel
local _stage
local _level
local menuUIinstance
local function levelWinHandle_normal() --普通胜利操作
    local ui = _uiPanel:getChildByName("stage_ui")
    local detailPanel = _uiPanel:getChildByName("stage_detail_panel")

    local last_index --关卡数据table中，本章最后一关的id
    local _pageview = _uiPanel:getChildByName("stage_pageview_nor")
--    if _stage >1 then
--        for j=2,_stage,1 do
--            index_sum = index_sum+_pageview:getPage(j-2):getChildrenCount()-2
--        end
--    end
    
    local currStageData = Config._userData._uCurStage_normal[_stage]

    currStageData[_level].state = "dawanle"

    local star_random = 1+math.floor(3*math.random())
    if star_random>currStageData[_level].star then
        currStageData[_level].star = star_random --随机给星
        print("xx==="..currStageData[1].star)
    end
    if currStageData[_level+1]  then  --如果后面的一关打过了则不做处理
        if currStageData[_level+1].state ~="dawanle" then
            currStageData[_level+1].state = "keyida"
    end
    end
    print("普通--第".._stage.."章".."第".._level.."关".."   "..currStageData[_level].state)

    --            print("第二关"..currStageData[2].state)

    levelBtnInit(_stage-1,"normal")

    --如果是最后一个小关，则解锁下一个章节

    last_index = _uiPanel:getChildByName("stage_pageview_nor"):getPage(_stage-1):getChildrenCount()-2

    print("普通--第".._stage.."章".."共有"..tostring(_pageview:getPage(_stage-1):getChildrenCount()-2).."关".."   ")

    if  _level==last_index and currStageData[last_index].state =="dawanle" then 
        if  Config._userData._uCurStage_normal[2][last_index].state =="dawanle" then
            print("还没有第"..tostring(_stage+1).."章")
        elseif _pageview:getChildrenCount()<_stage+1  then
            local xx = ccs.GUIReader:getInstance():widgetFromJsonFile("res/Stageselect_UI/stageselect_map"..tostring(_stage+1)..".json")
            _pageview:addPage(xx)
            print("第"..tostring(_stage+1).."章解锁")
            changeUserDataPTFB(_stage)
            ArrowChange("normal")  --改变箭头状态
            levelBtnInit(_stage,"normal")
        end
    end
    _pageview:setVisible(true)
    ui:setVisible(true)
    detailPanel:setVisible(false)
    --
    TaskDataUpdate(_level,"pt")
end

local function levelWinHandle_ace() --精英胜利操作
--    print("xx==".._stage)
    local ui = _uiPanel:getChildByName("stage_ui")
    local detailPanel = _uiPanel:getChildByName("stage_detail_panel")
    local currStageData = Config._userData._uCurStage_ace[_stage]

    local last_index = 0 --关卡数据table中，本章最后一关的id
    local _pageview = _uiPanel:getChildByName("stage_pageview_ace")
 
    currStageData[_level].state = "dawanle"

    local star_random = 1+math.floor(3*math.random())
    if star_random>currStageData[_level].star then
        currStageData[_level].star = star_random --随机给星
    end
    if currStageData[_level+1]  then  --如果后面的一关打过了则不做处理
        if currStageData[_level+1].state ~="dawanle" then
            currStageData[_level+1].state = "keyida"
    end
    end
    
    print("精英--第".._stage.."章".."第".._level.."关".."   "..currStageData[_level].state)

    --            print("第二关"..currStageData[2].state)

    levelBtnInit(_stage-1,"ace")

    --如果是最后一个小关，则解锁下一个章节
    
    local _btnList = _pageview:getPage(_stage-1):getChildren()
    for i=1,_uiPanel:getChildByName("stage_pageview_ace"):getPage(_stage-1):getChildrenCount(),1 do
    if  lua_string_split(_btnList[i]:getName(),"_")[4] =="a" then
       last_index = last_index + 1
       end
    end

    print("xx=="..Config._userData._uCurStage_ace[2][7].state)
  
    print("精英--第".._stage.."章".."共有"..tostring(_pageview:getPage(_stage-1):getChildrenCount()-2).."关".."   ")

    if  _level==last_index and currStageData[last_index].state =="dawanle" then 
        if  Config._userData._uCurStage_ace[2][7].state =="dawanle" then
            print("还没有第"..tostring(_stage+1).."章")
        elseif _pageview:getChildrenCount()<_stage+1  then
            local xx = ccs.GUIReader:getInstance():widgetFromJsonFile("res/Stageselect_UI/stageselect_map"..tostring(_stage+1)..".json")
            for i=1,xx:getChildrenCount(),1 do
               local _btn = xx:getChildren()[i]
                local str = lua_string_split(_btn:getName(),"_")
                if str[4]=="b" then
                    _btn:loadTextureDisabled("res/Stageselect_UI/stagecircle_elit.png")
                    _btn:setTouchEnabled(false)
                    _btn:setBright(false) 
                end
            end
            
            _pageview:addPage(xx)
            print("第"..tostring(_stage+1).."章解锁")
            changeUserDataYXFB(_stage)
            ArrowChange("ace")  --改变箭头状态
            levelBtnInit(_stage,"ace")
        end
    end
    _pageview:setVisible(true)
    ui:setVisible(true)
    detailPanel:setVisible(false)
    TaskDataUpdate(10+_level,"jy")
end

function showDetail(_menuUIinstance,uiPanel,stage,level,type) 
    menuUIinstance = _menuUIinstance
    print("showDetail======type ---- "..type)
    _uiPanel = uiPanel
    _stage = stage
    _level =level
    
    local pageView
    if type == "normal" then
        pageView = uiPanel:getChildByName("stage_pageview_nor")
    else
        pageView = uiPanel:getChildByName("stage_pageview_ace")
    end
    
    local ui = uiPanel:getChildByName("stage_ui")

    local detailPanel = uiPanel:getChildByName("stage_detail_panel")
--    pageView:setVisible(false)
    ui:setVisible(false)
    detailPanel:setVisible(true)

    local name = detailPanel:getChildByName("txtName")
    name:setString(stageData.name)

    local desc = detailPanel:getChildByName("txtDesc")
    desc:setString(stageData.desc)

    local body = detailPanel:getChildByName("txtBody")
    body:setString(stageData.body)

    local monster = stageData.monsterList

    for i,v in ipairs(monster) do

        local itemImage = cc.Sprite:create("res/guanka/"..v..".jpg")
        detailPanel:addChild(itemImage)
        local xNum = 170+(i-1)*100
        itemImage:setPosition(xNum,190)
        local itemImageWhite = cc.Sprite:create("res/guanka/equip_frame_white.png")
        itemImage:addChild(itemImageWhite)
        itemImageWhite:setPosition(itemImage:getContentSize().width/2,itemImage:getContentSize().height/2-1)

    end

    local item = stageData.itemList

    for i,v in ipairs(item) do
        local itemImage = cc.Sprite:create("res/guanka/"..v..".jpg")
        detailPanel:addChild(itemImage)
        local xNum = 170+(i-1)*100
        itemImage:setPosition(xNum,90)
        local itemImageWhite = cc.Sprite:create("res/guanka/equip_frame_white.png")
        itemImage:addChild(itemImageWhite)
        itemImageWhite:setPosition(itemImage:getContentSize().width/2,itemImage:getContentSize().height/2-1)

    end

    local start1 = detailPanel:getChildByName("start_1")
    local start2 = detailPanel:getChildByName("start_2")
    local start3 = detailPanel:getChildByName("start_3")

    if stageData.starLevel==1 then 
        start1:setBright(true)
        start2:setBright(false)
        start3:setBright(false)
    elseif stageData.starLevel==2 then 
        start1:setBright(true)
        start2:setBright(true)
        start3:setBright(false)
    elseif stageData.starLevel==3 then 
        start1:setBright(true)
        start2:setBright(true)
        start3:setBright(true)
    else
        start1:setBright(false)
        start2:setBright(false)
        start3:setBright(false)
    end

    local function nextBtnHandle(sender,eventType)
       if eventType == ccui.TouchEventType.ended then
           if type == "normal" then
--                    levelWinHandle_normal()
--                    menuUIinstance:changeData()
--                    StageOutPut(_uiPanel,stage,level,type)
                local xx = ccs.GUIReader:getInstance():widgetFromJsonFile("res/Stageselect_UI/StageHeroUI.json")
                uiPanel:addChild(xx,11)
                Stagestart(xx)
            elseif type == "ace" then
--                       levelWinHandle_ace()
--                       menuUIinstance:changeData()
--                       StageOutPut(_uiPanel,stage,level,type)
            end
         --扣除体力 体力值，type 1加 2减          
       end
    end


    local nextBtn = detailPanel:getChildByName("nextBtn")
    nextBtn:addTouchEventListener(nextBtnHandle)

end


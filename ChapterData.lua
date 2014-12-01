
local CheckpointInstance = nil
function CheckpointCreate()
     -- body
    CheckpointData = BaseData:new()
    CheckpointData.new = function(self) 
    
        local cpData = getmetatable(self).new(self)
       
            --//关卡属性
        cpData._cId = 0 -- 关卡Id
        cpData._cName = nil --关卡名称
        cpData._cDesc = nil --关卡描述
        cpData._cType = 0 --管卡类型，1大关2小关
        cpData._cMapId = 0 --关卡背景地图
        cpData._cUPP = 0 --关卡体力消耗
        cpData._cFightAuto = 0 -- 是否自动战斗 0 不自动  1自动
        cpData._cStar = 0 --战斗星级
            
            --//关卡物品，怪物列表
        cpData._cTeamList = {} -- 敌方阵容
            
        cpData._cDropItemList = {} --关卡可能掉落的物品
        cpData._cCheckPointList1 = {} -- 第一波怪物列表
        cpData._cCheckPointList2 = {} -- 第一波怪物列表
        cpData._cCheckPointList3 = {} -- 第一波怪物列表
            
            --/////  关卡产出
        cpData._cGold = 0 --关卡获得的金币
        cpData._cExp = 0 --关卡获得的经验
        cpData._cResultDrop = {} --掉落物品列表4
        return cpData
       end
       
    CheckpointData.initData = function(self,data) 
        if "table"==type(data) then
            for name, value in pairsByKeys(data) do
                self[""..name] = value

            end
        else

            cclog("type error in initData")
        end
    end

    CheckpointInstance = CheckpointData:new()
    return CheckpointInstance
end

local xxx = CheckpointCreate()
print("xxx===="..xxx._cId)


local ChapterInstance = nil
function ChapterCreate()
    ChapterData = BaseData:new()
    ChapterData.new = function(self) 
        local cpData = getmetatable(self).new(self)
        cpData._id = 1 -- Id
        cpData._name = nil --名称
        cpData._desc = nil --描述
        cpData._type = 0 --类型 1:普通，2精英 3团队
        cpData._mapId = 0 --背景地图
        cpData._state = 0 -- 0 未打开  1 正在进行中，2 已打完
        cpData._ckList = {} --管卡列表
        return cpData
    end
    
    ChapterData.initData = function(self,data) 
        if "table"==type(data) then
            for name, value in pairsByKeys(data) do
               
                if name == "_ckList" then
                    local currList= value
                    local ckList = {}
                    for i=1,table.maxn(currList),1 do
                        local checkpoint = CheckpointCreate()
                        checkpoint:initData(currList[i])
                        table.insert(ckList,checkpoint)
                    end
                    self[""..name] = ckList
                else
                    self[""..name] = value
                end

            end
        else

            cclog("type error in initData")
        end
    end

    ChapterInstance = ChapterData:new()
    return ChapterInstance
end


chapterData = {}



local function getChapterData()
    local dataXml = {
        {_id = 1,_name = "日光森林",_desc = "哈哈哈哈",_type= 1,_mapId = 1,_state = 0,_ckList = 
            { 
                {_cId = 1,_cName="暴风雪",_cDesc = "我闻到了鸡腿的味道。。",_cType = 1,_cMapId = 1,_cUPP = 12,_cFightAuto = 0,_cTeamList={1001,1002,1003,1004,10005},_cDropItemList = {1,2,3,4,5},
                    _cCheckPointList1 = {1001,1002,1003,1004,10005},_cCheckPointList2 = {1001,1002,1003,1004,10005},_cCheckPointList3 = {1001,1002,1003,1004,10005},_cGold=1280,_cExp = 12},
                {_cId = 2,_cName="暴风雪",_cDesc = "我闻到了鸡腿的味道。。",_cType = 1,_cMapId = 1,_cUPP = 12,_cFightAuto = 0,_cTeamList={1001,1002,1003,1004,10005},_cDropItemList = {1,2,3,4,5},
                    _cCheckPointList1 = {1001,1002,1003,1004,10005},_cCheckPointList2 = {1001,1002,1003,1004,10005},_cCheckPointList3 = {1001,1002,1003,1004,10005},_cGold=1280,_cExp = 12},
                {_cId = 3,_cName="暴风雪",_cDesc = "我闻到了鸡腿的味道。。",_cType = 1,_cMapId = 1,_cUPP = 12,_cFightAuto = 0,_cTeamList={1001,1002,1003,1004,10005},_cDropItemList = {1,2,3,4,5},
                    _cCheckPointList1 = {1001,1002,1003,1004,10005},_cCheckPointList2 = {1001,1002,1003,1004,10005},_cCheckPointList3 = {1001,1002,1003,1004,10005},_cGold=1280,_cExp = 12},
                {_cId = 4,_cName="暴风雪",_cDesc = "我闻到了鸡腿的味道。。",_cType = 1,_cMapId = 1,_cUPP = 12,_cFightAuto = 0,_cTeamList={1001,1002,1003,1004,10005},_cDropItemList = {1,2,3,4,5},
                    _cCheckPointList1 = {1001,1002,1003,1004,10005},_cCheckPointList2 = {1001,1002,1003,1004,10005},_cCheckPointList3 = {1001,1002,1003,1004,10005},_cGold=1280,_cExp = 12},
                {_cId = 5,_cName="暴风雪",_cDesc = "我闻到了鸡腿的味道。。",_cType = 1,_cMapId = 1,_cUPP = 12,_cFightAuto = 0,_cTeamList={1001,1002,1003,1004,10005},_cDropItemList = {1,2,3,4,5},
                    _cCheckPointList1 = {1001,1002,1003,1004,10005},_cCheckPointList2 = {1001,1002,1003,1004,10005},_cCheckPointList3 = {1001,1002,1003,1004,10005},_cGold=1280,_cExp = 12},
                {_cId = 6,_cName="暴风雪",_cDesc = "我闻到了鸡腿的味道。。",_cType = 1,_cMapId = 1,_cUPP = 12,_cFightAuto = 0,_cTeamList={1001,1002,1003,1004,10005},_cDropItemList = {1,2,3,4,5},
                    _cCheckPointList1 = {1001,1002,1003,1004,10005},_cCheckPointList2 = {1001,1002,1003,1004,10005},_cCheckPointList3 = {1001,1002,1003,1004,10005},_cGold=1280,_cExp = 12},
                {_cId = 7,_cName="暴风雪",_cDesc = "我闻到了鸡腿的味道。。",_cType = 1,_cMapId = 1,_cUPP = 12,_cFightAuto = 0,_cTeamList={1001,1002,1003,1004,10005},_cDropItemList = {1,2,3,4,5},
                    _cCheckPointList1 = {1001,1002,1003,1004,10005},_cCheckPointList2 = {1001,1002,1003,1004,10005},_cCheckPointList3 = {1001,1002,1003,1004,10005},_cGold=1280,_cExp = 12},
                {_cId = 8,_cName="暴风雪",_cDesc = "我闻到了鸡腿的味道。。",_cType = 1,_cMapId = 1,_cUPP = 12,_cFightAuto = 0,_cTeamList={1001,1002,1003,1004,10005},_cDropItemList = {1,2,3,4,5},
                    _cCheckPointList1 = {1001,1002,1003,1004,10005},_cCheckPointList2 = {1001,1002,1003,1004,10005},_cCheckPointList3 = {1001,1002,1003,1004,10005},_cGold=1280,_cExp = 12},
                {_cId = 9,_cName="暴风雪",_cDesc = "我闻到了鸡腿的味道。。",_cType = 1,_cMapId = 1,_cUPP = 12,_cFightAuto = 0,_cTeamList={1001,1002,1003,1004,10005},_cDropItemList = {1,2,3,4,5},
                    _cCheckPointList1 = {1001,1002,1003,1004,10005},_cCheckPointList2 = {1001,1002,1003,1004,10005},_cCheckPointList3 = {1001,1002,1003,1004,10005},_cGold=1280,_cExp = 12},
                {_cId = 10,_cName="暴风雪",_cDesc = "我闻到了鸡腿的味道。。",_cType = 1,_cMapId = 1,_cUPP = 12,_cFightAuto = 0,_cTeamList={1001,1002,1003,1004,10005},_cDropItemList = {1,2,3,4,5},
                    _cCheckPointList1 = {1001,1002,1003,1004,10005},_cCheckPointList2 = {1001,1002,1003,1004,10005},_cCheckPointList3 = {1001,1002,1003,1004,10005},_cGold=1280,_cExp = 12},
                {_cId = 11,_cName="暴风雪",_cDesc = "我闻到了鸡腿的味道。。",_cType = 1,_cMapId = 1,_cUPP = 12,_cFightAuto = 0,_cTeamList={1001,1002,1003,1004,10005},_cDropItemList = {1,2,3,4,5},
                    _cCheckPointList1 = {1001,1002,1003,1004,10005},_cCheckPointList2 = {1001,1002,1003,1004,10005},_cCheckPointList3 = {1001,1002,1003,1004,10005},_cGold=1280,_cExp = 12},
                {_cId = 12,_cName="暴风雪",_cDesc = "我闻到了鸡腿的味道。。",_cType = 1,_cMapId = 1,_cUPP = 12,_cFightAuto = 0,_cTeamList={1001,1002,1003,1004,10005},_cDropItemList = {1,2,3,4,5},
                    _cCheckPointList1 = {1001,1002,1003,1004,10005},_cCheckPointList2 = {1001,1002,1003,1004,10005},_cCheckPointList3 = {1001,1002,1003,1004,10005},_cGold=1280,_cExp = 12},
                {_cId = 13,_cName="暴风雪",_cDesc = "我闻到了鸡腿的味道。。",_cType = 1,_cMapId = 1,_cUPP = 12,_cFightAuto = 0,_cTeamList={1001,1002,1003,1004,10005},_cDropItemList = {1,2,3,4,5},
                    _cCheckPointList1 = {1001,1002,1003,1004,10005},_cCheckPointList2 = {1001,1002,1003,1004,10005},_cCheckPointList3 = {1001,1002,1003,1004,10005},_cGold=1280,_cExp = 12},
                {_cId = 14,_cName="暴风雪",_cDesc = "我闻到了鸡腿的味道。。",_cType = 1,_cMapId = 1,_cUPP = 12,_cFightAuto = 0,_cTeamList={1001,1002,1003,1004,10005},_cDropItemList = {1,2,3,4,5},
                    _cCheckPointList1 = {1001,1002,1003,1004,10005},_cCheckPointList2 = {1001,1002,1003,1004,10005},_cCheckPointList3 = {1001,1002,1003,1004,10005},_cGold=1280,_cExp = 12},
                {_cId = 15,_cName="暴风雪",_cDesc = "我闻到了鸡腿的味道。。",_cType = 1,_cMapId = 1,_cUPP = 12,_cFightAuto = 0,_cTeamList={1001,1002,1003,1004,10005},_cDropItemList = {1,2,3,4,5},
                    _cCheckPointList1 = {1001,1002,1003,1004,10005},_cCheckPointList2 = {1001,1002,1003,1004,10005},_cCheckPointList3 = {1001,1002,1003,1004,10005},_cGold=1280,_cExp = 12},
                {_cId = 16,_cName="暴风雪",_cDesc = "我闻到了鸡腿的味道。。",_cType = 1,_cMapId = 1,_cUPP = 12,_cFightAuto = 0,_cTeamList={1001,1002,1003,1004,10005},_cDropItemList = {1,2,3,4,5},
                    _cCheckPointList1 = {1001,1002,1003,1004,10005},_cCheckPointList2 = {1001,1002,1003,1004,10005},_cCheckPointList3 = {1001,1002,1003,1004,10005},_cGold=1280,_cExp = 12},
                {_cId = 17,_cName="暴风雪",_cDesc = "我闻到了鸡腿的味道。。",_cType = 1,_cMapId = 1,_cUPP = 12,_cFightAuto = 0,_cTeamList={1001,1002,1003,1004,10005},_cDropItemList = {1,2,3,4,5},
                    _cCheckPointList1 = {1001,1002,1003,1004,10005},_cCheckPointList2 = {1001,1002,1003,1004,10005},_cCheckPointList3 = {1001,1002,1003,1004,10005},_cGold=1280,_cExp = 12},
                {_cId = 18,_cName="暴风雪",_cDesc = "我闻到了鸡腿的味道。。",_cType = 1,_cMapId = 1,_cUPP = 12,_cFightAuto = 0,_cTeamList={1001,1002,1003,1004,10005},_cDropItemList = {1,2,3,4,5},
                    _cCheckPointList1 = {1001,1002,1003,1004,10005},_cCheckPointList2 = {1001,1002,1003,1004,10005},_cCheckPointList3 = {1001,1002,1003,1004,10005},_cGold=1280,_cExp = 12}
            }
        }
    }
    
    local function initData()
        for i,v in ipairs(dataXml) do
            local chapter = ChapterCreate()
            chapter:initData(v)
            table.insert(chapterData,item)
            
        end
    end
    initData()
end

chapterTableData = {}
local function loadChapterData()
    local data=cc.FileUtils:getInstance():getStringFromFile("res/json/chapterData.json")
    local json = require "json"
    chapterTableData = json.decode(data)
    print("chapterTableData.lenght========"..table.maxn(chapterTableData))
end


function getCharpterDataById(id)
    if nil ~= chapterTableData then
        for i=1,table.maxn(chapterTableData),1 do
            local oneCharpter = chapterTableData[i]
            if oneCharpter["id"] == id then
                return oneCharpter
            end
        end
    else
        return nil
    end
end

loadChapterData()
getChapterData();
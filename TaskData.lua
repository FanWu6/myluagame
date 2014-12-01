local TaskDataInstance = nil
local function TaskDataCreate(...)
    TaskData = BaseData:new()
    TaskData.new = function(self) 
        local _task = getmetatable(self).new(self)
        _task._tId = 0 -- 任务ID
        _task._tName = nil -- 任务名称
        _task._tDesc = nil --任务描述
        _task._tIcon = nil --任务图标
        _task._tLevel = 0 --任务需求等级
        _task._tType = 0 --任务类型 1.关卡任务  2 
        _task._tNextId = 0 --任务后置ID
        _task._tStageId = 0 --任务副本ID
        _task._tCheckPointId = 0 --任务副本关卡ID
        _task._tStageNum = 0 --任务副本通关的次数
        _task._tHeroNum = 0 --英雄数量
        _task._tHeroTone = 0 --英雄品质
        _task._tUserLevel = 0 --团队等级
        --//奖励
        _task._tUserExp = 0 --团队经验
        _task._tJewel = 0   --钻石
        _task._tConsumeId = 0   --消耗品
        _task._tConsumeNum = 0   --消耗品
        _task._tSoulStoneId = 0  -- 灵魂石
        _task._tSoulStoneNum = 0 -- 灵魂石个数
        _task._tRaidsNum = 0  -- 扫荡卷
        _task._tPower = 0   -- 体力
        _task._tGold = 0 --金币
        _task._tBuildGold = 0 --公会货币
        
        
        --//动态字段
        _task._tCurrStageNum = 0 --当前任务副本通关的次数
        _task._tCurrState = 0 --当前任务完成情况
        return _task
     end
     
    TaskData.initData = function(self,data) 
        if "table"==type(data) then
            for name, value in pairsByKeys(data) do
                self[""..name] = value
            end
        else

            cclog("type error in initData")
        end
    end

    TaskDataInstance = TaskData:new()
    return TaskDataInstance
end




local DayTaskDataInstance = nil
local function DayTaskDataCreate(...)
    DayTaskData = BaseData:new()
    DayTaskData.new = function(self) 
        local _dayTask = getmetatable(self).new(self)
        _dayTask._tId = 0 -- 任务ID
        _dayTask._tName = nil -- 任务名称
        _dayTask._tDesc = nil --任务描述
        _dayTask._tTime = 0 --任务需求等级
        _dayTask._tIcon = nil --任务图标
--        _dayTask._tOldId = 0 --任务前置ID
        _dayTask._tStageId = 0 --任务副本ID
        _dayTask._tCheckPointId = 0 --任务副本关卡ID
        _dayTask._tStageNum = 0 --任务副本通关的次数
        _dayTask._tHeroNum = 0 --英雄数量
        _dayTask._tHeroTone = 0 --英雄品质
        _dayTask._tUserLevel = 0 --团队等级
        
        _dayTask._tArenaNum = 0 --竞技场次数
        _dayTask._tTavernNum = 0 --燃烧的远征
        _dayTask._tSkillNum = 0 --技能升级
        _dayTask._tEnchantingNum = 0 --附魔
        _dayTask._tGoldHandleNum = 0 --点金手
        _dayTask._tStrengthNum = 0 --强化
        _dayTask._tChestNum = 0 --宝箱
        _dayTask._tMonthCard = 0 --月卡
        
        --//动态字段。。
        _dayTask._tCurrStageNum = 0 --当前通关的副本次数
        _dayTask._tCurrArenaNum = 0 --竞技场次数
        _dayTask._tCurrTavernNum = 0 --燃烧的远征
        _dayTask._tCurrSkillNum = 0 --技能升级
        _dayTask._tCurrEnchantingNum = 0 --附魔
        _dayTask._tCurrGoldHandleNum = 0 --点金手
        _dayTask._tCurrStrengthNum = 0 --强化
        _dayTask._tCurrChestNum = 0 --宝箱
        _dayTask._tCurrMonthCard = 0 --月卡
        
        
        --//奖励
        _dayTask._tUserExp = 0 --团队经验
        _dayTask._tJewel = 0   --钻石
        _dayTask._tConsumeId = 0   --消耗品
        _dayTask._tConsumeNum = 0   --消耗品
        _dayTask._tSoulStoneId = 0  -- 灵魂石
        _dayTask._tSoulStoneNum = 0 -- 灵魂石个数
        _dayTask._tRaidsNum = 0  -- 扫荡卷
        _dayTask._tPower = 0   -- 体力
        _dayTask._tGold = 0 --金币
        _dayTask._tBuildGold = 0 --公会货币
        
        return _dayTask
    end
    
    DayTaskData.initData = function(self,data) 
        if "table"==type(data) then
            for name, value in pairsByKeys(data) do
                self[""..name] = value
            end
        else

            cclog("type error in initData")
        end
    end

    DayTaskDataInstance = DayTaskData:new()
    return DayTaskDataInstance
end



taskData = {}
dayTaskData = {}

UsertaskData = {}
UserdayTaskData = {}

local function getTaskData()
    local taskDataXml = {
        {_tId = 1,_tName = "强者的试炼1",_tDesc = "试炼1",_tIcon = "task_rmb_icon_",_tLevel = 1,_tType = "pt",_tNextId= 2,_tStageId= 1001,_tCheckPointId = 1,_tStageNum = 2,_tHeroNum = 5,_tHeroNum =1,
            _tUserLevel = 1,_tUserExp = 10,_tJewel = 10,_tConsumeId = 104,_tConsumeNum = 2,_tSoulStoneId = 103,_tSoulStoneNum = 2,_tRadidsNum = 5,_tPower = 10,_tGold = 1000,_tBuildGold = 20},
        {_tId = 2,_tName = "强者的试炼2",_tDesc = "试炼2",_tIcon = "task_rmb_icon_",_tLevel = 1,_tType = "pt",_tNextId= 3,_tStageId= 1002,_tCheckPointId = 1,_tStageNum = 2,_tHeroNum = 5,_tHeroNum =1,
         _tUserLevel = 1,_tUserExp = 10,_tJewel = 10,_tConsumeId = 104,_tConsumeNum = 2,_tSoulStoneId = 103,_tSoulStoneNum = 2,_tRadidsNum = 5,_tPower = 10,_tGold = 1000,_tBuildGold = 20},
         {_tId = 3,_tName = "强者的试炼3",_tDesc = "试炼3",_tIcon = "task_rmb_icon_",_tLevel = 1,_tType = "pt",_tNextId= nil,_tStageId= 1002,_tCheckPointId = 1,_tStageNum = 2,_tHeroNum = 5,_tHeroNum =1,
         _tUserLevel = 1,_tUserExp = 10,_tJewel = 10,_tConsumeId = 104,_tConsumeNum = 2,_tSoulStoneId = 103,_tSoulStoneNum = 2,_tRadidsNum = 5,_tPower = 10,_tGold = 1000,_tBuildGold = 20},
         
         {_tId = 11,_tName = "XX的试炼1",_tDesc = "XX1",_tIcon = "task_rmb_icon_",_tLevel = 1,_tType = "jy",_tNextId= 12,_tStageId= 1001,_tCheckPointId = 1,_tStageNum = 2,_tHeroNum = 5,_tHeroNum =1,
            _tUserLevel = 1,_tUserExp = 10,_tJewel = 10,_tConsumeId = 104,_tConsumeNum = 2,_tSoulStoneId = 103,_tSoulStoneNum = 2,_tRadidsNum = 5,_tPower = 10,_tGold = 1000,_tBuildGold = 20},
        {_tId = 12,_tName = "XX的试炼2",_tDesc = "XX2",_tIcon = "task_rmb_icon_",_tLevel = 1,_tType = "jy",_tNextId= 13,_tStageId= 1002,_tCheckPointId = 1,_tStageNum = 2,_tHeroNum = 5,_tHeroNum =1,
         _tUserLevel = 1,_tUserExp = 10,_tJewel = 10,_tConsumeId = 104,_tConsumeNum = 2,_tSoulStoneId = 103,_tSoulStoneNum = 2,_tRadidsNum = 5,_tPower = 10,_tGold = 1000,_tBuildGold = 20},
         {_tId = 13,_tName = "XX的试炼3",_tDesc = "XX3",_tIcon = "task_rmb_icon_",_tLevel = 1,_tType = "jy",_tNextId= nil,_tStageId= 1002,_tCheckPointId = 1,_tStageNum = 2,_tHeroNum = 5,_tHeroNum =1,
         _tUserLevel = 1,_tUserExp = 10,_tJewel = 10,_tConsumeId = 104,_tConsumeNum = 2,_tSoulStoneId = 103,_tSoulStoneNum = 2,_tRadidsNum = 5,_tPower = 10,_tGold = 1000,_tBuildGold = 20}
    }
    
    local dayTaskDataXml = {
        {_tId = 1,_tName= "hhhhhh1",_tDesc = "cccccc1",_tTime = 100,_tIcon = 8001,_tStageId = 1001,_tCheckPointId = 1,_tHeroNum = 5,_tHeroTone = 1,_tUserLevel = 1,
            _tArenaNum = 2,_tTavernNum = 1,_tSkillNum = 3,_tEnchantingNum = 1,_tGoldHandleNum = 1,_tStrengthNum = 1,_tChestNum = 5,_tMonthCard = 1,_tUserExp = 10,
            _tjewel = 10,_tConsumeId = 104,_tConsumeNum = 2,_tSoulStoneId = 103,_tSoulStoneNum = 2,_tRadidsNum = 5,_tPower = 10,_tGold = 1000,_tBuildGold = 20},
        {_tId = 2,_tName= "hhhhhh2",_tDesc = "cccccc2",_tTime = 100,_tIcon = 8001,_tStageId = 1001,_tCheckPointId = 1,_tHeroNum = 5,_tHeroTone = 1,_tUserLevel = 1,
            _tArenaNum = 2,_tTavernNum = 1,_tSkillNum = 3,_tEnchantingNum = 1,_tGoldHandleNum = 1,_tStrengthNum = 1,_tChestNum = 5,_tMonthCard = 1,_tUserExp = 10,
            _tjewel = 10,_tConsumeId = 104,_tConsumeNum = 2,_tSoulStoneId = 103,_tSoulStoneNum = 2,_tRadidsNum = 5,_tPower = 10,_tGold = 1000,_tBuildGold = 20}
    }
    
    local function  readTaskData()
        for i,v in ipairs(taskDataXml) do
            local task = TaskDataCreate()
            task:initData(v)
--            print("taskData===Name == "..task._tName)
            table.insert(taskData,task)
            if v._tId == 1 then
                table.insert(UsertaskData,1,task)
            end
            
            if v._tId == 11 then
                table.insert(UsertaskData,2,task)
            end

        end
    end
    
    local function readDayTaskData()
        for i,v in ipairs(dayTaskDataXml) do
            local task = DayTaskDataCreate()
            task:initData(v)
--            print("daytaskData===Name111 == "..task._tName)
            table.insert(dayTaskData,task)

        end
    end
    
    readTaskData()
    readDayTaskData()
end
getTaskData()

local function SortTaskDataByState()

    local function sortLevelByType(a,b) 
        if (a._tCurrState == b._tCurrState) then
            return a._tId < b._tId
            
--        elseif (a._tCurrState == b._tCurrState == false) then
--            return a._tId < b._tId
        else
            return a._tCurrState > b._tCurrState
--            if(a._tCurrState ~= b._tCurrState) then
--                return a
--            else
--                return b
--            end
        end
    end 
    
    table.sort(UsertaskData, sortLevelByType)
  
end


function TaskRemove(curid,nextid,type)
    
    for i,v in ipairs(UsertaskData) do
        if v._tId == curid then
            table.remove(UsertaskData,i)
        end
       end
     
     local sort
     if type == "pt" then
         sort= 1
         elseif type == "jy" then
         sort = 2
     end
     for i,v in ipairs(taskData) do
        if v._tId == nextid then
            table.insert(UsertaskData,sort,v)
        end
    end
    
    SortTaskDataByState()
end

function TaskDataUpdate(id,type)
    if type == "pt" then
        for i,v in ipairs(UsertaskData) do
            if v._tId == id then
                local currStageData = Config._userData._uCurStage_normal[1]
                if currStageData[id].state == "dawanle" then
                         v._tCurrState = 1
                    end
            end
        end
    end
    
    if type == "jy" then
        for i,v in ipairs(UsertaskData) do
            if v._tId == id then
                local currStageData = Config._userData._uCurStage_ace[1]
                if currStageData[id-10].state == "dawanle" then
                    v._tCurrState = 1
                end
            end
        end
    end
    SortTaskDataByState()
end



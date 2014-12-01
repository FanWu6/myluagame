
local skillDataInstance = nil

function SkillDataCreate(...)

    skillData = BaseData:new()
    skillData.new = function(self)
    
        local skill = getmetatable(self).new(self)
        skill._skillData = BaseData:new()
        
        skill._skillData.new = function(self)
            local s = getmetatable(self).new(self)
            
            s.id = 0                --id
            s.slvl = 0              --技能等级
            s.name = nil            --技能名称
            s.nameEn = nil          --技能英文名
            s.priority = 0          --优先级
            s.skillType = 0         --技能类型  1.英雄主动技能，2.英雄必杀技能，3.英雄被动技能，4.装备主动技能，5.装备被动技能
            s.useType = 0           --使用类型  1.概率触发，2.主动使用
            s.trigger = 0           --触发方式  1.收到物理伤害，2.受到魔法伤害，3.受到伤害，4.造成物理伤害，5.造成魔法伤害，6.造成伤害，7.受到普攻伤害，8.使用技能
            s.happenP = 0           --触发概率
            s.doingType = 0         --被动技能种类    1.伴随型，2.抢占型
            s.hitAttribute = 0      --伤害属性  1.物理伤害，2.魔法伤害
            s.hitType = 0           --伤害类型  1.单体伤害，2.群体伤害
            s.hitNum = 0            --伤害量
            s.cutLifeP = 0          --斩杀百分比
            s.cureType = 0          --治疗类型  1.单体治疗，2.群里治疗
            s.cureNum = 0           --治疗量
            s.skillDistance = 0     --技能释放距离    战斗格格子数
            s.targetType = 0        --技能释放目标    1.敌方，2.我方，3.自己，4.空地，5.所有
            s.playPointType = 0     --技能特效释放点   1.目标默认自己，2.自己世界坐标，3.目标身上，4.目标世界坐标
            s.rangeType = 0         --技能作用范围类型  1.圆形范围，2.矩形范围，3.锁链范围，4.全屏，5.单体，6.伤害范围以技能释放点为中心的圆
            s.skillTime = 0         --技能间隔
            s.findTargetType= 0     --目标搜索方式    0.不需要目标，1.血最少，2.距离最近，3.距离最远，4.智力最高，5.随机挑选，6.伤害造成者，7.寻找有debuff的，并且血最少      
            s.desA = nil            --普通描述（白字）
            s.desB = nil            --功能描述（带颜色）
            
            s.desValueData = {}     --存储 desB 字段中，## 包含的字段值 按照 desB中展示的顺序存储
            
            return s
        end
        return skill
    end
    
    skillData.initData = function(self,data) 
        if "table"==type(data) then
            for name, value in pairsByKeys(data) do
                self._skillData[""..name] = value
                
            end
        else
            cclog("type error in initData")
        end
    end

    SkillDataInstance = skillData:new()
    SkillDataInstance._skillData = SkillDataInstance._skillData:new()
    return SkillDataInstance

end

skillList = {} -- vip静态表
local function loadSkillByJson()
    local data=cc.FileUtils:getInstance():getStringFromFile("res/json/skillData.json")
    local json = require "json"
    local expData = json.decode(data)
    local num = 1
    for i,v in ipairs(expData) do
        local skill = SkillDataCreate()
        skill:initData(v)
        skill._skillData.slvl = math.random(1,10)
        --读buff表 存储基础值
        local descB = skill._skillData.desB
        if nil ~= descB then
            local index  =  string.find(descB,"2_")
            if nil ~= index then 
                local tempArr = lua_string_split(descB,"#")
                for i=1,table.maxn(tempArr),1 do 
                    local tempStr = tempArr[i]
                    local resultIndex = string.find(tempStr,"2_")
                    if nil ~= reusltIndex then
                        local resultArr = lua_string_split(tempStr,"_")
                        --到buff表中 查找  resultArr[2] 字符串的字段值  存储到 skill._skillData.desValueData表中
                        table.insert(skill._skillData.desValueData,num,num*10)
                        num = num + 1
                    end
                end
            end
        end
        table.insert(skillList,skill)
    end
end 

loadSkillByJson()

function getSkillById(id)
    local result = nil
    if nil ~= skillList then
        for i=1,table.maxn(skillList),1 do
            local skill = skillList[i]
            if nil ~= skill and skill._skillData.id == id then
                result = skill
            end
        end
    end
    return result
end
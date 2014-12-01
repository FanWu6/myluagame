

local vipDataInstance = nil

function VipDataCreate( ... )
    -- body
    VipData = BaseData:new()
    VipData.new = function(self) 
        local vip = getmetatable(self).new(self)
        vip._vipData = BaseData:new()

        vip._vipData.new = function(self) 
            local v = getmetatable(self).new(self)
            v.vipLv = 0     --等级
            v.vipLup  = 0   --钻石数
            v.vipSd = 0     --扫荡卷数量
            v.vipJjc = 0    --竞技场门票
            v.vipDj = 0     --点金手次数
            v.vipTl = 0     --体力购买次数
            v.vipCz = 0     --精英管卡次数
            v.vipSon = 0    --扫荡功能 打开为0 关闭为1
            v.vipKon = 0    --解锁购买技能功能 打开为0 关闭为1
            v.vipTon = 0    --立即充值竞技场CD功能 打开为0 关闭为1
            v.vipKkon = 0   --技能点上限提高至20点 打开为0 关闭为1
            v.vipDjon = 0   --永久召唤地精商人 打开为0 关闭为1
            v.vipRson = 0   --燃烧远征次数+1 打开为0 关闭为1
            v.vipHson = 0   --永久黑市商人 打开为0 关闭为1
            v.vipSmon = 0   --神秘魂匣功能 打开为0 关闭为1
            v.vipRqon = 0   --燃烧远征宝箱战利品提高50% （不包括龙鳞币） 打开为0 关闭为1

            return v
        end
        return vip
    end

    VipData.initData = function(self,data) 
        if "table"==type(data) then
            for name, value in pairsByKeys(data) do
                self._vipData[""..name] = value

            end
        else

            cclog("type error in initData")
        end
    end

    VipDataInstance = VipData:new()
    VipDataInstance._vipData = VipDataInstance._vipData:new()
    return VipDataInstance
end

vipList = {} -- vip静态表
local function loadVipByJson()
    local data=cc.FileUtils:getInstance():getStringFromFile("res/json/vip.json")
    local json = require "json"
    local expData = json.decode(data)
    local num = 1;
    for i,v in ipairs(expData) do
        local vip = VipDataCreate()
        vip.initData(v)
        table.insert(vipList,v)
    end
end 

loadVipByJson()

function getVipById(id)
    local result = nil
    if nil ~= vipList then
        for i=1,table.maxn(vipList),1 do
            local vip = vipList[i]
            if nil ~= vip and vip._vipData.vipLv == id then
               result = vip
            end
        end
    end
    return result
end
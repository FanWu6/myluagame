-------------------------------------
------liuyuchuun 20140811---------------
-------------------------------------
--
local ItemDataInstance = nil


function ItemDataCreate( ... )
    -- body
    ItemData = BaseData:new()
    ItemData.new = function(self) 
        local item = getmetatable(self).new(self)
        item._itemData = BaseData:new()

            item._itemData.new = function(self) 
            local it = getmetatable(self).new(self)
            it.iId = 0 -- Id
            it.iName = nil --名称
            it.iDesc = nil --描述
            it.iType = 0 --类型 1:装备2:卷轴:3灵魂石4:消耗品5:碎片
            it.iSmallType = 0 --小类型  碎片（0无类型，1装备，2卷轴）
            it.iSellPrice = 0 --出售价格
            it.iMcostPay = 0 -- 合成费用
            
            
            it.iBuyNum  = 1   --出售数量
            it.iBuyType  =  0 --购买货币类型 --itemkind
            it.iBuyPrice = 0 -- 购买价格  --itemsell
            it.iUseDesc = nil-- 使用描述
            it.iUseLevel = 0 --使用等级限制
            it.iGuildPrice = 0 --公会购买
            
            it.iIcon = nil --图标资源
            it.iAddNum = 0 --叠加数量
            it.iTone = 0 -- 物品品质 1:白2:绿3:蓝4:紫5:橙
            
            
            it.iNum = 0 --拥有的个数
            it.iheroNum = 0 --英雄装备数量
            it.iStarLevel = 0 --星级
            it.iComposeTargetId = 0 --合成目标
            it.iComposeTargetNum = 0 -- 合成目标数量
            it.iState = 0 --是否被卖光  --ispurchase
            
            it.advanExe = 0 --进阶提供经验值
            
            it.iComposeTargetStr = nil --合成目标材料的字符串 向上
            it.iComposeMaterialsStr = nil --合成当前物品所需要的材料  向下
            it.thingsFrom = nil --获取改道具的来源
            
            --装备属性
            it.id = nil
            it.name = nil
            it.level = nil --装备等级
            it.attrType1 = nil --属性1类型
            it.attr1 = nil --属性1数值
            it.attrType2 = nil --属性2类型
            it.attr2 = nil --属性2数值
            it.attrType3 = nil --属性3类型
            it.attr3 = nil --属性3数值
            it.attrType4 = nil --属性4类型
            it.attr4 = nil --属性4数值
            it.attrType5 = nil --属性5类型
            it.attr5 = nil --属性5数值
            it.equipSkill1 = nil --附带技能1
            it.equipSkill2 = nil --附带技能2

            return it
        end
        return item
    end

    ItemData.initData = function(self,data)  --将json的数据加到表中
        if "table"==type(data) then
            for name, value in pairsByKeys(data) do
                self._itemData[""..name] = value
            end
        else

            cclog("type error in initData")
        end
    end
    
    ItemDataInstance = ItemData:new()
    ItemDataInstance._itemData = ItemDataInstance._itemData:new()
    return ItemDataInstance
end
--服务器物品数据容器
--bagServerList={
--    {itemId = 140027,num = 20},{itemId = 140029,num = 9},{itemId = 140030,num = 2},
--    {itemId = 140031,num = 9},{itemId = 140032,num = 3},{itemId = 140073,num = 1},{itemId = 140054,num = 1},
--    
--    {itemId = 140036,num = 9},{itemId = 140015,num = 9},{itemId = 140008,num = 9},{itemId = 150016,num = 3},
--    {itemId = 170001,num = 5},{itemId = 170002,num = 9},{itemId = 170003,num = 1},
--    {itemId = 180001,num = 9},{itemId = 180002,num = 3},{itemId = 180003,num = 2},
--    {itemId = 180011,num = 9},{itemId = 180012,num = 3},{itemId = 180013,num = 2},
--    {itemId = 180021,num = 9},{itemId = 180031,num = 3},{itemId = 180041,num = 2}
--}
bagServerList={}
--物品静态全局全表
testItemData = {}
--背包/碎片数据INIT
bagItemData ={}
--服务器商城数据
shopServerList ={}
--商城数据
shopItemData ={}


local itemBasicData=cc.FileUtils:getInstance():getStringFromFile("res/json/itemData.json") --装备基本表（类型，价格，品质，图标，合成，名字，描述）
local itemattrData=cc.FileUtils:getInstance():getStringFromFile("res/json/itm_attrData.json") --装备基本表（类型，价格，品质，图标，合成，名字，描述）

local json = require "json"
local itemBasicxx = {} --道具基本表
local itemattrxx = {} --属性表
itemBasicxx= json.decode(itemBasicData)
itemattrxx = json.decode(itemattrData)

local function itemLoadJson()
    for i,v in ipairs(itemBasicxx) do
        local item = ItemDataCreate()
        item:initData(v)
        --
        --            print(v.iId)
        if v.iType ==1 then --如果类型是装备，添加属性
            for i1,v1 in ipairs(itemattrxx) do
                if v.iId == v1.id then
                    item:initData(v1)
                end
        end

        end
        --
        local testData = DeepCopy(item)
        --           testData._itemData.iNum = 1
        table.insert(testItemData,testData)

    end
end

function getItemData()    
--    local function loadJson()   --将json读出放到testItemData里面
--        for i,v in ipairs(itemBasicxx) do
--           local item = ItemDataCreate()
--           item:initData(v)
--           --
----            print(v.iId)
--                   if v.iType ==1 then --如果类型是装备，添加属性
--                for i1,v1 in ipairs(itemattrxx) do
--                            if v.iId == v1.id then
--                                item:initData(v1)
--                            end
--                       end
--                      
--                   end
--            --
--            local testData = DeepCopy(item)
--            --           testData._itemData.iNum = 1
--            table.insert(testItemData,testData)
--         
--       end
--    end
    
    local function initData()  --初始化本地的表，没连表时候测试用的
       bagItemData = {}
        for i,v in ipairs(testItemData) do
            local bagData = getTestDataById(v._itemData.iId) 
            table.insert(bagItemData,bagData)
        end
        --
        for i,v in ipairs(bagServerList) do
            local bagData = getBagDataById(v.itemId) 
--            print("[itemData(itemID==)]"..bagData._itemData.attrType1)
if bagData == nil then
                print("adsadasdasdasdas===="..v.itemId)
end
            bagData.iNum = v.num
        end
    end

    initData()
    print("获取结束")
end

function getShopData()
    print("测试getShopData====----======"..table.maxn(shopServerList))
    shopItemData = {}
    for i,v in ipairs(shopServerList) do
        print("ads"..v.itemId)
        local shopitem = getTestDataById(v.itemId) 
        shopitem._itemData.iBuyNum = v.num  --出售数量
        shopitem._itemData.iBuyType = v.itemkind --价格种类
        shopitem._itemData.iBuyPrice = v.itemsell --出售价格
        shopitem._itemData.iState = v.ispurchase  --是否已买
        table.insert(shopItemData,shopitem)
    end
end

function DeepCopy(object)  --深度拷贝
    local lookup_table = {}
    local function _copy(object)
        if type(object) ~= "table" then
            return object
        elseif lookup_table[object] then
            return lookup_table[object]
        end

        local new_table = {}
        lookup_table[object] = new_table
        for index, value in pairs(object) do
            new_table[_copy(index)] = _copy(value)
        end
        return setmetatable(new_table, getmetatable(object))
    end
    return _copy(object)
end

--修改背包数据
function changeBagDataByIdKey(id,key,value)
    local index = -1
    for i,v in ipairs(bagItemData) do
        --5为碎片，背包不展示
        if v._itemData.iId == id then
           index = i
            break
        end
    end
    bagItemData[index]._itemData[key] = value
end

--删除背包数据
function delBagDataById(id)
    local index = -1
    for i,v in ipairs(bagItemData) do
        --5为碎片，背包不展示
        if v._itemData.iId == id then
            index = i
            break;
        end
    end
    table.remove(bagItemData,index)
end


function getTestDataById(id)   --在所有道具中根据ID获取物品对象
    local result=nil
    for i,v in ipairs(testItemData) do
        --5为碎片，背包不展示
        if v._itemData.iId == id then
            result = v
            break;
        end
    end
    return result
end

function getBagNumById(id) --在背包中根据ID获取物品数量
    local result = 0
   for i,v in ipairs(bagItemData) do
        --5为碎片，背包不展示
        if v._itemData.iId == id then
            result = result + v._itemData.iNum
        end
    end
    return result
end

function getBagDataById(id)   --在背包中根据ID获取物品DATA
    local result=nil
    for i,v in ipairs(bagItemData) do
        --5为碎片，背包不展示
        if v._itemData.iId == id then
            result = v._itemData
            break;
        end
    end
    return result
end

function addDataToBag(id,num)  --在背包中插入数据
--    local testItem = getTestDataById(id)
    local bagItem = getBagDataById(id)
--    if nil == bagItem then -- 插入表
--        testItem._itemData.iNum = num
--        table.insert(bagItemData,testItem)
--    else  --修改数量
        changeBagDataByIdKey(id,"iNum",(bagItem.iNum+num))
--    end
end

function getShopDataById(id)  --在商店表中根据ID获取DATA
    local result=nil
    for i,v in ipairs(shopItemData) do
        --5为碎片，背包不展示
        if v._itemData.iId == id then
            result = v._itemData
            break;
        end
    end
    return result
end

function changeShopDataByKeyId(id,key,value) --改变商店数据
    local index = -1
    for i,v in ipairs(shopItemData) do
        --5为碎片，背包不展示
        if v._itemData.iId == id then
            index = i
            break;
        end
    end
    shopItemData[index]._itemData[key] = value
end

itemLoadJson()
getItemData() 


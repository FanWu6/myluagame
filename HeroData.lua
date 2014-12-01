-------------------------------------
------wangwei 20140715---------------
-------------------------------------


local HeroInstance = nil 


-------------flash动作名称-------------
FS = {"idle","cheer","beaten","atk_be","atk_af","crit_be","crit_af",
		"death","move","dizzy","skill01_be","skill01_af","skill02_be",
		"skill02_af","skill03_be","skill03_af","ult_be","ult_af","play","brith","break"}
F_STAND = 1
F_CHEER = 2
F_DAMAGED = 3
F_ATTACK1_be = 4
F_ATTACK1_af = 5
F_ATTACK2_be = 6
F_ATTACK2_af = 7
F_DEATH = 8
F_MOVE = 9
F_DIZZY = 10 --眩晕
F_SKILL1_be = 11 --小技能施法
F_SKILL1_af = 12
F_SKILL2_be = 13
F_SKILL2_af = 14
F_SKILL3_be = 15
F_SKILL3_af = 16
F_ULT_be = 17 --大技能
F_ULT_af = 18
F_PLAY = 19 --技能效果的释放
F_BRITH = 20 --特效诞生
F_BREAK = 21 --特效衰亡


-------------------------------------


--Hero
--[[
example:
	local testHero1
	testHero1 = HeroCreate()
    testHero1:setHeroId(111)
	cclog("testHero1 id = "..testHero1._heroData.roleId)
]]--
-------------------------------------
function HeroDataCreate()
	-- cclog("HeroCreate")

	Hero = BaseData:new()

	Hero.new = function(self) 
 		local o = getmetatable(self).new(self)

 		o._heroData = BaseData:new()
 		o._heroData.new = function(self) 

 			local o = getmetatable(self).new(self)

 			--初始化_heroData内数据
 			o.roleId = nil  --角色ID
 			o.headpic = nil --角色头像
			o.model = nil   --角色模型
			o.roleName = nil --角色名称
            o.style = nil    --角色类型  (1pow,2dex,3int)
			o.starlvl = 1    --角色星级
			o.isOpen  = false --角色是否开启
			o.gradation = "w"   --角色品阶  (w,g_1,g_2,b_1,b_2,p)
			o.soulID = 0         --灵魂石ID
			o.firstStar = 1      --初始星级
			
			o.rlvl = 1 --角色等级
			o.battlepower = 100 --角色战斗力
			o.rexp = 0 --角色经验
			o.soulstoNum = 0 --角色拥有灵魂石数
			o.graexp = 0     --角色当前进阶经验
			
			o.skilfra1 = nil --角色技能栏1
            o.skilfra2 = nil --角色技能栏2
            o.skilfra3 = nil --角色技能栏3
            o.skilfra4 = nil --角色技能栏4
            
            o.skill1 = nil --角色技能1
            o.skill2 = nil --角色技能2
            o.skill3 = nil --角色技能3
            o.skill4 = nil --角色技能4
            
            o.itemfra1 = nil --角色物品栏1
            o.itemfra2 = nil --角色物品栏2
            o.itemfra3 = nil --角色物品栏3
            o.itemfra4 = nil --角色物品栏4
            o.itemfra5 = nil --角色物品栏5
            o.itemfra6 = nil --角色物品栏6
            
            o.itemfralvl1 = 1 --角色物品栏1等级
            o.itemfralvl2 = 1 --角色物品栏2等级
            o.itemfralvl3 = 1 --角色物品栏3等级
            o.itemfralvl4 = 1 --角色物品栏4等级
            o.itemfralvl5 = 1 --角色物品栏5等级
            o.itemfralvl6 = 1 --角色物品栏6等级
            
			o.standSlot = nil--站位
			o.powGrow = nil  --力量成长
			o.agiGrow = nil  --敏捷成长
			o.intGrow  = nil --智力成长
            o.energy = 1000   --能量上限
			--白字属性
            o.power = 0    --力量
            o.agility = 0  --敏捷
            o.intellect = 0--智力
			o.hp = 0       --基础生命值 
			o.phyAtk = 0   --物理攻击力
			o.magAtk = 0   --魔法强度
			o.phyDef = 0   --物理护甲
			o.magDef = 0   --魔法抗性
			o.phyCri = 0   --物理暴击
			o.magCri = 0   --魔法暴击
			o.dodge = 0    --闪避
			o.lifeRege = 0 --生命回复
			o.lifeRatio = 0--生命回复系数
			o.energyRege = 0--能量回复
			o.energyRatio  = 0--能量系数k
			o.phyIgnore = 0--物理护甲穿透
			o.magIgnore = 0--魔法抗性穿透
			o.cureGrow = 0 --治疗效果提升
			o.getBlood = 0 --吸血等级
			
            --绿字属性
            o.gr_power = 0    --力量
            o.gr_agility = 0  --敏捷
            o.gr_intellect = 0--智力
            o.gr_hp = 0       --基础生命值 
            o.gr_phyAtk = 0   --物理攻击力
            o.gr_magAtk = 0   --魔法强度
            o.gr_phyDef = 0   --物理护甲
            o.gr_magDef = 0   --魔法抗性
            o.gr_phyCri = 0   --物理暴击
            o.gr_magCri = 0   --魔法暴击
            o.gr_dodge = 0    --闪避
            o.gr_lifeRege = 0 --生命回复
            o.gr_lifeRatio = 0--生命回复系数
            o.gr_energyRege = 0--能量回复
            o.gr_energyRatio  = 0--能量系数k
            o.gr_phyIgnore = 0--物理护甲穿透
            o.gr_magIgnore = 0--魔法抗性穿透
            o.gr_cureGrow = 0 --治疗效果提升
            o.gr_getBlood = 0 --吸血等级
            
            
			o.moveSpeed = nil--移动速度
			o.atkSpeed = nil --1:100%正常攻速
			o.skill1 = nil  --技能1
			o.skill2  = nil --技能2
			o.skill3  = nil --技能3
			o.skill4 = nil --技能4
			o.atkRange = nil --攻击范围
			o.atkTime = nil--攻击间隔
			o.befTime = nil--攻击前摇
			o.aftTime = nil--攻击后摇

			o.ultTime = nil--大招间隔
			o.befUlt = nil--大招前摇
			o.aftUlt = nil--大招后摇

			o.skillTime = nil--技能间隔
			o.befSkill = nil--技能前摇
			o.aftSkill = nil--技能后摇

			--buff位置的微调
			o.buffHeadOffsetX = 0
			o.buffHeadOffsetY = 0
			o.buffBodyOffsetX = 0
			o.buffBodyOffsetY = 0
			o.buffFootOffsetX = 0
			o.buffFootOffsetY = 0

			o.atkPer = nil--受击百分比

			o.projectile = nil--普通攻击的子弹

			o.atkSpAdd = 8 --一次普通攻击 可以增加的怒气百分比

			o.skillSpAdd = 15
			
			o.heroBtn = nil   --出站的按钮
			o.isBattled = false --是否出战

 			return o
		end
		o._heroModelData = BaseData:new()
 		o._heroModelData.new = function(self) 

 			local o = getmetatable(self).new(self)

 			--初始化_heroData内数据
 			o.roleId = nil
 			o.nameStr = nil
 			o.headPic = nil
 			o.ts = nil --说话声音
 			o.as1 = nil --共计动作1声音
 			o.as2 = nil
 			o.ss1 = nil --技能动作1声音
 			o.ss2 = nil
 			o.ss3 = nil
 			o.us = nil --大招声音
			o.ds = nil --死亡声音
			o.scale = nil
			o.actionScale = nil
			o.bones = {}
			o.APT = nil

 			return o
		end
		--战斗唯一识别id
		o._fight_only_id = 0

		--几号位 就是1到5号位 
		o._pos_no = 0

 		--进场位置 矩阵索引值
		o._init_x = 0 --列
		o._init_y = 0 --行
		--场上位置 矩阵索引值
		o._current_x = 0 --列
		o._current_y = 0 --行
		--创建的动画
		o._armature = nil
		--创建的血条状态
		o._hpStateShowBg = nil
		o._hpStateShowPtimer = nil
		o._hpStateShowPtimerProgress = nil
		--当前动画正在执行的动作
		o._curPlayName = 0
		--英雄方向
		o._orientation = 0--默认向右 -1表示向左
		--英雄出入场状态
		o._stateInOut = STATE_INOUT_HERO_NOTGOIN
		--英雄所属方阵
		o._selfMatrix = SELF_OWNER_NONE
		--英雄的ai方法
		o._aiFunc = NormalAi


		--当前攻击目标
		--[[
					_curTarget._d = 0 --横向距离单位是战斗格
					_curTarget._v = v --目标
					_curTarget._o = 0 --目标在自己的左边-1或者右边0
					_curTarget._l = 0 --y轴差值 两个英雄之间的高度差
		]]--
		o._curTarget = nil --当前目标
		--自己是否死亡
		o._isDeath = false
		--自己是否正在错位
		o._isAdjust = false --还没考虑眩晕和打断 true表示正在错位


		o._pauseFlag = false --人物暂停标记


		--当前正在执行第几个技能套路
		o._current_sc_no = 0

		--战斗 英雄头像 类
		o._headManager = BaseData:new()

		o._headManager.new = function(self) 

 			local o = getmetatable(self).new(self)
 			o.Hp = 100 --百分比
 			o.Sp = 0   --百分比
 			o.Sprite = nil --头像精灵
 			o.HpStateShowBg = nil
			o.HpStateShowPtimer = nil
			o.HpStateShowProgress = nil
			o.SpStateShowBg = nil
			o.SpStateShowPtimer = nil
			o.SpStateShowProgress = nil
			o.HeadHighLightAnim = nil --头像高亮动画

			o.ultClickFlag = false --当sp为100的时候 可以被设置成true 类似一个开关
 			return o
		end

 		return o
	end 



	Hero.initData = function(self,data) 

		if "table"==type(data) then
--			
--			-- for i,v in ipairs(data) do
--			-- 	self._heroData[i] = v
--			-- end
--
			for name, value in pairsByKeys(data) do
	   			self._heroData[""..name] = value
			end
--
--
--			--0927 add
--			local model = ModelData[self._heroData.model]
--
--			if "table"==type(model) then
--
--				for name, value in pairsByKeys(model) do
--		   			self._heroModelData[""..name] = value
--				end
--			end
--
--
--			--初始化技能cd
--			self._skillCDManager:init()
--			
--
		else

			cclog("type error in initData")
		end

	end 

	HeroInstance = Hero:new()
	HeroInstance._heroData = HeroInstance._heroData:new()
	HeroInstance._heroModelData = HeroInstance._heroModelData:new()

	HeroInstance._headManager = HeroInstance._headManager:new()



	return HeroInstance
end

--服务器英雄数据容器
heroServerList={
    {roleId = 10010,headpic = "TH_H.jpg",starlvl = 5,rlvl = 15,isOpen = true,itemfra1 = 140027,itemfra2 = 140029,itemfralvl1 = 11,itemfralvl2= 22},
    {roleId = 10100,headpic = "ES_H.jpg",starlvl = 4,rlvl = 20,isOpen = true,itemfra1 = 140027,itemfra2 = 140029,itemfralvl1 = 11,itemfralvl2= 22},
    {roleId = 11080,headpic = "Lich_H.jpg",starlvl = 3,rlvl = 10,isOpen = true,itemfra1 = 140027,itemfra2 = 140029,itemfralvl1 = 11,itemfralvl2= 22},
    {roleId = 12070,headpic = "DR_H.jpg",starlvl = 2,rlvl = 1,isOpen = true,itemfra1 = 140027,itemfra2 = 140029,itemfralvl1 = 11,itemfralvl2= 22},
    --
    {roleId = 10020,headpic = "CG_H.jpg",starlvl = 1,rlvl = 15,isOpen = true,itemfra1 = 140027,itemfra2 = 140029,itemfralvl1 = 11,itemfralvl2= 22},
    {roleId = 10030,headpic = "goblinjr_H.jpg",starlvl = 1,rlvl = 15,isOpen = true,itemfra1 = 140027,itemfra2 = 140029,itemfralvl1 = 11,itemfralvl2= 22},
    {roleId = 10040,headpic = "NAGA_H.jpg",starlvl = 1,rlvl = 15,isOpen = true,itemfra1 = 140027,itemfra2 = 140029,itemfralvl1 = 11,itemfralvl2= 22},
    {roleId = 10050,headpic = "TW_H.jpg",starlvl = 1,rlvl = 15,isOpen = true,itemfra1 = 140027,itemfra2 = 140029,itemfralvl1 = 11,itemfralvl2= 22},
    {roleId = 10060,headpic = "SNK_H.jpg",starlvl = 1,rlvl = 15,isOpen = true,itemfra1 = 140027,itemfra2 = 140029,itemfralvl1 = 11,itemfralvl2= 22},
    --
    {roleId = 10160,headpic = "OK_H.jpg",starlvl = 3,rlvl = 1,isOpen = false},
    {roleId = 11130,headpic = "Lina_H.jpg",starlvl = 3,rlvl = 1,isOpen = false}
    }
--英雄静态全局全表
testHeroData = {} 
--用户已开启英雄表
userOpeheroData = { }
--用户未开启英雄表
userLockheroData = { }
--装备框强化表
frameStrengthData = {}
--英雄经验升级表
heroExpData = {}


function getHeroData()
   userOpeheroData = {}
    userLockheroData = {}
    local function loadJson()   --将json读出放到testItemData里面
        local heroBasicData=cc.FileUtils:getInstance():getStringFromFile("res/json/heroBasicData.json") --
        local json = require "json"
        local heroBasicxx = {} --英雄基本表
        heroBasicxx= json.decode(heroBasicData)
        for i,v in ipairs(heroBasicxx) do
            local hero = HeroDataCreate()
            hero:initData(v)
            --

--            for i1,v1 in ipairs(heroServerList) do  --添加服务器英雄数据
--                if v.roleId == v1.roleId then
--                        item:initData(v1)
--                    end
--            end
--
--            end
            --
            local testData = DeepCopy(hero)
            table.insert(testHeroData,testData)
            --            print(testItemData[i]._itemData.attrType1)
            
            -- local bagData = DeepCopy(item)
            -- bagData._itemData.iNum = 1
            -- table.insert(bagItemData,bagData)
        end
    end
    local function initData()  --初始化本地的表，没连表时候测试用的
        for i,v in ipairs(heroServerList) do
                local heroData = getHeroDataById(v.roleId) 
                heroData:initData(v)
                if heroData._heroData.isOpen == true then
                         table.insert(userOpeheroData,heroData)
                         --检索已经装备的装备
                         for i=1,6,1 do
                            if heroData._heroData["itemfra"..i] ~=nil then
                                local itemData = getBagDataById(heroData._heroData["itemfra"..i])
                                itemData.iheroNum = itemData.iheroNum+1
                            end
                         end
                else 
                         table.insert(userLockheroData,heroData)
                end


            --            local item = ItemDataCreate()
            --            item:initData(v)
            --            local testData = DeepCopy(item)
            --            table.insert(testItemData,testData)
            --
            --            if i>20 then
            --                local shopData = DeepCopy(item)
            --                table.insert(shopItemData,shopData)
            --            else
            --                local bagData = DeepCopy(item)
            --                table.insert(bagItemData,bagData)
            --            end
        end
        
        
    end
    loadJson()
    initData()
end

--加载英雄经验表
function loadHeroExp()
    local data=cc.FileUtils:getInstance():getStringFromFile("res/json/heroExp.json")
    local json = require "json"
    heroExpData = json.decode(data)
end


function getHeroDataById(id)   --在英雄基本表中根据ID获取
    local result=nil
    for i,v in ipairs(testHeroData) do
        --5为碎片，背包不展示
        if v._heroData.roleId == id then
        --测试用
            v._heroData.skilfra1 = nil
            v._heroData.skilfra2 = v._heroData.skill2
            v._heroData.skilfra3 = v._heroData.skill3
            v._heroData.skilfra4 = nil
        --
            result = v
            break;
        end
    end
    return result
end

--修改指定英雄的经验
function changeHeroExp(heroObj,exp)
    if nil ~= heroObj then
        heroObj._heroData.rexp = heroObj._heroData.rexp + exp  
        while heroObj._heroData.rexp - heroExpData[heroObj._heroData.rlvl]["heroExp"] >=0 do
            heroObj._heroData.rexp = math.abs(heroExpData[heroObj._heroData.rlvl]["heroExp"] - heroObj._heroData.rexp)
            heroObj._heroData.rlvl = heroObj._heroData.rlvl + 1
        end
    end
end

--获取装备框强化表
function getFrameStrenghtData()
    local frameStrength=cc.FileUtils:getInstance():getStringFromFile("res/json/frameStrength.json")
    local json = require "json"
    frameStrengthData = json.decode(frameStrength)
end



getHeroData()
getFrameStrenghtData()
loadHeroExp()





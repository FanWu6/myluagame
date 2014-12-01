-------------------------------------
------wangwei 20140728---------------
-------------------------------------
--
require "src/ResourceManager"
require "src/BaseClass"
require "src/ToolsHelper"
require "src/UISceneManager"
require "src/ItemData"
require "src/VipData"
require "src/ChapterData"
require "src/TaskData"
require "src/md5"

require "src/chat/ChatTools"
--require "src/ChatNmail/MailTool"

require "src/login_lua/login_main"
require "src/stg_lua/Stageselect_main"
require "src/pkg_lua/Package_main.lua"
require "src/scene_lua/RechargeDiamond"
require "src/scene_lua/RechargeGold"
require "src/userInfo/userInfo_main"
require "src/scene_lua/Scene_main"
require "src/scene_lua/jumpScene_UI"
require "src/fragment/fragment_main"
require "src/pkg_lua/package_detail"
require "src/shop/SceneShopTest"
require "src/mail/Mail_Scene"
require "src/versionUp/VersionUpData_Scene"
require "src/task_lua/task_main"

require "src/SkillData"
require "src/luasocketTest"

require "src/HeroUI/HeroUI_main"
require "src/HeroData"
--require "src/skillUI/Skill_main"
--require "src/skillUI/skill_detail"
--dialog
require "src/Dialog/Dialog_main"
require "src/Dialog/error"

require "Cocos2d"
require "Cocos2dConstants"
require "Opengl"
require "OpenglConstants"
require "StudioConstants"
require "GuiConstants"

local UserDataInstance = nil



MY_DATA =cc.UserDefault:getInstance()


-------------事件常量------------------

STATE_UPDATE_COMMAND = 0
SceneMainOffset = 0

cc.Director:getInstance():getOpenGLView():setDesignResolutionSize(1136, 640, cc.ResolutionPolicy.NO_BORDER)
local function UserDataCreate(...)
	-- body
	UserData = BaseData:new()

	UserData.new = function(self) 
 		local ud = getmetatable(self).new(self)
        ud._userData = BaseData:new()
        ud._userData.new = function(self) 

            local o = getmetatable(self).new(self)

 			o._uId = 10 --团队id
 			o._uName = nil --团队名称
 			o._uLevel = 0 -- 团队等级
 			o._uVipLevel = 0 -- 团队vip等级
 			o._uHeroList = {}  -- 团队英雄列表  
 			o._uHeroChipList = {} -- 团队英雄灵魂石碎片列表 name --key  num
 			o._uGold = 0 -- 团队金币数量
 			o._uJewel = 0 -- 团队钻石数量
 			o._uGlad = 0 -- 团队角斗士硬币数量
 			o._uLongLin = 0 -- 团队龙鳞币数量
 			o._uPP = 0 -- 团队体力
 			o._uPTFB = 0 -- 团队普通副本id
 			o._uYXFB = 0 -- 团队精英副本id
 			o._uGoldMake = 0 -- 团队剩余点金手次数
            o._uGoldMakesum = 0 -- 团队剩余点金手总次数
 			o._uMissionList = {} -- 团队当前任务列表
 			o._uPropList = {} -- 团队道具列表
 			o._uEvent1Num = 0 -- 剩余燃烧远征次数
 			o._uEvent1 = 0 -- 团队燃烧远征的进度
 			o._uEvent2Num = 0 -- 时光之穴次数
 			o._uEvent3Num = 0 -- 英雄试炼次数
 			o._uPVPNum = 0 -- 剩余竞技场次数
 			o._uPVPLevel = 0 -- 竞技场排名
 			o._uPVPVitnum = 0 -- 竞技场总胜利次数
 			o._uSign = 0 -- 签到当天天数
 			o._uExp = 0 -- 团队经验
 			o._uIcon = nil -- 团队头像icon
 			o._uGuild = 0 -- 团队公会id
 			--升级体力上限
 			o._uPhysical = 0 --团队体力上限
 			--关卡数据
 			o._uCurStage_normal = {} --当前普通章节
 			o._uCurStage_ace    = {} --当前精英章节
            o._uCurLevel_normal = 0 --当前普通关卡
            o._uCurLevel_ace    = 0 --当前精英关卡
            --功能
            o._uSop = false  --商店功能
            o._uAceState = false --时候解锁精英副本
            o._uHOM  = false  --迈达斯之手
            o._uCOT  = false --时光之穴  --(1,2,3,4,5,6)
            o._uChat = false --聊天功能 
            o._uTOH  = false --英雄试炼
            o._uTBC  = false --燃烧远征
            
 			return o
 		end
 		return ud
 	end
    UserData.initStageData = function(self)
--        self._userData._uCurStage_normal
          local _stage_1 = {}
          for i=1,18,1 do  --第一章普通
              if i==1 then 
              local _normal_table_test ={id=i,state="keyida",star=0,type="big",gold=1000,exp=10,itemList={140001}}
                table.insert(_stage_1,_normal_table_test)
            elseif i==2 then 
            local _normal_table_test ={id=i,state="bukeyi",star=0,type="small",gold=1000,exp=10,itemList={140001,140002}}
            table.insert(_stage_1,_normal_table_test)
            elseif i==3 then 
            local _normal_table_test ={id=i,state="bukeyi",star=0,type="small",gold=1000,exp=10,itemList={140001,140002,140003}}
                table.insert(_stage_1,_normal_table_test)
            elseif i==4 then 
            local _normal_table_test ={id=i,state="bukeyi",star=0,type="big",gold=1000,exp=10,itemList={140001}}
                table.insert(_stage_1,_normal_table_test)
             elseif i==5 then 
            local _normal_table_test ={id=i,state="bukeyi",star=0,type="small",gold=1000,exp=10,itemList={140001,140002}}
                table.insert(_stage_1,_normal_table_test)
        elseif i==6 then 
            local _normal_table_test ={id=i,state="bukeyi",star=0,type="small",gold=1000,exp=10,itemList={140001,140002,140003}}
            table.insert(_stage_1,_normal_table_test)
        elseif i==7 then 
            local _normal_table_test ={id=i,state="bukeyi",star=0,type="big",gold=1000,exp=10,itemList={140001}}
            table.insert(_stage_1,_normal_table_test)
        elseif i==8 then 
            local _normal_table_test ={id=i,state="bukeyi",star=0,type="small",gold=1000,exp=10,itemList={140001,140002}}
            table.insert(_stage_1,_normal_table_test)
        elseif i==9 then 
            local _normal_table_test ={id=i,state="bukeyi",star=0,type="small",gold=1000,exp=10,itemList={140001,140002,140003}}
            table.insert(_stage_1,_normal_table_test)
        elseif i==10 then 
            local _normal_table_test ={id=i,state="bukeyi",star=0,type="small",gold=1000,exp=10,itemList={140001}}
            table.insert(_stage_1,_normal_table_test)
        elseif i==11 then 
            local _normal_table_test ={id=i,state="bukeyi",star=0,type="big",gold=1000,exp=10,itemList={140001,140002}}
            table.insert(_stage_1,_normal_table_test)
        elseif i==12 then 
            local _normal_table_test ={id=i,state="bukeyi",star=0,type="small",gold=1000,exp=10,itemList={140001,140002,140003}}
            table.insert(_stage_1,_normal_table_test)
        elseif i==13 then 
            local _normal_table_test ={id=i,state="bukeyi",star=0,type="small",gold=1000,exp=10,itemList={140001}}
            table.insert(_stage_1,_normal_table_test)
        elseif i==14 then 
            local _normal_table_test ={id=i,state="bukeyi",star=0,type="small",gold=1000,exp=10,itemList={140001,140002}}
            table.insert(_stage_1,_normal_table_test)
        elseif i==15 then 
            local _normal_table_test ={id=i,state="bukeyi",star=0,type="big",gold=1000,exp=10,itemList={140001,140002,140003}}
            table.insert(_stage_1,_normal_table_test)
        elseif i==16 then 
            local _normal_table_test ={id=i,state="bukeyi",star=0,type="small",gold=1000,exp=10,itemList={140001}}
            table.insert(_stage_1,_normal_table_test)
        elseif i==17 then 
            local _normal_table_test ={id=i,state="bukeyi",star=0,type="small",gold=1000,exp=10,itemList={140001,140002}}
            table.insert(_stage_1,_normal_table_test)
        elseif i==18 then 
            local _normal_table_test ={id=i,state="bukeyi",star=0,type="big",gold=1000,exp=10,itemList={140001,140002,140003}}
            table.insert(_stage_1,_normal_table_test)
              end
          end
        table.insert(self._userData._uCurStage_normal,_stage_1)
         --、、、、、、、、、、 
         local _stage_2 = {}
        for i=1,21,1 do  --第2章普通
            if i==1 then 
                local _normal_table_test ={id=i,state="keyida",star=0,type="small",gold=1000,exp=10,itemList={140001}}
                table.insert(_stage_2,_normal_table_test)
        elseif i==2 then 
            local _normal_table_test ={id=i,state="bukeyi",star=0,type="big",gold=1000,exp=10,itemList={140001,140002}}
            table.insert(_stage_2,_normal_table_test)
        elseif i==3 then 
            local _normal_table_test ={id=i,state="bukeyi",star=0,type="small",gold=1000,exp=10,itemList={140001,140002,140003}}
            table.insert(_stage_2,_normal_table_test)
        elseif i==4 then 
            local _normal_table_test ={id=i,state="bukeyi",star=0,type="small",gold=1000,exp=10,itemList={140001}}
            table.insert(_stage_2,_normal_table_test)
        elseif i==5 then 
            local _normal_table_test ={id=i,state="bukeyi",star=0,type="big",gold=1000,exp=10,itemList={140001,140002}}
            table.insert(_stage_2,_normal_table_test)
        elseif i==6 then 
            local _normal_table_test ={id=i,state="bukeyi",star=0,type="small",gold=1000,exp=10,itemList={140001,140002,140003}}
            table.insert(_stage_2,_normal_table_test)
        elseif i==7 then 
            local _normal_table_test ={id=i,state="bukeyi",star=0,type="small",gold=1000,exp=10,itemList={140001}}
            table.insert(_stage_2,_normal_table_test)
        elseif i==8 then 
            local _normal_table_test ={id=i,state="bukeyi",star=0,type="small",gold=1000,exp=10,itemList={140001,140002}}
            table.insert(_stage_2,_normal_table_test)
        elseif i==9 then 
            local _normal_table_test ={id=i,state="bukeyi",star=0,type="big",gold=1000,exp=10,itemList={140001,140002,140003}}
            table.insert(_stage_2,_normal_table_test)
        elseif i==10 then 
            local _normal_table_test ={id=i,state="bukeyi",star=0,type="small",gold=1000,exp=10,itemList={140001}}
            table.insert(_stage_2,_normal_table_test)
        elseif i==11 then 
            local _normal_table_test ={id=i,state="bukeyi",star=0,type="small",gold=1000,exp=10,itemList={140001,140002}}
            table.insert(_stage_2,_normal_table_test)
        elseif i==12 then 
            local _normal_table_test ={id=i,state="bukeyi",star=0,type="big",gold=1000,exp=10,itemList={140001,140002,140003}}
            table.insert(_stage_2,_normal_table_test)
        elseif i==13 then 
            local _normal_table_test ={id=i,state="bukeyi",star=0,type="small",gold=1000,exp=10,itemList={140001}}
            table.insert(_stage_2,_normal_table_test)
        elseif i==14 then 
            local _normal_table_test ={id=i,state="bukeyi",star=0,type="small",gold=1000,exp=10,itemList={140001,140002}}
            table.insert(_stage_2,_normal_table_test)
        elseif i==15 then 
            local _normal_table_test ={id=i,state="bukeyi",star=0,type="big",gold=1000,exp=10,itemList={140001,140002,140003}}
            table.insert(_stage_2,_normal_table_test)
        elseif i==16 then 
            local _normal_table_test ={id=i,state="bukeyi",star=0,type="small",gold=1000,exp=10,itemList={140001}}
            table.insert(_stage_2,_normal_table_test)
        elseif i==17 then 
            local _normal_table_test ={id=i,state="bukeyi",star=0,type="small",gold=1000,exp=10,itemList={140001,140002}}
            table.insert(_stage_2,_normal_table_test)
        elseif i==18 then 
            local _normal_table_test ={id=i,state="bukeyi",star=0,type="big",gold=1000,exp=10,itemList={140001,140002,140003}}
            table.insert(_stage_2,_normal_table_test)
        elseif i==19 then 
            local _normal_table_test ={id=i,state="bukeyi",star=0,type="small",gold=1000,exp=10,itemList={140001}}
            table.insert(_stage_2,_normal_table_test)
        elseif i==20 then 
            local _normal_table_test ={id=i,state="bukeyi",star=0,type="small",gold=1000,exp=10,itemList={140001,140002}}
            table.insert(_stage_2,_normal_table_test)
        elseif i==21 then 
            local _normal_table_test ={id=i,state="bukeyi",star=0,type="big",gold=1000,exp=10,itemList={140001,140002,140003}}
            table.insert(_stage_2,_normal_table_test)
        end
        end
        table.insert(self._userData._uCurStage_normal,_stage_2)
        
        local _stage_ace_1={}
        --、、、、、////////
        for i=1,6,1 do  --第一章精英
            if i==1 then 
                local _ace_table_test ={id=i,state="keyida",star=3,type="big",gold=1000,exp=10,itemList={140005}}
                table.insert(_stage_ace_1,_ace_table_test)
        elseif i==2 then 
            local _ace_table_test ={id=i,state="bukeyi",star=0,type="big",gold=1000,exp=10,itemList={140006}}
            table.insert(_stage_ace_1,_ace_table_test)
        elseif i==3 then 
            local _ace_table_test ={id=i,state="bukeyi",star=0,type="big",gold=1000,exp=10,itemList={140007}}
            table.insert(_stage_ace_1,_ace_table_test)
        elseif i==4 then 
            local _ace_table_test ={id=i,state="bukeyi",star=0,type="big",gold=1000,exp=10,itemList={140005}}
            table.insert(_stage_ace_1,_ace_table_test)
        elseif i==5 then 
            local _ace_table_test ={id=i,state="bukeyi",star=0,type="big",gold=1000,exp=10,itemList={140006}}
            table.insert(_stage_ace_1,_ace_table_test)
        elseif i==6 then 
            local _ace_table_test ={id=i,state="bukeyi",star=0,type="big",gold=1000,exp=10,itemList={140007}}
            table.insert(_stage_ace_1,_ace_table_test)
       
        end
        end
        table.insert(self._userData._uCurStage_ace,_stage_ace_1)
        
        local _stage_ace_2 = {}
        --、、、、、、、、、、 
        for i=1,7,1 do  --第二章精英
            if i==1 then 
                local _ace_table_test ={id=i,state="keyida",star=3,type="big",gold=1000,exp=10,itemList={140005}}
                table.insert(_stage_ace_2,_ace_table_test)
        elseif i==2 then 
            local _ace_table_test ={id=i,state="bukeyi",star=0,type="big",gold=1000,exp=10,itemList={140006}}
            table.insert(_stage_ace_2,_ace_table_test)
        elseif i==3 then 
            local _ace_table_test ={id=i,state="bukeyi",star=0,type="big",gold=1000,exp=10,itemList={140007}}
            table.insert(_stage_ace_2,_ace_table_test)
        elseif i==4 then 
            local _ace_table_test ={id=i,state="bukeyi",star=0,type="big",gold=1000,exp=10,itemList={140005}}
            table.insert(_stage_ace_2,_ace_table_test)
        elseif i==5 then 
            local _ace_table_test ={id=i,state="bukeyi",star=0,type="big",gold=1000,exp=10,itemList={140006}}
            table.insert(_stage_ace_2,_ace_table_test)
        elseif i==6 then 
            local _ace_table_test ={id=i,state="bukeyi",star=0,type="big",gold=1000,exp=10,itemList={140007}}
            table.insert(_stage_ace_2,_ace_table_test)
        elseif i==7 then 
            local _ace_table_test ={id=i,state="bukeyi",star=0,type="big",gold=1000,exp=10,itemList={140008}}
            table.insert(_stage_ace_2,_ace_table_test)


        end
        end
        table.insert(self._userData._uCurStage_ace,_stage_ace_2)
        --、、、、、////////
    end
    
    UserData.saveData = function(self)
--        MY_DATA:setIntegerForKey("_uCurStage_normal",self._userData._uCurStage_normal)
--        MY_DATA:setIntegerForKey("_uCurStage_ace",self._userData._uCurStage_ace)
--        MY_DATA:setIntegerForKey("_uCurLevel_normal",self._userData._uCurLevel_normal)


   
--        MY_DATA:setIntegerForKey("_uCurLevel_ace",self._userData._uCurLevel_ace)
    end
    
    UserData.readData = function(self)
--        self._userData._uCurStage_normal=MY_DATA:getIntegerForKey("_uCurStage_normal",self._userData._uCurStage_normal)
--        self._userData._uCurStage_ace=MY_DATA:getIntegerForKey("_uCurStage_ace",self._userData._uCurStage_ace)
--        self._userData._uCurLevel_normal=MY_DATA:getIntegerForKey("_uCurLevel_normal",self._userData._uCurLevel_normal)
--        self._userData._uCurLevel_ace=MY_DATA:getIntegerForKey("_uCurLevel_ace",self._userData._uCurLevel_ace)
    end


 	UserData.initData = function(self,data) 

		if "table"==type(data) then

			for name, value in pairsByKeys(data) do
	   			self._userData[""..name] = value
			end
		else

			cclog("type error in initData")
		end

	end 

	UserDataInstance = UserData:new()

	UserDataInstance._userData = UserDataInstance._userData:new()

	return UserDataInstance
	

end

------测试团队数据------
local function getUserDataByXml()
    local _UserDataXmlList = {_uId = 1,_uName="精悍的金火玲",_uLevel = 1,_uVipLevel=1,_uHeroList={1,2,3,4,5,6,7,8,9,10},_uHeroChipList={{"shuangtoulong1",1},{"shuangtoulong2",2},{"shuangtoulong3",3},{"shuangtoulong4",4}},
            _uGold = 50,_uJewel = 5,_uLongLin = 10,_uPP = 5,_uPTFB=0,_uYXFB = 0,_uGoldMake = 5,_uMissionList={1,2,3,4,5,6,7,8,9,10},_uPropList={1,2,3,4,5,6,7,8,9,10},_uEvent1Num = 2,_uEvent1Num=5,
            _uEvent2Num = 2,_uEvent3Num = 2,_uPVPNum = 230,_uPVPVitnum = 2010,_uSign = 3,_uExp = 0,_uIcon = "SkeletonWarrior",_uGuild = 5,_uPhysical=91}
--
--        

    
--    for i,v in ipairs(_UserDataXmlList) do
            uu = UserDataCreate()
            uu:initData(_UserDataXmlList)
--        if i==1 then
            local myData = DeepCopy(uu)
            MyUserData = myData 
--        else
--            local black = DeepCopy(uu)
--            table.insert(userBlackList, black)
--            table.insert(userDatalist, uu)
--        end
--    end

    local function loadJson()
        local data=cc.FileUtils:getInstance():getStringFromFile("res/json/userExp.json")
        local json = require "json"
        local expData = json.decode(data)
        local num = 1;
        for i,v in ipairs(expData) do
            userExpDataList[i] = {}
            userExpDataList[i][1] = v["teamLv"]
            userExpDataList[i][2] = v["teamExp"]
        end
    end
    loadJson()
end

userDatalist = {} --团队列表
userExpDataList = {}
userBlackList = {}

--点金手数据表
userMidasFee = {_uGoldMake = 200,_uGoldMakesum=250,_Makediamond = 0,_Makediagold = 0} --1.剩余次数 2，总次数 3.需要钻石 4.可获得金币
userMidasUse = {_uGoldMake = 0,_Makediamond=0,_Makediagold=0,_uMakecrit = 0} --1.剩余次数 2.需要钻石 3.获得金币 4.暴击倍数

--根据id删除黑名单信息
function removeUserDataById(id)
    if nil ~= userBlackList then
        for i=1,table.maxn(userBlackList),1 do
            local ccc = userBlackList[i]
            if nil ~= ccc and ccc._userData._uId == id then
                table.remove(userBlackList,i)
            end
        end
    end
end

function getUserBlackListById(id)
    local result = nil
    if nil ~= userBlackList then
        for i=1,table.maxn(userBlackList),1 do
            local user = userBlackList[i]
            if user._userData._uId == id then
                result = user
            end
        end
    end
    return result
end

function getStageDataById(id,level,type)
    if type == "normal" then
       return  Config._userData._uCurStage_normal[id][level]
    elseif  type == "ace" then
        return Config._userData._uCurStage_ace[id][level]
    end
end

MyUserData = nil
--修改用户金币数量  金币  type 1加  2减
function changeUserDateGold(gold,type)
    print("当前用户金币==="..MyUserData._userData._uGold)
    if nil ~= MyUserData then
        if(type == 2) then
            if (MyUserData._userData._uGold - gold<0) then
            --金币不足
                local xx = DialogshowDialogPanel(13004)
                cc.Director:getInstance():getRunningScene():addChild(xx,100)
                return false
            else
                MyUserData._userData._uGold = MyUserData._userData._uGold - gold
                return true
            end
        else
            MyUserData._userData._uGold = MyUserData._userData._uGold + gold
        end
        print("修改数据后用户金币==="..MyUserData._userData._uGold)
    end
end



--修改昵称
function changeUserDataName(name)
    print("当前用户昵称==="..MyUserData._userData._uName)
    if nil ~= MyUserData then
        MyUserData._userData._uName = name
        print("修改数据后用户昵称==="..MyUserData._userData._uName)
    end

end

--退出公会
function changeUserGuild()
    print("当前公会id==="..MyUserData._userData._uGuild)
    if nil ~= MyUserData then
        MyUserData._userData._uGuild = 0
        print("修改数据后公会id==="..MyUserData._userData._uGuild)
    end

end

--修改用户钻石数量  钻石 type 1加  2减
function changeUserDataToken(token,type)
    print("当前用户钻石==="..MyUserData._userData._uJewel)
    if nil ~= MyUserData then
        if(type == 2) then
            if MyUserData._userData._uJewel - token < 0 then 
                local xx = DialogshowDialogPanel(13022)
                cc.Director:getInstance():getRunningScene():addChild(xx,101)
                 return false 
            else
--                MyUserData._userData._uJewel = MyUserData._userData._uJewel - token
                 return true
            end
        else 
--            MyUserData._userData._uJewel = MyUserData._userData._uJewel + token
            --购买钻石联网
        end
        print("修改数据后用户钻石==="..MyUserData._userData._uJewel)
    end
end

--修改用户体力 体力  type 1加  2减
function changeUserDataUPP(uPP,type)
    print("当前用户体力==="..MyUserData._userData._uPP)
    if nil ~= MyUserData then
        if(type == 2) then
            if MyUserData._userData._uPP - uPP < 0 then
                local xx = DialogshowDialogPanel(13007)
                cc.Director:getInstance():getRunningScene():addChild(xx,101)
                return false
            else
                MyUserData._userData._uPP = MyUserData._userData._uPP - uPP
                return true
            end

        else
            MyUserData._userData._uPP = MyUserData._userData._uPP + uPP
        end
        print("修改数据后用户体力==="..MyUserData._userData._uPP)
    end
end

-- 获取json表中的团队升级经验∂
function getUserExpByLv(lv)
    if nil ~= userExpDataList then
        return userExpDataList[lv][2]
    end
end

--修改用户的等级  升级
function changeUserDataLevel(level)
    if nil ~= MyUserData then
        MyUserData._userData._uLevel = level
        print("修改数据后用户等级==="..MyUserData._userData._uLevel)
    end
end

--修改用户经验 经验  type 1加  2减
function changeUserDataExp(exp,type)
    print("当前用户经验==="..MyUserData._userData._uExp.."   当前用户等级=="..MyUserData._userData._uLevel)
    if nil ~= MyUserData then
        if(type == 2) then
            MyUserData._userData._uExp = MyUserData._userData._uExp - exp
        else
            MyUserData._userData._uExp = MyUserData._userData._uExp + exp
            local tableExp = getUserExpByLv(MyUserData._userData._uLevel)
            if(MyUserData._userData._uExp >= tableExp) then 
                MyUserData._userData._uExp = MyUserData._userData._uExp - tableExp
                changeUserDataLevel(MyUserData._userData._uLevel+1)
            end
            
        end
        print("修改数据后用户经验==="..MyUserData._userData._uExp)
    end
end

----获取当前用户点金手次数
--function getGoldMakeNum()
--    if nil ~= MyUserData then
--        return MyUserData._userData._uGoldMake
--    end
--    return 0
--end
----修改用户点金手次数
--function changeGoldMakeNum()
--    print("当前用户点金手次数==="..MyUserData._userData._uGoldMake)
--    if nil ~= MyUserData then 
--        if MyUserData._userData._uGoldMake>=1 then 
--            MyUserData._userData._uGoldMake = MyUserData._userData._uGoldMake -1
--        else
--            MyUserData._userData._uGoldMake = 0
--        end
--        print("修改数据后用户点金手次数==="..MyUserData._userData._uGoldMake)
--    end
--end

function changeUserDataIcon(icon)
    print("当前用户头像图片资源==="..MyUserData._userData._uIcon)
    if nil ~= MyUserData then 
        MyUserData._userData._uIcon = icon
        print("修改数据后用户头像图片资源===="..MyUserData._userData._uIcon)
    end
end

function changeUserDataYXFB(currId)
    if nil ~= MyUserData then
        MyUserData._userData._uYXFB = currId
    end
end

function changeUserDataPTFB(currId)
    if nil ~= MyUserData then
        MyUserData._userData._uPTFB = currId
    end
end





getUserDataByXml()



---
Config = UserDataCreate()
Config:initStageData()
Config:readData()
--  stageSelectLogIn()   --副本
  
--   packageLogInMain()  --背包

--SceneMainLogIn()   --主界面

LandMainLogIn()  --登陆界面

--ShopLogInMain()  --商店

--skillLogInMain()  --技能

--HeroSceneLogIn() --英雄


--local SCREEN_WIDTH= 960
--local SCREEN_HEIGHT = (640*(960/1136))
--local SCLAE_MINI = 960/1136
--local glView = cc.Director:getInstance():getOpenGLView()
----local size = glView:getFrameSize()
--local size = cc.size(960,640)
--print("sizeWW=="..size.width.."sizeHH=="..size.height)
--local SCALE_MAX = math.max(size.width/SCREEN_WIDTH, size.height/SCREEN_HEIGHT)
--print("SCALE_MAX=="..SCALE_MAX)
--local SCALE_MIN = math.min(size.width/SCREEN_WIDTH, size.height/SCREEN_HEIGHT)
--print("SCALE_MIN=="..SCALE_MIN)
--local SCALE_MIDDLE = SCLAE_MINI*(SCALE_MAX + SCALE_MIN)/2
--print("SCALE_MIDDLE==="..SCALE_MIDDLE)





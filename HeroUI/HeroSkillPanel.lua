local ui_widget
local heroObj
local framID
local hro_skill_panel

--local cur_item --当前所要更花的物品对象
local cur_herolist--当前英雄列表
local cur_skill   --当前所操作的技能

--根据英雄等级，品阶，ID排序
local function sortLevelByType(a,b) 
    if (a._heroData.rlvl == b._heroData.rlvl) then
        if (a._heroData.gradation==b._heroData.gradation) then
            return a._heroData.roleId > b._heroData.roleId
        else 
            return a._heroData.gradation>b._heroData.gradation
        end
    else
        return a._heroData.rlvl > b._heroData.rlvl
    end
end 
--根据不同的页签获取不同的数据并排序
local function getDataByType(heroType,heroisOpen)
    local result = {}
    local ipairsObj
    if heroisOpen == true then
        ipairsObj = userOpeheroData
    else
        ipairsObj = userLockheroData
    end

    for i,v in ipairs(ipairsObj) do
        if heroType == "all" then
            table.insert(result,v)
        elseif heroType == "qianpai" and v._heroData.standSlot == 0 then
            table.insert(result,v)
        elseif heroType == "zhongpai" and v._heroData.standSlot == 1 then
            table.insert(result,v)
        elseif heroType == "houpai" and v._heroData.standSlot == 2 then
            table.insert(result,v)
        end
    end
    table.sort(result,sortLevelByType)
    return result
end


--查找当前技能被哪个英雄装备的英雄
local function getHeroBySkill(_skillID)
    local result
    for i,v in ipairs(cur_herolist)do
            for j=1,4,1 do
                    if v._heroData["skilfra"..j] == _skillID then
                        result = v
                        print("有人装备这个技能")
                        return result
                    else                                                            --如果找遍了还没找到说明该技能没有被装备
                            if i == table.maxn(cur_herolist) and j==4 then
                    print("没人装备这个技能")
                                result = nil
                               return result
                            end
                    end
            end
            
    end
end

--查找初始状态下拥有改技能的英雄
local function getHeroByOriginSkill(_skillID)
    local result
    for i,v in ipairs(cur_herolist)do
        for j=1,4,1 do
            if v._heroData["skill"..j] == _skillID then
                result = v
                print("有这个技能")
                return result
            else                                                            --如果找遍了还没找到说明该技能没有被装备
                if i == table.maxn(cur_herolist) and j==4 then
                    print("没这个技能")
                    result = nil
                    return result
            end
            end
        end

    end
end

local function skillInfoInit(_skillID)
    local hroskl_Info = ui_widget:getChildByName("hroSkl_Panel"):getChildByName("hroskl_infoPanel")
    --图标1
    local skl_fra1 = hroskl_Info:getChildByName("skl_fra1")
    skl_fra1:removeAllChildren()
    
    local result
    local changeSkillObj
    --killId 不为空，直接去查找技能表
    if _skillID ~= nil then
        result = getHeroByOriginSkill(_skillID)
        cur_skill = _skillID
        changeSkillObj = getSkillById(_skillID)
    else
        result = cur_herolist[1]
        cur_skill = cur_herolist[1]._heroData.skill1
    end
    --当前装备的技能图标
    if heroObj._heroData["skilfra"..framID] ~=nil then
        local skilframKillId = heroObj._heroData["skilfra"..framID]
        local xx = ccui.ImageView:create("res/jinengIcon/"..skilframKillId..".jpg")
        skl_fra1:addChild(xx)
        xx:setEnabled(false)
        xx:setScale(50/78)
        xx:setPosition(cc.p(skl_fra1:getContentSize().width/2,skl_fra1:getContentSize().height/2+2))
        --当前装备的技能名字
        local currSkillObj = getSkillById(skilframKillId)
        local skill_name1 = hroskl_Info:getChildByName("skl_name1")
        if nil ~= currSkillObj then
            skill_name1:setString(currSkillObj._skillData.name)
        else
            skill_name1:setString(skilframKillId)
        end
        skill_name1:setVisible(true)
    else
        local skill_name1 = hroskl_Info:getChildByName("skl_name1")
        skill_name1:setVisible(false)
    end
    
    
    --要更换的技能图标
    local skl_fra2 = hroskl_Info:getChildByName("skl_fra2")
    skl_fra2:removeAllChildren()
    --名字2
    local skl_name2 = hroskl_Info:getChildByName("skl_name2")
    local xx1
    --判断需要跟换得技能是否为空
    if changeSkillObj == nil then
        xx1 = ccui.ImageView:create("res/jinengIcon/"..result._heroData.skill1..".jpg")
        skl_name2:setString(result._heroData.skill1)
    else
        xx1 = ccui.ImageView:create("res/jinengIcon/"..changeSkillObj._skillData.id..".jpg")
        skl_name2:setString(changeSkillObj._skillData.name)
    end
    skl_fra2:addChild(xx1)
    xx1:setEnabled(false)
    xx1:setScale(94/78)
    xx1:setPosition(cc.p(skl_fra2:getContentSize().width/2,skl_fra2:getContentSize().height/2+2))
    skl_name2:setVisible(true)

    --当前装备这个技能的英雄
    local yzb_label = hroskl_Info:getChildByName("yzb_label")
    if _skillID == nil then                        
    local re = getHeroBySkill(cur_herolist[1]._heroData.skill1)                         --如果id为空，显示拥有第一行第一个技能的英雄名字，否则显示拥有当前所点击技能的英雄名
         if re == nil then
            yzb_label:setString("已装备:无")      
            print("1_1")                           --如果显示的技能没有人装备，则不显示英雄名
         else
            yzb_label:setString("已装备:"..re._heroData.roleName)
            print("1_2")
         end
    else
         local re = getHeroBySkill(_skillID)
         if re == nil then
             yzb_label:setString("已装备:无")
            print("2_1")
         else
             yzb_label:setString("已装备:"..re._heroData.roleName)
            print("2_2")
         end
    end

    --展示最下面的功能描述 desB
    local lineTextLable = hroskl_Info:getChildByName("lineTextLable")
    local descBListView = hroskl_Info:getChildByName("descBListView")
    descBListView:removeAllItems()
    --查找的技能是否为空 
    if nil ~= changeSkillObj then
        descBListView:setVisible(true)
        local descStrArr = changeSkillObj._skillData.desB
        --描述是否为空
        -- descB   对受到攻击的敌人造成#1_hitNum#点伤害@眩晕命中率随技能等级提升，对#slvl#级以下敌人必然命中
        -- @ 分割行数  #value#  #分割 获取字段名展示数值
        if changeSkillObj._skillData.desB~="null" and nil ~= descStrArr then
        
            local resultArr = lua_string_split(descStrArr,"@")
            
            --展示行数
            local valueNum = 1
            for i=1,table.maxn(resultArr),1 do
                --分隔字符当行
                local tempArr = lua_string_split(resultArr[i],"#")
                local resultStr = ""
                local targetValue
                for j=1,table.maxn(tempArr),1 do
                    local tempStr = tempArr[j]
                    local index =  string.find(tempStr,"_")
                    if nil ~= index then
                        --分隔字符串中得变量
                        local nameArr = lua_string_split(tempArr[j],"_")
                        
                        --根绝类型查表
                        if tonumber(nameArr[1]) == 1 then
                            targetValue = changeSkillObj._skillData[nameArr[2]]
                        else
                            targetValue = changeSkillObj._skillData.desValueData[valueNum]
                            valueNum = valueNum + 1
                        end
                        if nameArr[2] ~= "slvl" then
                            targetValue = tonumber(targetValue) + tonumber(targetValue)*changeSkillObj._skillData.slvl
                        end
                        resultStr = resultStr..targetValue
                    else
                        resultStr = resultStr..tempStr
                    end
                end

                --创建text
                local text = lineTextLable:clone()
                text:setString(resultStr)
                --换行
                local width = text:getVirtualRendererSize().width
                local height = text:getVirtualRendererSize().height
                text:setSize(cc.size(375,math.ceil(width/375)*(height+2)))
                text:ignoreContentAdaptWithSize(false)
                descBListView:pushBackCustomItem(text)
            end
        else --描述没有填写
            print("该技能表字段desB没有填写，ID=="..changeSkillObj._skillData.id)
        end

    else --查不到改技能
        descBListView:setVisible(false)
    end
end

local function ScrollInit()  --技能栏初始化
    local scrollview = ui_widget:getChildByName("hroSkl_Panel"):getChildByName("skill_listview")
    local skModel = ui_widget:getChildByName("hroSkl_Panel"):getChildByName("skillModel")
    scrollview:removeAllChildren()
    local currData = getDataByType("all",true)
    cur_herolist = currData
    --    local listnum = table.maxn(currData)
    local function _skillEvent(sender,eventType)
        local _button = sender
        if eventType == ccui.TouchEventType.began then
            _button:setScale(0.9) 
        elseif eventType == ccui.TouchEventType.moved then
            _button:setScale(1) 
        elseif eventType == ccui.TouchEventType.ended then --end操作
            _button:setScale(1) 
            --end操作
            skillInfoInit(sender:getTag())  --传入技能ID
            --
        elseif eventType == ccui.TouchEventType.canceled then
            _button:setScale(1) 
        end
    end  
    
    for i,v in ipairs(currData)do
        local skillModel = skModel:clone()  
        --1.头像
        local heroFrame = skillModel:getChildByName("heroFrame")
        local xx = ccui.ImageView:create("res/heroHeadpic/"..v._heroData.headpic)
        xx:setEnabled(false)
        heroFrame:addChild(xx)
        xx:setPosition(cc.p(heroFrame:getContentSize().width/2,heroFrame:getContentSize().height/2+2))
        xx:setScale(90/104)
        scrollview:pushBackCustomItem(skillModel)
        --2.技能
        for i=1,4,1 do
            local skillFrame = skillModel:getChildByName("skillbtn"..i)
            local xx = ccui.ImageView:create("res/jinengIcon/"..v._heroData["skill"..i]..".jpg")
            xx:setEnabled(false)
            skillFrame:addChild(xx)
            xx:setPosition(cc.p(skillFrame:getContentSize().width/2,skillFrame:getContentSize().height/2+2))
            xx:setScale(94/78)
            
                --如果有英雄装备了该技能，给个标记
                local re = getHeroBySkill(v._heroData["skill"..i])
                if re ~= nil then
                    local isOwned = ccui.ImageView:create("res/HeroSceneUI/star_yellow.png")
                     xx:addChild(isOwned)
                     isOwned:setPosition(cc.p(xx:getContentSize().width/2,0))
                end
            
            skillFrame:addTouchEventListener(_skillEvent)
            skillFrame:setTag(v._heroData["skill"..i])
        end
    end


  

end

local function buttonInit()
    --1.关闭
    local close_btn = ui_widget:getChildByName("hroSkl_Panel"):getChildByName("close_btn")
    local function _closeEvent(sender,eventType)
        local _button = sender
        --        cclog("tag====".. _button:getTag()) 
        if eventType == ccui.TouchEventType.began then

        elseif eventType == ccui.TouchEventType.moved then
        --移动按钮没有操作
        elseif eventType == ccui.TouchEventType.canceled then   

        elseif eventType == ccui.TouchEventType.ended then     --end之后的回调
            ui_widget:removeFromParent()
        end
    end  
    close_btn:addTouchEventListener(_closeEvent)
    --2.技能初始化
    ScrollInit()
    --3 更换按钮初始化
    local genghuan_btn = ui_widget:getChildByName("hroSkl_Panel"):getChildByName("hroskl_infoPanel"):getChildByName("genghuan_btn")
    local function _genghuanEvent(sender,eventType)
        local _button = sender
        --        cclog("tag====".. _button:getTag()) 
        if eventType == ccui.TouchEventType.began then

        elseif eventType == ccui.TouchEventType.moved then
        --移动按钮没有操作
        elseif eventType == ccui.TouchEventType.canceled then   

        elseif eventType == ccui.TouchEventType.ended then     --end之后的回调
            heroObj._heroData["skilfra"..framID]= cur_skill --改变技能栏的技能ID
            ui_widget:removeFromParent()
            HeroDetai_buttonInit() --重置英雄界面
            heroSklInfo(hro_skill_panel,heroObj,framID)
   print("更换")
        end
    end  
    genghuan_btn:addTouchEventListener(_genghuanEvent)
end

function HeroSkillPanel(_ui_widget,_hro_skill_panel,_heroObj,_framID)
    ui_widget = _ui_widget
    heroObj =_heroObj 
    framID = _framID 
    hro_skill_panel = _hro_skill_panel
    buttonInit()
    skillInfoInit()
end
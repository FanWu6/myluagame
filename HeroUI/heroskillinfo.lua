local ui_widget

function heroSklInfo(hro_skill_panel,_heroObj,framID)
    ui_widget = hro_skill_panel
    --3.技能名字以及图标
    local skillFrame = ui_widget:getChildByName("skillFrame")
    skillFrame:removeAllChildren()
    if _heroObj._heroData["skilfra"..framID] ~= nil then
--        local result = getTestDataById(_heroObj._heroData["skilfra"..framID])

        local xx = ccui.ImageView:create("res/jinengIcon/".._heroObj._heroData["skilfra"..framID]..".jpg")
        xx:setEnabled(false)
        skillFrame:addChild(xx)
        xx:setPosition(cc.p(skillFrame:getContentSize().width/2,skillFrame:getContentSize().height/2+2))
        xx:setScale(94/78)

        local skillName = ui_widget:getChildByName("skill_name")
        local skillId = _heroObj._heroData["skilfra"..framID]
        
        --获取技能对象数据
        local skillObj = getSkillById(skillId)
        skillName:setString(_heroObj._heroData["skilfra"..framID])
        --为空不展示
        if skillObj ~= nil then
            skillName:setString(skillObj._skillData.name)
        else
            skillName:setString(_heroObj._heroData["skilfra"..framID])
        end
        
        local lineTextLable = ui_widget:getChildByName("lineTextLable")
        local descBListView = ui_widget:getChildByName("descBListView")
        descBListView:removeAllItems()
        local descStrArr = skillObj._skillData.desB
        
        --描述是否为空
        -- descB   对受到攻击的敌人造成#1_hitNum#点伤害@眩晕命中率随技能等级提升，对#slvl#级以下敌人必然命中
        -- @ 分割行数  #value#  #分割 获取字段名展示数值
        if descStrArr ~= "null" and nil ~= descStrArr then
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
                            targetValue = skillObj._skillData[nameArr[2]]
                        else
                            targetValue = skillObj._skillData.desValueData[valueNum]
                            valueNum = valueNum + 1
                            
                        end
                        if nameArr[2] ~= "slvl" then
                            targetValue = tonumber(targetValue) + tonumber(targetValue)*skillObj._skillData.slvl
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
        else
        
        end
        
        
        
    end
    --4，更换技能
    local changeSkl_btn = hro_skill_panel:getChildByName("genghuan_btn")
    local function _skillEvent(sender,eventType)
        local _button = sender
        --        cclog("tag====".. _button:getTag()) 
        if eventType == ccui.TouchEventType.began then

        elseif eventType == ccui.TouchEventType.moved then
        --移动按钮没有操作
        elseif eventType == ccui.TouchEventType.canceled then   

        elseif eventType == ccui.TouchEventType.ended then     --end之后的回调
            local xx = ccs.GUIReader:getInstance():widgetFromJsonFile("res/HeroSceneUI/HeroSkill.json")
            cc.Director:getInstance():getRunningScene():addChild(xx,10)
            HeroSkillPanel(xx,hro_skill_panel,_heroObj,framID)
        end
    end  
    changeSkl_btn:addTouchEventListener(_skillEvent)
end


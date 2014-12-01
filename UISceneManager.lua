_uisceneStack = {}
local director = cc.Director:getInstance()
--UI场景入栈


function pushUIScene(_UIScene,_UISceneName)
    local function SceneMessage()
        for i,v in ipairs(_uisceneStack) do
            print("当前栈第 "..i.." 位 名字是".._uisceneStack[i])
        end
    end

    if _UISceneName == "Mainscene" then
        table.insert(_uisceneStack,_UISceneName)
        director:replaceScene(_UIScene)
        print("第一次进主界面...")
        SceneMessage()
        return
    end
    
    -- 如果栈中顶一样，则不做操作
    if _uisceneStack[table.maxn(_uisceneStack)] == _UISceneName then
            print("与栈定一样，则不作操作")
       return end
    
    
    for i,v in ipairs(_uisceneStack) do
        if v == _UISceneName then   
                      --如果栈中有此UI层，则跳到改UI层
           if i-1>0 then
                   director:popToSceneStackLevel(i-1)
                   director:pushScene(_UIScene)
                    print("栈中有此UI层，跳到改UI层...")
                    local max = table.maxn(_uisceneStack)
                        for j = i+1,max,1 do
                            table.remove(_uisceneStack,j)
                         end
                    SceneMessage()
            end
        return 
        elseif i == table.maxn(_uisceneStack) then --如果栈中无，则入栈
            table.insert(_uisceneStack,_UISceneName)
            director:pushScene(_UIScene)
            print("栈中无此UI层，pushUI层...")
            SceneMessage()
            return
        end
    end
end

function popUIScene()
    local max = table.maxn(_uisceneStack)
    if max >1 then
        director:popScene()
        print(_uisceneStack[max]..  "层出栈.......")
        table.remove(_uisceneStack,max)
    end
  
end
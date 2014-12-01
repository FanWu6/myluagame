

error={
        {id = 10000,name = "Success",desc = "操作成功",goToPanel=""},
        {id = 10001,name = "Connect_Fail",desc = "连接失败",goToPanel=""},
        {id = 10002,name = "Enter_Game",desc = "进入游戏失败",goToPanel=""},
        {id = 10003,name = "Duplicate_Nick_Name",desc = "昵称重复",goToPanel=""},
        {id = 10004,name = "Cant_Modify_Nick_Name",desc = "改昵称操作失败",goToPanel=""},
        {id = 10005,name = "Illegal_Char",desc = "非法字符",goToPanel=""},
        {id = 10006,name = "Illegal_NickName_Len",desc = "角色名超长",goToPanel=""},
        {id = 10007,name = "Unknow_Error",desc = "未知错误",goToPanel=""},
        {id = 13000,name = "Item_Not_Exist",desc = "物品不存在",goToPanel=""},
        {id = 13001,name = "Item_Not_Owner",desc = "物品不属于你所有",goToPanel=""},
        {id = 13002,name = "Item_Not_In_Bag",desc = "物品不在背包",goToPanel=""},
        {id = 13003,name = "Item_Invalid_Cell",desc = "物品背包格子不正确",goToPanel=""},
        {id = 13004,name = "Item_Gold_Need",desc = "金币不足",goToPanel="gold"},
        {id = 13005,name = "Item_Bag_UpLimit",desc = "背包数量已达上线",goToPanel=""},
        {id = 13006,name = "Item_Diamond_Need",desc = "钻石不足,是否充值?",goToPanel="diamond"},
    {id = 13007,name = "Item_Power_Need",desc = "确认花费50钻石购买120点体力，是否继续？（今日已购买0次）",goToPanel="power"}
    }
    
errorcodelist = {} --错误码

--错误码管理
local function errorcodeInit()
    local json = require "json"
    local errorData = cc.FileUtils:getInstance():getStringFromFile("res/json/errorcode.json")
    errorcodelist = json.decode(errorData)
end

function getErrorByResult(_result)
    local result=nil
    for i,v in ipairs(errorcodelist) do
        if tonumber(v.errorid) == _result then
            result = v
            break;
        end
    end
    return result
end


errorcodeInit()
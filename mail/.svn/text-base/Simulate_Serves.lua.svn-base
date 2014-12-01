

require "src/mail/Mail_Data"
require "src/mail/ResTable"


local Serves_Data_Title = "标题1,梅代夫斯基1,2014-11-02,false|标题2,梅代夫斯基2,2014-11-02,false|标题3,梅代夫斯基3,2014-11-02,false|标题4,梅代夫斯基4,2014-11-02,false|标题5,梅代夫斯基5,2014-11-02,false"
                        -- 邮件标题，发件人，发送日期，时候读取过

                        -- |
                        -- |
                        -- |
                    -- 转换后表如下
-- local From_Serve_Mail_Title_Table = {{Mail_Title = "标题1",Sand_Name = "梅代夫斯基1",Sand_Date = "2014-11-02",IsOpen = false},
-- 							{Mail_Title = "标题2",Sand_Name = "梅代夫斯基2",Sand_Date = "2014-11-02",IsOpen = false},
-- 							{Mail_Title = "标题3",Sand_Name = "梅代夫斯基3",Sand_Date = "2014-11-02",IsOpen = false},
-- 							{Mail_Title = "标题4",Sand_Name = "梅代夫斯基4",Sand_Date = "2014-11-02",IsOpen = false},
-- 							{Mail_Title = "标题5",Sand_Name = "梅代夫斯基5",Sand_Date = "2014-11-02",IsOpen = false}}


local Serves_Data_Info = "0,梅代夫斯基1,000|2,梅代夫斯基2,101/102|4,梅代夫斯基3,101/102/103/104|2,梅代夫斯基4,101/102|2,梅代夫斯基5梅代夫斯基5梅代夫斯基5梅代夫斯基5梅代夫斯基5梅代夫斯基5梅代夫斯基5梅代夫斯基5梅代夫斯基5梅代夫斯基5梅代夫斯基5梅代夫斯基5梅代夫斯基5梅代夫斯基5梅代夫斯基5梅代夫斯基5梅代夫斯基5梅代夫斯基5梅代夫斯基5梅代夫斯基5,101/102" 
                        --包含多少附件如果无附件填0，信件内容，附件ID如无附件请填000

                        -- |
                        -- |
                        -- |
                    -- 转换后表如下

-- local From_Serve_Mail_Info_Table = {{Sth_NO = 2,Mail_Info = "梅代夫斯基1",Sth_ID = {101,102},Sth_Res = {Sth_Name = {"物品名字","物品名字"},Res={"101.jpg","102.jpg"},Sth_Describe={"物品详细信息","物品详细信息"},Sth_HaveNum={99,99}}},
--                             {Sth_NO = 2,Mail_Info = "梅代夫斯基2",Sth_ID ={101,102},Sth_Res = {Sth_Name = {"物品名字","物品名字"},Res={"103.jpg","104.jpg"},Sth_Describe={"物品详细信息","物品详细信息"},Sth_HaveNum={99,99}}},
--                             {Sth_NO = 4,Mail_Info = "梅代夫斯基3",Sth_ID = {101,102,103,104},Sth_Res = {Sth_Name = {"物品名字","物品名字","物品名字","物品名字"},Res={"105.jpg","106.jpg","107.jpg","108.jpg"},Sth_Describe={"物品详细信息","物品详细信息","物品详细信息","物品详细信息"},Sth_HaveNum={99,99,99,99}}},
--                             {Sth_NO = 3,Mail_Info = "梅代夫斯基4",Sth_ID = {101,102,103},Sth_Res = {Sth_Name = {"物品名字","物品名字","物品名字"},Res={"107.jpg","106.jpg","107.jpg"},Sth_Describe={"物品详细信息","物品详细信息","物品详细信息"},Sth_HaveNum={99,99,99}}},
--                             {Sth_NO = 2,Mail_Info = "梅代夫斯基5梅代夫斯基5梅代夫斯基5梅代夫斯基5梅代夫斯基5梅代夫斯基5梅代夫斯基5梅代夫斯基5梅代夫斯基5梅代夫斯基5梅代夫斯基5梅代夫斯基5梅代夫斯基5梅代夫斯基5梅代夫斯基5梅代夫斯基5梅代夫斯基5梅代夫斯基5梅代夫斯基5梅代夫斯基5梅代夫斯基5梅代夫斯基5梅代夫斯基5梅代夫斯基5梅代夫斯基5梅代夫斯基5梅代夫斯基5梅代夫斯基5梅代夫斯基5梅代夫斯基5梅代夫斯基5梅代夫斯基5",Sth_Res = {Sth_ID = {101,102},Sth_Name = {"物品名字","物品名字"},Res={"109.jpg","110.jpg"},Sth_Describe={"物品详细信息","物品详细信息"},Sth_HaveNum={99,99}}}}

local From_Serve_Mail_Title_Table = {}

local From_Serve_Mail_Info_Table = {}


local function Get_Serves_Data_To_Table()
    
    local x = Split(Serves_Data_Title,"|")

    
    for i=1,table.getn(x) do
        
        local y =  Split(x[i],",")  

        local Bool 

        if y[4] == "false" then 
            Bool = false 
            elseif y[4] == "true" then 
                Bool = true  
        end  

        local z = {Mail_Title = y[1],Sand_Name = y[2],Sand_Date = y[3],IsOpen = Bool}
        cclog("table.getn(z)===11111111"..table.getn(z))
        table.insert(From_Serve_Mail_Title_Table, z)
    end

    -- cclog("cqcq====="..table.getn(tabletest))
    -- for i=1,table.getn(tabletest) do
    --     print(tabletest[i].Mail_Title)
    --     print(tabletest[i].Sand_Name)
    --     print(tabletest[i].Sand_Date)
    --     print(tabletest[i].IsOpen)

    --     cclog("xxxxxxx=="..type(tabletest[i].IsOpen))
    -- end

end 

local function Get_Serves_Data_To_Table2()
    

    local x = Split(Serves_Data_Info,"|")

    for i=1,table.getn(x) do

        local y =  Split(x[i],",")  
        -- print("cqcq"..y[3])
        local ID = Split(y[3],"/")  

       
        local _Sth_Name = {}
        local _Res = {}
        local _Sth_Describe = {}
        local _Sth_HaveNum = {}
        for n=1,table.getn(ID) do
            -- print("ididididid"..ID[n])
            -- print(type(tonumber(ID[n])))
            local name = Return_Res_NameForID(tonumber(ID[n]))

            table.insert(_Sth_Name,name)
            local res = Return_Res_ResForID(tonumber(ID[n]))

            table.insert(_Res,res)
            local describe = Return_Res_DescribeForID(tonumber(ID[n]))

            table.insert(_Sth_Describe,describe)
            local haveNum = Return_Res_HaveNumForID(tonumber(ID[n]))

            table.insert(_Sth_HaveNum,haveNum)

            

        end

        local S_Res = {Sth_Name = _Sth_Name,Res=_Res,Sth_Describe=_Sth_Describe,Sth_HaveNum=_Sth_HaveNum}

        local z = {Sth_NO = tonumber(y[1]),Mail_Info = y[2],Sth_Res = S_Res}

        table.insert(From_Serve_Mail_Info_Table, z)


    end

        -- for i=1,table.getn(tabletest) do
            
        --     print(tabletest[i].Sth_NO)
        --     print(tabletest[i].Mail_Info) 

        --     for j=1,tonumber(tabletest[i].Sth_NO) do
        --         print("Sth_Name=="..tabletest[i].Sth_Res.Sth_Name[j])
        --         print("Res=="..tabletest[i].Sth_Res.Res[j])
        --         print("Sth_Describe=="..tabletest[i].Sth_Res.Sth_Describe[j])
        --         print("Sth_HaveNum=="..tabletest[i].Sth_Res.Sth_HaveNum[j])

        --     end



        -- end

end 



function ServesDataForMail()

    Get_Serves_Data_To_Table()
    Get_Serves_Data_To_Table2()

    local MailData = {}

    for i=1,table.getn(From_Serve_Mail_Title_Table) do
        local m = MailCreate()
        m:init_MailEnvelope(From_Serve_Mail_Title_Table[i])
        m:init_MailContent(From_Serve_Mail_Info_Table[i])

        table.insert(MailData, m)
    end


------------------以下 数据结构读取测试------------------------
	-- for i=1,table.getn(DataTest) do
 --        print(DataTest[i]._MailEnvelope.Mail_Title)
 --        print(DataTest[i]._MailEnvelope.Sand_Name)
 --        print(DataTest[i]._MailEnvelope.Sand_Date)
 --        print(DataTest[i]._MailEnvelope.IsOpen)
 --        print(DataTest[i]._MailContent.Sth_NO)
 --        print(DataTest[i]._MailContent.Mail_Info)
 --        for j=1,DataTest[i]._MailContent.Sth_NO do
 --            print(DataTest[i]._MailContent.Sth_Res.Sth_ID[j])
 --            print(DataTest[i]._MailContent.Sth_Res.Res[j])
 --            print(DataTest[i]._MailContent.Sth_Res.Sth_Describe[j])
 --            print(DataTest[i]._MailContent.Sth_Res.Sth_HaveNum[j])
 --        end
 --    end






	return MailData

end


function ServesDataForMail_Info()

	return From_Serve_Mail_Info

end
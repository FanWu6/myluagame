--消息派发定义文件：auto create by roy.z at 2014-09-04



GCHandleList = {
--	--**************************************模块：登陆	模块编号:10	说明:登陆服务器验证等
--
    { isSupported = true,cmd = PACKET_CG_Connect,name ="登陆服务器" ,create_func = CGConnectCreate},
    { isSupported = true,cmd = PACKET_GC_Connect,name ="登陆回复", create_func = GCConnectCreate,call_back = nil},
    { isSupported = true,cmd = PACKET_CG_LoginGame,name ="登陆游戏", create_func = CGLoginGameCreate},
    { isSupported = true,cmd = PACKET_GC_LoginGame,name ="登陆游戏回复", create_func = GCLoginGameCreate,call_back = nil},
    { isSupported = true,cmd = PACKET_CG_HeartBeat,name ="心跳包", create_func = CGHeartBeatCreate},
    { isSupported = true,cmd = PACKET_GC_HeartBeat,name ="心跳包", create_func = GCHeartBeatCreate,call_back = nil},
    { isSupported = true,cmd = PACKET_CG_ModifyNickName,name ="申请修改昵称", create_func = CGModifyNickNameCreate},
    { isSupported = true,cmd = PACKET_GC_ModifyNickName,name ="回复修改昵称", create_func = GCModifyNickNameCreate,call_back = nil},
	--**************************************模块：聊天	模块编号:11	说明:

    { isSupported = true,cmd = PACKET_CG_Chat,name ="世界聊天", create_func = CGChatCreate},
    { isSupported = true,cmd = PACKET_GC_Chat,name ="聊天信息", create_func = GCChatCreate,call_back = nil},
	--**************************************模块：英雄	模块编号:12	说明:

    { isSupported = true,cmd = PACKET_CG_CallHero,name ="召唤英雄", create_func = CGCallHeroCreate},
    { isSupported = true,cmd = PACKET_GC_CallHero,name ="回复召唤英雄", create_func = GCCallHeroCreate,call_back = nil},
    { isSupported = true,cmd = PACKET_CG_HeroList,name ="申请英雄列表", create_func = CGHeroListCreate},
    { isSupported = true,cmd = PACKET_GC_HeroList,name ="回复英雄列表", create_func = GCHeroListCreate,call_back = nil},
	--**************************************模块：物品	模块编号:13	说明:物品，背包，装备等

    { isSupported = true,cmd = PACKET_CG_AddItem,name ="添加物品", create_func = CGAddItemCreate},
    { isSupported = true,cmd = PACKET_GC_AddItem,name ="回复添加物品结果", create_func = GCAddItemCreate,call_back = nil},
    { isSupported = true,cmd = PACKET_CG_PackBag,name ="整理背包", create_func = CGPackBagCreate},
    { isSupported = true,cmd = PACKET_GC_PackBag,name ="整理背包结果", create_func = GCPackBagCreate,call_back = nil},
    { isSupported = true,cmd = PACKET_CG_DragItem,name ="移动交换合并背包格子", create_func = CGDragItemCreate},
    { isSupported = true,cmd = PACKET_GC_DragItem,name ="回复移动交换合并背包", create_func = GCDragItemCreate,call_back = nil},
    { isSupported = true,cmd = PACKET_CG_DeleteItem,name ="删除物品", create_func = CGDeleteItemCreate},
    { isSupported = true,cmd = PACKET_GC_DeleteItem,name ="删除物品回复", create_func = GCDeleteItemCreate,call_back = nil},
    { isSupported = true,cmd = PACKET_CG_ExtendBag,name ="扩充背包", create_func = CGExtendBagCreate},
    { isSupported = true,cmd = PACKET_CG_ExtendBag,name ="扩充背包", create_func = GCExtendBagCreate,call_back = nil},
    { isSupported = true,cmd = PACKET_CG_BagList,name ="背包列表", create_func = CGBagListCreate},
    { isSupported = true,cmd = PACKET_GC_BagList,name ="回复背包列表", create_func = GCBagListCreate,call_back = nil},

    { isSupported = true,cmd = PACKET_CG_UseItem,name ="使用物品", create_func = CGUseItemCreate},
    { isSupported = true,cmd = PACKET_GC_UseItem,name ="回复使用物品", create_func = GCUseItemCreate,call_back = nil},
    --商店
    { isSupported = true,cmd = PACKET_CG_ShopBuyItem,name ="购买商品", create_func = CGShopBuyItemCreate},
    { isSupported = true,cmd = PACKET_GC_ShopBuyItem,name ="回复购买商品", create_func = GCShopBuyItemCreate,call_back = nil},
    { isSupported = true,cmd = PACKET_CG_ShopItemList,name ="商店物品列表", create_func = CGShopItemListCreate},
    { isSupported = true,cmd = PACKET_GC_ShopItemList,name ="回复商店物品列表", create_func = GCShopItemListCreate,call_back = nil},
    
     { isSupported = true,cmd = PACKET_CG_RefreshShop,name ="刷新商店", create_func = CGRefreshShopCreate},
    { isSupported = true,cmd = PACKET_GC_RefreshShop,name ="回复刷新商店", create_func = GCRefreshShopCreate,call_back = nil},
    { isSupported = true,cmd = PACKET_CG_RefreshShopFee,name ="刷新商店费用", create_func = CGRefreshShopFeeCreate},
    { isSupported = true,cmd = PACKET_GC_RefreshShopFee,name ="回复刷新商店费用", create_func = GCRefreshShopFeeCreate,call_back = nil},
    --购买体力
    { isSupported = true,cmd = PACKET_CG_BuyPhysicalFee,name ="购买体力费用", create_func = CGBuyPhysicalFeeCreate},
    { isSupported = true,cmd = PACKET_GC_BuyPhysicalFee,name ="购买体力费用回复", create_func = GCBuyPhysicalFeeCreate,call_back = nil},
    { isSupported = true,cmd = PACKET_CG_BuyPhysical,name ="购买体力", create_func = CGBuyPhysicalCreate},
    { isSupported = true,cmd = PACKET_GC_BuyPhysical,name ="购买体力回复", create_func = GCBuyPhysicalCreate,call_back = nil},
    --钻石充值
    { isSupported = true,cmd = PACKET_CG_DiamondRecharge,name ="购买体力", create_func = CGDiamondRechargeCreate},
    { isSupported = true,cmd = PACKET_GC_DiamondRecharge,name ="购买体力回复", create_func = GCDiamondRechargeCreate,call_back = nil},
    --玩家信息
    { isSupported = true,cmd = PACKET_CG_PlayerInfo,name ="玩家信息", create_func = CGPlayerInfoCreate},
    { isSupported = true,cmd = PACKET_GC_PlayerInfo,name ="玩家信息回复", create_func = GCPlayerInfoCreate,call_back = nil},
    --出售物品
    { isSupported = true,cmd = PACKET_CG_SaleItem,name ="出售物品", create_func = CGSaleItemCreate},
    { isSupported = true,cmd = PACKET_GC_SaleItem,name ="出售物品回复", create_func = GCSaleItemCreate,call_back = nil},
    --点金手
    { isSupported = true,cmd = PACKET_CG_MidasTouchFee,name ="点金手费用", create_func = CGMidasTouchFeeCreate},
    { isSupported = true,cmd = PACKET_GC_MidasTouchFee,name ="点金手费用回复", create_func = GCMidasTouchFeeCreate,call_back = nil},
    { isSupported = true,cmd = PACKET_CG_MidasTouchUse,name ="点金手", create_func = CGMidasTouchUseCreate},
    { isSupported = true,cmd = PACKET_GC_MidasTouchUse,name ="点金手回复", create_func = GCMidasTouchUseCreate,call_back = nil}
}



function CHECK_Handle( _CMD )
    for i,v in ipairs(GCHandleList) do
        if v.cmd == _CMD then
			return v.create_func()
--			end
		end
	end
end

function SET_CallBack( _CMD ,_fun)
    for i,v in ipairs(GCHandleList) do
        if v.cmd == _CMD then
            v.call_back = _fun
        end
    end
end

function FIND_CallBack( _CMD ,_data)
    for i,v in ipairs(GCHandleList) do
        if v.cmd == _CMD then
            if v.call_back~=nil then
                v.call_back(_data)
            end
        end
    end
end


local function connectWaitScene(isdelete)

    if cc.Director:getInstance():getRunningScene():getChildByTag(-100) == nil then
        local xx = ccs.GUIReader:getInstance():widgetFromJsonFile("res/WaitSceneUI/WaitSceneUI_1.json")
        cc.Director:getInstance():getRunningScene():addChild(xx,1000,-100)
        print("创建等待界面。。。。")
    end

    if isdelete == true and cc.Director:getInstance():getRunningScene():getChildByTag(-100) ~= nil then
        cc.Director:getInstance():getRunningScene():getChildByTag(-100):removeFromParent()
        print("删除等待界面。。。。。")
    end

end
--**************************************模块：登陆   模块编号:10 说明:登陆服务器验证等
function CG_HANDLER(_cmdid)
        connectWaitScene()
    if  _cmdid == PACKET_CG_LoginGame  and SocketTCP.STATUS then 
        if NETWORD_GUID ~= 0 then
            print("NETWORD_GUID=="..NETWORD_GUID)
            local __t = CHECK_Handle(_cmdid)
            __t._PackData:init(NETWORD_GUID)
            SocketTCP:send(__t._PackData:getPack())
        end
    elseif _cmdid == PACKET_CG_HeartBeat  and SocketTCP.STATUS  then 
        local __t = CHECK_Handle(_cmdid)
        __t._PackData:init()
        SocketTCP:send(__t._PackData:getPack())

 
    elseif _cmdid == PACKET_CG_ModifyNickName  and SocketTCP.STATUS  then 
        local __t = CHECK_Handle(_cmdid)
        local __nickname = _infolist[1]
        __t._PackData:init(__nickname)
        SocketTCP:send(__t._PackData:getPack())


  --**************************************模块：聊天   模块编号:11 说明:

    elseif _cmdid == PACKET_CG_Chat  and SocketTCP.STATUS  then 
        local __t = CHECK_Handle(_cmdid)
        local __color = _infolist[1]
        local _cnt = _infolist[2]
        __t._PackData:init(__color,_cnt)
        SocketTCP:send(__t._PackData:getPack())

  --**************************************模块：英雄   模块编号:12 说明:

    elseif _cmdid == PACKET_CG_CallHero  and SocketTCP.STATUS  then 
        local __t = CHECK_Handle(_cmdid)
        local __heroid = _infolist[1]
        __t._PackData:init(__heroid)
        SocketTCP:send(__t._PackData:getPack())

    elseif _cmdid == PACKET_CG_HeroList  and SocketTCP.STATUS  then 
        local __t = CHECK_Handle(_cmdid)
        __t._PackData:init()
        SocketTCP:send(__t._PackData:getPack())

  --**************************************模块：物品   模块编号:13 说明:物品，背包，装备等

    elseif _cmdid ==PACKET_CG_AddItem  and SocketTCP.STATUS  then 
        local __t = CHECK_Handle(_cmdid)
        local __itemId = _infolist[1]
        __t._PackData:init(__itemId)
        SocketTCP:send(__t._PackData:getPack())

--    elseif _cmdid == PACKET_CG_ShopBuyItem  and SocketTCP.STATUS  then 
--        local __t = CHECK_Handle(_cmdid)
--        local __itemId = _infolist[1]
--        local __num = _infolist[2]
--        __t._PackData:init(__itemId,__num)
--        SocketTCP:send(__t._PackData:getPack())

    elseif _cmdid == PACKET_CG_PackBag  and SocketTCP.STATUS  then 
        local __t = CHECK_Handle(_cmdid)
        __t._PackData:init()
        SocketTCP:send(__t._PackData:getPack())

    elseif _cmdid == PACKET_CG_DragItem  and SocketTCP.STATUS then 
        local __t = CHECK_Handle(_cmdid)
        local __itemserial = _infolist[1]
        local __oldcell = _infolist[2]
        local __newcell = _infolist[3]
        __t._PackData:init(__itemserial,__oldcell,__newcell)
        SocketTCP:send(__t._PackData:getPack())

    elseif _cmdid == PACKET_CG_DeleteItem  and SocketTCP.STATUS  then 
        local __t = CHECK_Handle(_cmdid)
        local __itemserial = _infolist[1]
        local __num = _infolist[2]
        __t._PackData:init(__itemserial,__oldcell,__newcell)
        SocketTCP:send(__t._PackData:getPack())
        
    elseif _cmdid == PACKET_CG_ExtendBag  and SocketTCP.STATUS then 
        local __t = CHECK_Handle(_cmdid)
        local __num = _infolist[1]
        __t._PackData:init(__num)
        SocketTCP:send(__t._PackData:getPack())

    elseif _cmdid == PACKET_CG_BagList  and SocketTCP.STATUS  then 
        local __t = CHECK_Handle(_cmdid)
        __t._PackData:init()
        SocketTCP:send(__t._PackData:getPack())
        
    elseif _cmdid == PACKET_CG_BuyPhysicalFee  and SocketTCP.STATUS  then  --购买体力费用
        local __t = CHECK_Handle(_cmdid)
        __t._PackData:init()
        SocketTCP:send(__t._PackData:getPack())
    elseif _cmdid == PACKET_CG_PlayerInfo  and SocketTCP.STATUS  then  --玩家信息
        local __t = CHECK_Handle(_cmdid)
        __t._PackData:init()
        SocketTCP:send(__t._PackData:getPack())
    elseif _cmdid == PACKET_CG_MidasTouchFee  and SocketTCP.STATUS  then  --点金手费用
        local __t = CHECK_Handle(_cmdid)
        __t._PackData:init()
        SocketTCP:send(__t._PackData:getPack())
     end
     
end

function CG_HANDLER_Connect(_cmdid,_infolist)   --登陆
        connectWaitScene()
        if _cmdid == PACKET_CG_Connect then 
            local __t = CHECK_Handle(_cmdid)
            local _accid = _infolist[1]
            local _tstemp = _infolist[2]
            local _accname = _infolist[3]
    --        local _ticket = md5String(_accid.._accname.._tstemp.."SDFSDESF123DFSDF")
            local _ticket = "8392c5e0bd5869ee89c0a923f0001ffa"
            print("xddddddddd===".._accid)
            __t._PackData:init(_accid,_tstemp,_accname,_ticket)
    
            local _ = __t._PackData
            print(_._letterCodes,_._len,_.cmdid,_._accid,_._tstemp,string.len(_._accname) , _._accname,string.len(_._ticket) , _._ticket)    
            SocketTCP:send(__t._PackData:getPack())
        end
end
function CG_HANDLER_UseItem(id,num)   --使用物品
    connectWaitScene()
    if SocketTCP.STATUS   then
        local __t = CHECK_Handle(PACKET_CG_UseItem)
        __t._PackData:init(id,num)   --id,数量
        SocketTCP:send(__t._PackData:getPack())
        end
end

function CG_HANDLER_ShopItemList(shoptype)  --商店列表
    connectWaitScene()
    if SocketTCP.STATUS   then
    local __t = CHECK_Handle(PACKET_CG_ShopItemList)
    __t._PackData:init(shoptype)   --商店类型
    SocketTCP:send(__t._PackData:getPack())
    end
end

function CG_HANDLER_ShopBuyItem(id,shoptype)  --商店购买物品
    connectWaitScene()
    if SocketTCP.STATUS   then
           local __t = CHECK_Handle(PACKET_CG_ShopBuyItem)
    ---商店类型 1：商人商店 2：竞技场商店 3：远征商店  类型=short
            __t._PackData:init(id,shoptype)   --id,数量,商店类型 ---商店类型 1：商人商店 2：竞技场商店 3：远征商店  类型=short
           SocketTCP:send(__t._PackData:getPack())
           end
end
--PACKET_CG_RefreshShop
function CG_HANDLER_RefreshShop(shoptype,fee)  --刷新商店
    connectWaitScene()
    if SocketTCP.STATUS  then
    local __t = CHECK_Handle(PACKET_CG_RefreshShop)
    ---商店类型 1：商人商店 2：竞技场商店 3：远征商店  类型=short
    __t._PackData:init(shoptype,fee)   --id,数量,商店类型 ---商店类型 1：商人商店 2：竞技场商店 3：远征商店  类型=short
    SocketTCP:send(__t._PackData:getPack())
    end
end

function CG_HANDLER_RefreshShopFee(shoptype)  --刷新商店费用
    connectWaitScene()
    if SocketTCP.STATUS   then
    local __t = CHECK_Handle(PACKET_CG_RefreshShopFee)
    ---商店类型 1：商人商店 2：竞技场商店 3：远征商店  类型=short
    __t._PackData:init(shoptype)   --id,数量,商店类型 ---商店类型 1：商人商店 2：竞技场商店 3：远征商店  类型=short
    SocketTCP:send(__t._PackData:getPack())
    end
end

function CG_HANDLER_BuyPhysical(diamond)  --购买体力
    connectWaitScene()
    if SocketTCP.STATUS   then
        local __t = CHECK_Handle(PACKET_CG_BuyPhysical)
        ---商店类型 1：商人商店 2：竞技场商店 3：远征商店  类型=short
        __t._PackData:init(diamond)   --钻石数量
        SocketTCP:send(__t._PackData:getPack())
    end
end

--require "src/network/CG/CGDiamondRecharge"
function CG_HANDLER_DiamondRecharge(diamond)  --钻石充值
    connectWaitScene()
    if SocketTCP.STATUS   then
        local __t = CHECK_Handle(PACKET_CG_DiamondRecharge)
        ---商店类型 1：商人商店 2：竞技场商店 3：远征商店  类型=short
        __t._PackData:init(diamond)   --钻石数量
        SocketTCP:send(__t._PackData:getPack())
    end
end


function CG_HANDLER_SaleItem(_itemId,_num,_gold)  --出售物品
    connectWaitScene()
    if SocketTCP.STATUS   then
        local __t = CHECK_Handle(PACKET_CG_SaleItem)
        __t._PackData:init(_itemId,_num,_gold)   --ID,数量，价格
        SocketTCP:send(__t._PackData:getPack())
    end
end

function CG_HANDLER_MidasTouchUse(_times)  --点金手
    connectWaitScene()
    if SocketTCP.STATUS   then
        local __t = CHECK_Handle(PACKET_CG_MidasTouchUse)
        __t._PackData:init(_times)   --使用次数
        SocketTCP:send(__t._PackData:getPack())
    end
end

--**************************************模块：登陆   模块编号:10 说明:登陆服务器验证等
function GC_HANDLER(_cmdid,_body)
    if _cmdid == PACKET_GC_Connect then 
        local _GC = CHECK_Handle(_cmdid)
        _GC:unpack(_body)
        print("Connect回复_result = ".._GC._UnPackData._result)
        print("Connect回复_guid = ".._GC._UnPackData._guid)
        NETWORD_GUID= _GC._UnPackData._guid
--        local _Re = PacketManager.errorcode(_GC._UnPackData._result)
--        if _Re then
            SocketTCP.STATUS = true
--            FIND_CallBack(PACKET_GC_Connect,nil)
--        end
    elseif _cmdid == PACKET_GC_LoginGame then 
        local _GC = CHECK_Handle(_cmdid)
        _GC:unpack(_body)
        local _Re = PacketManager.errorcode(_GC._UnPackData._result)
    elseif _cmdid == PACKET_GC_HeartBeat then 
        local _GC = CHECK_Handle(_cmdid)
        _GC:unpack(_body)
        print("收到了心跳包 ")


    elseif _cmdid == PACKET_GC_ModifyNickName then 
        local _GC = CHECK_Handle(_cmdid)
        _GC:unpack(_body)

    --**************************************模块：聊天   模块编号:11 说明:
    elseif _cmdid == PACKET_GC_Chat then 
        local _GC = CHECK_Handle(_cmdid)
        _GC:unpack(_body)
        print("聊天包长 string.len(_body) = "..string.len(_body))
        print("聊天 id = ".._GC._UnPackData._guid)
        print("聊天 name = ".._GC._UnPackData._nickname)
        print("聊天 cnt = ".._GC._UnPackData._cnt)
        print("聊天 color = ".._GC._UnPackData._color)
    --**************************************模块：英雄   模块编号:12 说明:
    elseif _cmdid ==PACKET_GC_CallHero then 
        local _GC = CHECK_Handle(_cmdid)
        _GC:unpack(_body)

    elseif _cmdid == PACKET_GC_HeroList then 
        local _GC = CHECK_Handle(_cmdid)
        _GC:unpack(_body)

    --**************************************模块：物品   模块编号:13 说明:物品，背包，装备等

   
    elseif _cmdid == PACKET_GC_AddItem then 
        local _GC = CHECK_Handle(_cmdid)
        _GC:unpack(_body)

    elseif _cmdid == PACKET_GC_PackBag then 
        local _GC = CHECK_Handle(_cmdid)
        _GC:unpack(_body)

    elseif _cmdid == PACKET_GC_DragItem then 
        local _GC = CHECK_Handle(_cmdid)
        _GC:unpack(_body)

    elseif _cmdid == PACKET_GC_DeleteItem then 
        local _GC = CHECK_Handle(_cmdid)
        _GC:unpack(_body)

    elseif _cmdid == PACKET_GC_ExtendBag then 
        local _GC = CHECK_Handle(_cmdid)
        _GC:unpack(_body)

    elseif _cmdid == PACKET_GC_BagList then     --获取物品列表回复
        local _GC = CHECK_Handle(_cmdid)
        _GC:unpack(_body)
        
        print("baglist 长 string.len(_body) = "..string.len(_body))

        local msg = data_pb.Itemlist()
        msg:ParseFromString(_body)
        print(msg)
        print(msg.item)
        bagServerList = {}
        for i,v in ipairs(msg.item) do
            print("序号====="..i)
            print("物品ID====="..v.itemId)
            print("物品个数====="..v.num)
            local xx = {itemId = v.itemId,num = v.num}
            table.insert(bagServerList,xx)
        end
--        getItemData() --服务器传完之后转到本地数据
        for i,v in ipairs(bagServerList) do
            local bagData = getBagDataById(v.itemId) 
            --            print("[itemData(itemID==)]"..bagData._itemData.attrType1)
            if bagData == nil then
                print("adsadasdasdasdas===="..v.itemId)
            end
            bagData.iNum = v.num
        end
        FIND_CallBack(PACKET_GC_BagList,nil)
    elseif _cmdid == PACKET_GC_UseItem then 
        local _GC = CHECK_Handle(_cmdid)
        _GC:unpack(_body)
        print("使用物品回复====".._GC._UnPackData._result)
    --商店
    elseif _cmdid == PACKET_GC_RefreshShop then
        local _GC = CHECK_Handle(_cmdid)
        _GC:unpack(_body)
        print("刷新商店次数====".._GC._UnPackData._refreshtimes)
        
        local msg = data_pb.ShopItemlist()
        msg:ParseFromString(_body)
        print(msg)
        print(msg.shopitem)
        shopServerList ={}
        for i,v in ipairs(msg.shopitem) do
--            print("序号====="..i)
--            print("物品ID====="..v.itemId)--物品编号
--            print("物品个数====="..v.num) --物品数量
--            print("价格种类====="..v.itemkind) --价格种类
--            print("出售价格====="..v.itemsell) --出售价格
--            print("是否已买====="..v.ispurchase)--是否已买
            local xx = {itemId = v.itemId,num = v.num,itemkind=v.itemkind,itemsell=v.itemsell,ispurchase=v.ispurchase}
            table.insert(shopServerList,xx)
            print("adsddxxx=="..table.maxn(shopServerList))
        end
        getShopData()
        SceneShopMain()
    elseif _cmdid == PACKET_GC_RefreshShopFee then
        local _GC = CHECK_Handle(_cmdid)
        _GC:unpack(_body)
        print("刷新商店费用回复====".._GC._UnPackData._result)
        print("商店费用====".._GC._UnPackData._payableamt)
        print("刷新商店次数====".._GC._UnPackData._refreshtimes)
        --查看购买体力界面
        local _Re = PacketManager.errorcode(_GC._UnPackData._result)
        if _Re then
                local okBtnFunction =  function(sender,eventType)
                    local dd = sender:getParent():getParent():getParent():getParent()
                    if eventType == ccui.TouchEventType.ended then 
                    CG_HANDLER_RefreshShop(1,_GC._UnPackData._payableamt)
                        dd:removeFromParent()
                    end
                end
                local canleBtnFunction =  function(sender,eventType)
                    local dd = sender:getParent():getParent():getParent():getParent()
                    if eventType == ccui.TouchEventType.ended then 
                        dd:removeFromParent()
                    end
                end
            local dialog = DialogshowDialogPanel("确认花费".._GC._UnPackData._payableamt.."钻石刷新商店，是否继续？（今日已购买".._GC._UnPackData._refreshtimes.."次）","取消","确定",okBtnFunction,canleBtnFunction)
            cc.Director:getInstance():getRunningScene():addChild(dialog,90,90)
        end
    elseif _cmdid == PACKET_GC_ShopBuyItem then
        local _GC = CHECK_Handle(_cmdid)
        _GC:unpack(_body)
        print("购买回复====".._GC._UnPackData._result) --_payableamt
        FIND_CallBack(PACKET_GC_ShopBuyItem,_GC._UnPackData._result)
    elseif _cmdid == PACKET_GC_ShopItemList then
        local _GC = CHECK_Handle(_cmdid)
        _GC:unpack(_body)
--        print("商店列表回复====".._GC._UnPackData._result)
        local msg = data_pb.ShopItemlist()
        msg:ParseFromString(_body)
        print(msg)
        print(msg.shopitem)
        shopServerList = {}
        for i,v in ipairs(msg.shopitem) do
--            print("序号====="..i)
--            print("物品ID====="..v.itemId)--物品编号
--            print("物品个数====="..v.num) --物品数量
--            print("价格种类====="..v.itemkind) --价格种类
--            print("出售价格====="..v.itemsell) --出售价格
--            print("是否已买====="..v.ispurchase)--是否已买
            local xx = {itemId = v.itemId,num = v.num,itemkind=v.itemkind,itemsell=v.itemsell,ispurchase=v.ispurchase}
            table.insert(shopServerList,xx)
            print("adsddxxx=="..table.maxn(shopServerList))
        end
        getShopData()-- 服务器end转到本地
        FIND_CallBack(PACKET_GC_ShopItemList,nil)
    elseif _cmdid == PACKET_GC_BuyPhysicalFee then 
        local _GC = CHECK_Handle(_cmdid)
        _GC:unpack(_body)
        local _Re = PacketManager.errorcode(_GC._UnPackData._result)
        if _Re then
            print("结果回复====".._GC._UnPackData._result)
            print("钻石费用====".._GC._UnPackData._diamond)
            print("已经购买体力的次数====".._GC._UnPackData._usedtimes)

            PhysicalFee["diamond"] = _GC._UnPackData._diamond
            PhysicalFee["usedtimes"] = _GC._UnPackData._usedtimes
            FIND_CallBack(PACKET_GC_BuyPhysicalFee,nil)
        end
    elseif _cmdid == PACKET_GC_BuyPhysical then 
        local _GC = CHECK_Handle(_cmdid)
        _GC:unpack(_body)
       
        print("结果回复====".._GC._UnPackData._result)
        print("玩家钻石====".._GC._UnPackData._diamond)
        print("玩家体力====".._GC._UnPackData._physical)
            if _GC._UnPackData._result == 10000 then  --如果成功
                MyUserData._userData._uJewel = _GC._UnPackData._diamond
                MyUserData._userData._uPP = _GC._UnPackData._physical
            elseif _GC._UnPackData._result == 13022 then
        FIND_CallBack(PACKET_GC_BuyPhysical,_GC._UnPackData._result) --如果不成功
            end

    elseif _cmdid == PACKET_GC_DiamondRecharge then  --钻石充值回复
        local _GC = CHECK_Handle(_cmdid)
        _GC:unpack(_body)
        print("结果回复====".._GC._UnPackData._result)
        print("玩家钻石====".._GC._UnPackData._diamond)
        print("玩家vip等级====".._GC._UnPackData._viplv)
        local _Re = PacketManager.errorcode(_GC._UnPackData._result)
        if _Re then
            MyUserData._userData._uJewel = _GC._UnPackData._diamond
            FIND_CallBack(PACKET_GC_DiamondRecharge,nil)
        end
    elseif _cmdid == PACKET_GC_PlayerInfo then  --玩家信息回复
        local _GC = CHECK_Handle(_cmdid)
        _GC:unpack(_body)
--        print("头像去哪了=====----"..MyUserData._userData._uIcon)
        
        print("玩家在游戏中的编号====".._GC._UnPackData._guid)
        print("玩家昵称数据长度====".._GC._UnPackData._nicknamelen)
        print("玩家昵称====".._GC._UnPackData._nickname)
        print("等级====".._GC._UnPackData._level)
        print("vip等级====".._GC._UnPackData._viplevel)
        print("团队经验====".._GC._UnPackData._exp)
        print("头像编号====".._GC._UnPackData._icon)
        print("签到当前天数====".._GC._UnPackData._sign)
        print("玩家体力====".._GC._UnPackData._pp)
        print("玩家体力上限".._GC._UnPackData._physical)
        print("金币====".._GC._UnPackData._gold)
        print("钻石====".._GC._UnPackData._diamond)

        MyUserData._userData._uName = _GC._UnPackData._nickname
        MyUserData._userData._uLevel = _GC._UnPackData._level
        MyUserData._userData._uVipLevel = _GC._UnPackData._viplevel
        MyUserData._userData._uExp = _GC._UnPackData._exp
--        MyUserData._userData._uIcon = _GC._UnPackData._icon --头像编号
        MyUserData._userData._uPP = _GC._UnPackData._pp --体力
        MyUserData._userData._uPhysical = _GC._UnPackData._physical --体力上限
        MyUserData._userData._uGold = _GC._UnPackData._gold --金币
        MyUserData._userData._uJewel = _GC._UnPackData._diamond --钻石
        FIND_CallBack(PACKET_GC_PlayerInfo,nil)
        
    elseif _cmdid == PACKET_GC_SaleItem then  --出售物品回复
        local _GC = CHECK_Handle(_cmdid)
        _GC:unpack(_body)
        print("出售物品回复====".._GC._UnPackData._result)
        local _Re = PacketManager.errorcode(_GC._UnPackData._result)
        if _Re then
            print("出售成功出售成功出售成功出售成功出售成功出售成功出售成功出售成功出售成功出售成功出售成功")
            print("玩家金币====".._GC._UnPackData._gold)
            MyUserData._userData._uGold = _GC._UnPackData._gold
        end
        FIND_CallBack(PACKET_GC_SaleItem,_GC._UnPackData._result)
    elseif _cmdid == PACKET_GC_MidasTouchFee then  --点金手费用回复
        local _GC = CHECK_Handle(_cmdid)
        _GC:unpack(_body)
        print("点金手费用回复====".._GC._UnPackData._result)
        local _Re = PacketManager.errorcode(_GC._UnPackData._result)
        if _Re then
            print("需要钻石====".._GC._UnPackData._diamond)
            print("可获得金币====".._GC._UnPackData._gold)
            print("点金手剩余次数====".._GC._UnPackData._usedtimes)
            print("点金手总次数====".._GC._UnPackData._totaltimes)
            userMidasFee["_uGoldMake"] = _GC._UnPackData._usedtimes  --已经使用次数
            userMidasFee["_uGoldMakesum"] = _GC._UnPackData._totaltimes  --总次数
            userMidasFee["_Makediamond"] = _GC._UnPackData._diamond  --需要钻石
            userMidasFee["_Makediagold"] = _GC._UnPackData._gold--可获得金币
            print("vipNum1============"..userMidasFee["_uGoldMakesum"])
            print("vipNum2============"..userMidasFee["_uGoldMake"])
        end
        FIND_CallBack(PACKET_GC_MidasTouchFee,_GC._UnPackData._result)
    elseif _cmdid == PACKET_GC_MidasTouchUse then  --点金手回复
        local _GC = CHECK_Handle(_cmdid)
        _GC:unpack(_body)
        print("点金手回复====".._GC._UnPackData._result)
        
        local msg = data_pb.MidasTouchlist()
        msg:ParseFromString(_GC._UnPackData._pbdata)
        print(msg)
        userMidasUse = {}
        
        local _Re = PacketManager.errorcode(_GC._UnPackData._result)
        if _Re then
            for i,v in ipairs(msg.midastouch) do
                --1.剩余次数 2.需要钻石 3.获得金币 4.暴击倍数
                local xx = {_uGoldMake = v.times,_Makediamond = v.diamond, _Makediagold=v.gold, _uMakecrit=v.crit}
                table.insert(userMidasUse,xx)
                print("使用点金手的次数是======="..table.maxn(userMidasUse))
            end
            MyUserData._userData._uGold = _GC._UnPackData._gold --金币
            MyUserData._userData._uJewel = _GC._UnPackData._diamond --钻石

            userMidasFee["_uGoldMake"] = _GC._UnPackData._totalusedtimes  --已使用次数
            userMidasFee["_uGoldMakesum"] = _GC._UnPackData._totalusetimes  --总次数
            userMidasFee["_Makediamond"] = _GC._UnPackData._nextcostdiamond  --需要钻石
            userMidasFee["_Makediagold"] = _GC._UnPackData._nextcostgold--可获得金币
        end
        FIND_CallBack(PACKET_GC_MidasTouchUse,_GC._UnPackData._result)
    end
    print("--------------解包end")
    connectWaitScene(true)
end

PhysicalFee = {diamond = nil,usedtimes = nil}



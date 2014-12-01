


	--消息类型值描述格式：PACKET_XX_YYYYYY 
	--XX可以描述为：GC、CG、CL、LC、GL、LG
	--YYYYYY表示消息内容
	--例如：PACKET_CG_ATTACK 表示客户端发给游戏服务器端关于攻击的消息


--**************************************模块：登陆	模块编号:10	说明:登陆服务器验证等

PACKET_CG_Connect			=			10000			--登陆服务器
PACKET_GC_Connect			=			10001			--登陆回复
PACKET_CG_LoginGame			=			10002			--登陆游戏
PACKET_GC_LoginGame			=			10003			--登陆游戏回复
PACKET_CG_HeartBeat			=			10004			--心跳包
PACKET_GC_HeartBeat			=			10005			--心跳包
PACKET_CG_ModifyNickName			=			10006			--申请修改昵称
PACKET_GC_ModifyNickName			=			10007			--回复修改昵称
PACKET_CG_ModifyIcon			=			10008			--申请修改Icon
PACKET_GC_ModifyIcon			=			10009			--回复修改昵称
--**************************************模块：聊天	模块编号:11	说明:

PACKET_CG_Chat			=			11000			--世界聊天
PACKET_GC_Chat			=			11001			--聊天信息
--**************************************模块：英雄	模块编号:12	说明:

PACKET_CG_CallHero			=			12000			--召唤英雄
PACKET_GC_CallHero			=			12001			--回复召唤英雄
PACKET_CG_HeroList			=			12002			--申请英雄列表
PACKET_GC_HeroList			=			12003			--回复英雄列表
PACKET_CG_PlayerInfo			=			12004			--查询玩家信息
PACKET_GC_PlayerInfo			=			12005			--回复玩家信息
PACKET_GC_PlayerAttrChange			=			12007			--团队属性改变
PACKET_CG_StarLevelUp			=			12008			--英雄升星
PACKET_GC_StarLevelUp			=			12009			--回复英雄升星
PACKET_CG_QualityUp			=			12010			--申请英雄升阶
PACKET_GC_QualityUp			=			12011			--回复英雄升阶结果
PACKET_CG_UnlockStage			=			12012			--申请解锁关卡
PACKET_GC_UnlockStage			=			12013			--回复申请关卡结果
PACKET_GC_PushMsg			=			12015			--推送消息
--**************************************模块：物品	模块编号:13	说明:物品，背包，装备等

PACKET_CG_AddItem			=			13000			--添加物品
PACKET_GC_AddItem			=			13001			--回复添加物品结果
PACKET_CG_ShopBuyItem			=			13002			--在商城中购买物品
PACKET_GC_ShopBuyItem			=			13003			--回复商城购买结果
PACKET_CG_PackBag			=			13004			--整理背包
PACKET_GC_PackBag			=			13005			--整理背包结果
PACKET_CG_DragItem			=			13006			--移动交换合并背包格子
PACKET_GC_DragItem			=			13007			--回复移动交换合并背包
PACKET_CG_DeleteItem			=			13008			--删除物品
PACKET_GC_DeleteItem			=			13009			--删除物品回复
PACKET_CG_ExtendBag			=			13010			--扩充背包
PACKET_GC_ExtendBag			=			13011			--扩充背包结果
PACKET_CG_BagList			=			13012			--背包列表
PACKET_GC_BagList			=			13013			--回复背包列表
PACKET_CG_WearItem			=			13014			--穿戴装备
PACKET_GC_WearItem			=			13015			--回复穿戴装备结果
PACKET_CG_TakeOffItem			=			13016			--卸载装备
PACKET_GC_TakeOffItem			=			13017			--回复卸载装备结果
PACKET_CG_EquipList			=			13018			--装备列表
PACKET_GC_EquipList			=			13019			--回复装备列表
PACKET_CG_ShopItemList			=			13020			--商店物品列表
PACKET_GC_ShopItemList			=			13021			--回复商店物品列表
PACKET_CG_UseItem			=			13022			--物品消耗
PACKET_GC_UseItem			=			13023			--回复物品消耗
PACKET_CG_RefreshShopFee			=			13024			--刷新商店费用
PACKET_GC_RefreshShopFee			=			13025			--回复刷新商店费用
PACKET_CG_RefreshShop			=			13026			--刷新商店
PACKET_GC_RefreshShop			=			13027			--回复刷新商店
PACKET_GC_ItemNumChange			=			13029			--物品数量改变
PACKET_CG_EquipStrengthen			=			13030			--装备栏强化
PACKET_GC_EquipStrengthen			=			13031			--回复装备栏强化
PACKET_CG_MidasTouchFee			=			13032			--点金手费用
PACKET_GC_MidasTouchFee			=			13033			--回复点金手费用
PACKET_CG_MidasTouchUse			=			13034			--使用点金手
PACKET_GC_MidasTouchUse			=			13035			--回复使用点金手
PACKET_CG_SaleItem			=			13036			--出售物品
PACKET_GC_SaleItem			=			13037			--回复出售物品
PACKET_CG_BuyPhysical			=			13038			--购买体力
PACKET_GC_BuyPhysical			=			13039			--回复购买体力
PACKET_CG_DiamondRecharge			=			13040			--钻石充值
PACKET_GC_DiamondRecharge			=			13041			--回复钻石充值
PACKET_CG_BuyPhysicalFee			=			13042			--购买体力费用
PACKET_GC_BuyPhysicalFee			=			13043			--回复购买体力费用
PACKET_CG_PropsSynthesis			=			13044			--道具合成
PACKET_GC_PropsSynthesis			=			13045			--回复道具合成
PACKET_CG_ReplaceItem			=			13046			--更换装备
PACKET_GC_ReplaceItem			=			13047			--回复更换装备
PACKET_CG_TakeMedicine			=			13048			--英雄吃药
PACKET_GC_TakeMedicine			=			13049			--回复英雄吃药
PACKET_CG_GetPhysical			=			13050			--领取体力
PACKET_GC_GetPhysical			=			13051			--回复领取体力
PACKET_CG_DailyAttendanceSheet			=			13052			--每日签到表
PACKET_GC_DailyAttendanceSheet			=			13053			--回复每日签到表
PACKET_CG_DailyAttendance			=			13054			--每日签到
PACKET_GC_DailyAttendance			=			13055			--回复每日签到
PACKET_CG_DailyAttendanceList			=			13056			--玩家每日签到记录列表
PACKET_GC_DailyAttendanceList			=			13057			--回复玩家每日签到记录列表
--**************************************模块：战斗	模块编号:14	说明:战斗相关，技能，装备技能

PACKET_CG_StartCombat			=			14000			--开始战斗
--**************************************模块：任务	模块编号:15	说明:任务相关

PACKET_CG_DailyTaskList			=			15000			--玩家每日任务记录列表
PACKET_GC_DailyTaskList			=			15001			--回复玩家每日任务记录列表
PACKET_CG_TaskList			=			15002			--玩家任务记录列表
PACKET_GC_TaskList			=			15003			--回复玩家任务记录列表

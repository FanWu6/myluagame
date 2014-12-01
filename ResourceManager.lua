--图片资源管理类
--添加时注明日期

DESIGN_RESOLUTION_1136X640   = 0
DESIGN_RESOLUTION_1024X768   = 1
DESIGN_RESOLUTION_2048X1536  = 2

TARGET_DESIGN_RESOLUTION_SIZE = DESIGN_RESOLUTION_1136X640


WIN_TYPE_IPHONE5 = 1
WIN_TYPE_IPHONE4 = 2

DesignResolutionSize = {width = 480, height = 320, winType = 0}

if TARGET_DESIGN_RESOLUTION_SIZE == DESIGN_RESOLUTION_1136X640 then
	DesignResolutionSize.width = 1136
	DesignResolutionSize.height = 640
	DesignResolutionSize.winType = WIN_TYPE_IPHONE5
elseif TARGET_DESIGN_RESOLUTION_SIZE == DESIGN_RESOLUTION_1024X768 then
	DesignResolutionSize.width = 1024
	DesignResolutionSize.height = 768
elseif TARGET_DESIGN_RESOLUTION_SIZE == DESIGN_RESOLUTION_2048X1536 then
	DesignResolutionSize.width = 2048
	DesignResolutionSize.height = 1536
end

local smallResourceI5  =  { width = 1136, height = 640,  path = "res/iphone" };
local smallResourceI4  =  { width = 960, height = 640,  path = "res/iphone" };
local mediumResource =  { width = 1024, height = 768,  path = "res/ipad"   };
local largeResource  =  { width = 2048, height = 1536, path = "res/ipadhd" };


local glView = cc.Director:getInstance():getOpenGLView()
ScreenSize = glView:getFrameSize()
local targetPlatform = cc.Application:getInstance():getTargetPlatform()

glView:setDesignResolutionSize(DesignResolutionSize.width,DesignResolutionSize.height,cc.ResolutionPolicy.NO_BORDER)

local resPrefix = "res/"
local srcPrefix = "src/"

local fileUtils = cc.FileUtils:getInstance()
local searchPaths = fileUtils:getSearchPaths()
table.insert(searchPaths, 1, "res")
table.insert(searchPaths, 1, "src")
table.insert(searchPaths, 1, resPrefix .. "shader")
table.insert(searchPaths, 1, resPrefix .. "xml")

if ScreenSize.width == smallResourceI5.width then

	local _resPrefix = smallResourceI5.path
	DesignResolutionSize.winType = WIN_TYPE_IPHONE5

	table.insert(searchPaths, 1, _resPrefix)
	table.insert(searchPaths, 1, _resPrefix .. "/armature")
	table.insert(searchPaths, 1, _resPrefix .. "/bg")
	table.insert(searchPaths, 1, _resPrefix .. "/ui")
    cc.Director:getInstance():setContentScaleFactor(smallResourceI5.width/DesignResolutionSize.width)

elseif ScreenSize.width == smallResourceI4.width then
    
	local _resPrefix = smallResourceI4.path
	DesignResolutionSize.winType = WIN_TYPE_IPHONE4

	table.insert(searchPaths, 1, _resPrefix)
	table.insert(searchPaths, 1, _resPrefix .. "/armature")
	table.insert(searchPaths, 1, _resPrefix .. "/bg")
	table.insert(searchPaths, 1, _resPrefix .. "/ui")

--ccs 做的界面适配方案：用i5的屏幕 ui放置区域用i4的屏幕 
--[[
example: []为ui区域 960x640(i4)
		 {}为cocostudio的制作画布区域 1136x640(i5)

	{		[              ]		}
	{		[              ] 画布区域	}
	{		[    ui区域     ]		}
	{		[              ]		}
	{		[              ]		}

]]--
    -- cc.Director:getInstance():setContentScaleFactor(smallResourceI4.width/DesignResolutionSize.width)

elseif ScreenSize.width == largeResource.width then
 	local _resPrefix = smallResourceI5.path

	table.insert(searchPaths, 1, _resPrefix)
	table.insert(searchPaths, 1, _resPrefix .. "/armature")
	table.insert(searchPaths, 1, _resPrefix .. "/bg")
	table.insert(searchPaths, 1, _resPrefix .. "/ui")
    cc.Director:getInstance():setContentScaleFactor(math.min(largeResource.height/DesignResolutionSize.height, largeResource.width/DesignResolutionSize.width))

end

--[[
在设置图片坐标的时候 添加 偏移量 确保屏幕适配 
exp::setPosition(cc.p(POS_OFFSET_X+56,POS_OFFSET_Y+ ScreenSize.height-_pauseBtn:getContentSize().height/2))
]]--
POS_OFFSET_X = (DesignResolutionSize.width-ScreenSize.width)/2
POS_OFFSET_Y = (DesignResolutionSize.height-ScreenSize.height)/2



table.insert(searchPaths, 1, "res/iphone/armature")
fileUtils:setSearchPaths(searchPaths)

cc.Director:getInstance():setDisplayStats(true)
cc.Director:getInstance():setAnimationInterval(1.0 / 60)



--********************************
--*********wangwei add************
--********************************

--调用已加入内存的图片
	-- local m_pTex1 = cc.Director:getInstance():getTextureCache():getTextureForKey("bigtest.png")
	-- local ss = cc.Sprite:createWithTexture(m_pTex1)
	-- scene:addChild(ss)
--如果不想被释放，那么就要调用对象的retain函数，这样对象不会被内存管理机制杀掉了。
	-- local m_pTex1 = cc.Director:getInstance():getTextureCache():addImage("bigtest.png")
 	-- m_pTex1:retain()
--当不需要再使用这个对象时，就要调用对象的release函数，这是和retain对应的。一般可以在析构函数里调用release函数。

--加载骨骼动画方法
    -- ccs.ArmatureDataManager:getInstance():addArmatureFileInfo("MMsoldier.png", "MMsoldier.plist", "MMsoldier.xml")
    -- ccs.ArmatureDataManager:getInstance():addArmatureFileInfo("weapon.png", "weapon.plist", "weapon.xml")
    -- ccs.ArmatureDataManager:getInstance():addArmatureFileInfo("robot.png", "robot.plist", "robot.xml")
    -- ccs.ArmatureDataManager:getInstance():addArmatureFileInfo("cyborg.png", "cyborg.plist", "cyborg.xml")
    -- ccs.ArmatureDataManager:getInstance():addArmatureFileInfo("Dragon.png", "Dragon.plist", "Dragon.xml")


function AddImagesToTexture( lists )
	-- body

	for i,v in ipairs(lists) do
		print(i,v)
		cc.Director:getInstance():getTextureCache():addImage(v)
	end

end




--********************************
--*********chenqiang add**********
--********************************





--********************************
--*********wufan add**************
--********************************




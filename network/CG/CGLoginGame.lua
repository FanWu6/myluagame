--CGLoginGame.lua
--登陆游戏
--指令:PACKET_CG_LoginGame    指令编号10002   十六进制:0x2712
--auto create by roy.z at 2014-09-05
--
--------------------------------------------------------------


local CGLoginGameInstance = nil 


--------------------------------------------------------------
function CGLoginGameCreate()
    -- cclog("CGLoginGameCreate")

    CGLoginGame= BaseData:new()

    CGLoginGame.new = function(self) 
        local o = getmetatable(self).new(self)

        o._PackData = BaseData:new()
        o._PackData.new = function(self) 

            local o = getmetatable(self).new(self)

            --初始化_CGLoginGameData内数据
            o.cmdid = PACKET_CG_LoginGame   --指令编号
            o._guid = 0         ---玩家在游戏中的编号    类型=int

            o._len = 2 + 2 +  4

            o._letterCodes = ">HHi"

            o._pack = nil

            return o
        end

        o._PackData.init = function(self,__guid)

            self._guid = __guid         ---玩家在游戏中的编号    类型=int

            self._len = 2 + 2 +  4

            self._pack = string.pack(self._letterCodes,self._len,self.cmdid,self._guid)

            return o
        end


        o._PackData.getPack = function(self)
            return self._pack
        end

        return o
    end



    CGLoginGameInstance = CGLoginGame:new()
    CGLoginGameInstance._PackData = CGLoginGameInstance._PackData:new()

    return CGLoginGameInstance
end


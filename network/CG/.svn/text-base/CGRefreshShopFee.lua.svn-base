--CGRefreshShopFee.lua
--刷新商店费用
--指令:PACKET_CG_RefreshShopFee	指令编号13024	十六进制:0x32E0
--auto create by roy.z at 
--
 --------------------------------------------------------------


local CGRefreshShopFeeInstance = nil 


 --------------------------------------------------------------
function CGRefreshShopFeeCreate()
	-- cclog("CGRefreshShopFeeCreate")

	CGRefreshShopFee= BaseData:new()

	CGRefreshShopFee.new = function(self) 
		local o = getmetatable(self).new(self)

		o._PackData = BaseData:new()
		o._PackData.new = function(self) 

			local o = getmetatable(self).new(self)

			--初始化_CGRefreshShopFeeData内数据
			o.cmdid = PACKET_CG_RefreshShopFee	--指令编号
			o._shoptype = 0			---商店类型 1：商人商店 2：竞技场商店 3：远征商店	类型=short

			o._len = 2 + 2 +  2

			o._letterCodes = ">HHh"

			o._pack = nil

			return o
		end

		o._PackData.init = function(self,__shoptype)

			self._shoptype = __shoptype			---商店类型 1：商人商店 2：竞技场商店 3：远征商店	类型=short

			self._len = 2 + 2 +  2

			self._pack = string.pack(self._letterCodes,self._len,self.cmdid,self._shoptype)

			return o
		end


		o._PackData.getPack = function(self)
			return self._pack
		end

		return o
	end



	CGRefreshShopFeeInstance = CGRefreshShopFee:new()
	CGRefreshShopFeeInstance._PackData = CGRefreshShopFeeInstance._PackData:new()

	return CGRefreshShopFeeInstance
end


--CGRefreshShop.lua
--刷新商店
--指令:PACKET_CG_RefreshShop	指令编号13026	十六进制:0x32E2
--auto create by roy.z at 
--
 --------------------------------------------------------------


local CGRefreshShopInstance = nil 


 --------------------------------------------------------------
function CGRefreshShopCreate()
	-- cclog("CGRefreshShopCreate")

	CGRefreshShop= BaseData:new()

	CGRefreshShop.new = function(self) 
		local o = getmetatable(self).new(self)

		o._PackData = BaseData:new()
		o._PackData.new = function(self) 

			local o = getmetatable(self).new(self)

			--初始化_CGRefreshShopData内数据
			o.cmdid = PACKET_CG_RefreshShop	--指令编号
			o._shoptype = 0			---商店类型 1：商人商店 2：竞技场商店 3：远征商店	类型=short
			o._payableamt = 0			---刷新商店费用	类型=int

			o._len = 2 + 2 +  2 + 4

			o._letterCodes = ">HHhi"

			o._pack = nil

			return o
		end

		o._PackData.init = function(self,__shoptype,__payableamt)

			self._shoptype = __shoptype			---商店类型 1：商人商店 2：竞技场商店 3：远征商店	类型=short
			self._payableamt = __payableamt			---刷新商店费用	类型=int

			self._len = 2 + 2 +  2 + 4

			self._pack = string.pack(self._letterCodes,self._len,self.cmdid,self._shoptype,self._payableamt)

			return o
		end


		o._PackData.getPack = function(self)
			return self._pack
		end

		return o
	end



	CGRefreshShopInstance = CGRefreshShop:new()
	CGRefreshShopInstance._PackData = CGRefreshShopInstance._PackData:new()

	return CGRefreshShopInstance
end


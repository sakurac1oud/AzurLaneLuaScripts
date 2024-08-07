slot0 = class("GoldExchangeView")
slot0.itemid1 = 12
slot0.itemid2 = 24
slot0.const = 5
slot0.goldNum = {
	[1.0] = 3000,
	[2.0] = 15000
}
slot0.gemNum = {
	[1.0] = 100,
	[2.0] = 450
}

slot0.Ctor = function(slot0)
	pg.DelegateInfo.New(slot0)

	slot1 = PoolMgr.GetInstance()

	slot1:GetUI("GoldExchangeWindow", false, function (slot0)
		slot0.transform:SetParent(pg.UIMgr.GetInstance().UIMain.transform, false)

		uv0._go = slot0
		uv0._tf = slot0.transform

		uv0:init()
	end)
end

slot0.init = function(slot0)
	slot0:initData()
	slot0:initUI()
	slot0:addListener()
	slot0:overLayMyself(true)
	slot0:updateView()
end

slot0.findTF = function(slot0, slot1, slot2)
	assert(slot0._tf, "transform should exist")

	return findTF(slot2 or slot0._tf, slot1)
end

slot0.exit = function(slot0)
	pg.DelegateInfo.Dispose(slot0)
	slot0:overLayMyself(false)
	PoolMgr.GetInstance():ReturnUI("GoldExchangeWindow", slot0._go)

	pg.goldExchangeMgr = nil
end

slot0.initData = function(slot0)
	slot0.selectedIndex = 1
	slot0.selectedNum = 1
	slot0.selectedMax = 10
	slot0.player = getProxy(PlayerProxy):getData()
end

slot0.initUI = function(slot0)
	slot0.bg = slot0:findTF("BG")
	slot0.btnBack = slot0:findTF("Window/top/btnBack")
	slot0.contentTF = slot0:findTF("Window/Content")
	slot0.goldTF = {
		{}
	}
	slot0.goldTF_1 = slot0:findTF("Gold1", slot0.contentTF)
	slot0.goldTF[1].itemTF = slot0.goldTF_1
	slot0.goldTF[1].countTF = slot0:findTF("item/icon_bg/count", slot0.goldTF_1)
	slot0.goldTF[1].priceTF = slot0:findTF("item/consume/contain/price", slot0.goldTF_1)
	slot0.goldTF[1].selectedTF = slot0:findTF("item/selected", slot0.goldTF_1)
	slot0.goldTF[1].selectedNumTF = slot0:findTF("reduce/Text", slot0.goldTF[1].selectedTF)

	setText(slot0.goldTF[1].countTF, uv0.goldNum[1])
	setText(slot0.goldTF[1].priceTF, uv0.gemNum[1])

	slot0.goldTF[2] = {}
	slot0.goldTF_2 = slot0:findTF("Gold2", slot0.contentTF)
	slot0.goldTF[2].itemTF = slot0.goldTF_2
	slot0.goldTF[2].countTF = slot0:findTF("item/icon_bg/count", slot0.goldTF_2)
	slot0.goldTF[2].priceTF = slot0:findTF("item/consume/contain/price", slot0.goldTF_2)
	slot0.goldTF[2].selectedTF = slot0:findTF("item/selected", slot0.goldTF_2)
	slot0.goldTF[2].selectedNumTF = slot0:findTF("reduce/Text", slot0.goldTF[2].selectedTF)

	setText(slot0.goldTF[2].countTF, uv0.goldNum[2])
	setText(slot0.goldTF[2].priceTF, uv0.gemNum[2])

	slot0.gemCountText = slot0:findTF("Tip/DiamondCount", slot0.contentTF)
	slot0.goldCountText = slot0:findTF("Tip/GoldCount", slot0.contentTF)
	slot0.shopBtn = slot0:findTF("Window/button_container/ShopBtn")
	slot0.confirmBtn = slot0:findTF("Window/button_container/ConfirmBtn")
end

slot0.addListener = function(slot0)
	onButton(slot0, slot0.bg, function ()
		uv0:exit()
	end, SFX_CANCEL)
	onButton(slot0, slot0.btnBack, function ()
		uv0:exit()
	end, SFX_CANCEL)
	onButton(slot0, slot0.shopBtn, function ()
		if getProxy(ContextProxy):getContextByMediator(ChargeMediator) then
			uv0:exit()
		else
			pg.m02:sendNotification(GAME.GO_SCENE, SCENE.CHARGE, {
				wrap = ChargeScene.TYPE_ITEM
			})
		end
	end, SFX_PANEL)

	slot4 = function()
		slot0 = nil

		if uv0.selectedIndex == 1 then
			slot0 = uv1.itemid1
		elseif uv0.selectedIndex == 2 then
			slot0 = uv1.itemid2
		end

		pg.m02:sendNotification(GAME.SHOPPING, {
			isQuickShopping = true,
			id = slot0,
			count = uv0.selectedNum
		})
		uv0:exit()
	end

	onButton(slot0, slot0.confirmBtn, slot4, SFX_PANEL)

	for slot4 = 1, 2 do
		onButton(slot0, slot0.goldTF[slot4].itemTF, function ()
			if uv0.selectedIndex == uv1 then
				uv0.selectedNum = math.min(uv0.selectedNum + 1, uv0.selectedMax)
			else
				uv0.selectedIndex = uv1
				uv0.selectedNum = 1
			end

			uv0:updateView()
		end, SFX_PANEL)
		onButton(slot0, slot0.goldTF[slot4].selectedTF, function ()
			if uv0.selectedNum > 1 then
				uv0.selectedNum = uv0.selectedNum - 1

				uv0:updateView()
			end
		end, SFX_PANEL)
	end
end

slot0.updateView = function(slot0)
	for slot4 = 1, 2 do
		setActive(slot0.goldTF[slot4].selectedTF, slot4 == slot0.selectedIndex)
		setActive(slot0.goldTF[3 - slot4].selectedTF, slot4 ~= slot0.selectedIndex)

		if slot4 == slot0.selectedIndex then
			setText(slot0.goldTF[slot4].selectedNumTF, slot0.selectedNum)
		end
	end

	slot1, slot2 = nil
	slot1 = uv0.gemNum[slot0.selectedIndex] * slot0.selectedNum
	slot2 = uv0.goldNum[slot0.selectedIndex] * slot0.selectedNum

	setText(slot0.gemCountText, slot1)

	if slot0.player:getTotalGem() < slot1 then
		setTextColor(slot0.gemCountText, Color.red)
	else
		setTextColor(slot0.gemCountText, Color.yellow)
	end

	setText(slot0.goldCountText, slot2)
end

slot0.overLayMyself = function(slot0, slot1)
	if slot1 == true then
		pg.UIMgr.GetInstance():BlurPanel(slot0._tf, false, {
			weight = LayerWeightConst.TOP_LAYER
		})
	else
		pg.UIMgr.GetInstance():UnblurPanel(slot0._tf)
	end
end

return slot0

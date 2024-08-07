slot0 = class("GuildShopPage", import(".MilitaryShopPage"))

slot0.getUIName = function(slot0)
	return "GuildShop"
end

slot0.CanOpen = function(slot0)
	return true
end

slot0.OnInit = function(slot0)
	onButton(slot0, slot0.refreshBtn, function ()
		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			content = i18n("guild_shop_refresh_all_tip", uv0.shop:GetResetConsume(), i18n("word_guildgold")),
			onYes = function ()
				if uv0.player:getResource(PlayerConst.ResGuildCoin) < uv1 then
					pg.TipsMgr.GetInstance():ShowTips(i18n("common_no_resource"))

					return
				else
					uv0:emit(NewShopsMediator.REFRESH_GUILD_SHOP, true)
				end
			end
		})
	end, SFX_PANEL)

	slot0.purchaseWindow = GuildShopPurchasePanel.New(slot0._tf, slot0.event)
end

slot0.UpdateShop = function(slot0, ...)
	uv0.super.UpdateShop(slot0, ...)

	if slot0.purchaseWindow:isShowing() then
		slot0.purchaseWindow:ExecuteAction("Hide")
	end
end

slot0.OnUpdatePlayer = function(slot0)
	slot0.exploitTF.text = slot0.player:getResource(PlayerConst.ResGuildCoin)
end

slot0.OnSetUp = function(slot0)
	uv0.super.OnSetUp(slot0)
	slot0:UpdateRefreshBtn()
end

slot0.UpdateRefreshBtn = function(slot0)
	setButtonEnabled(slot0.refreshBtn, slot0.shop:CanRefresh())
end

slot0.OnInitItem = function(slot0, slot1)
	slot2 = GuildGoodsCard.New(slot1)

	onButton(slot0, slot2._go, function ()
		if not uv0.goods:CanPurchase() then
			pg.TipsMgr.GetInstance():ShowTips(i18n("buy_countLimit"))

			return
		end

		uv1:OnCardClick(uv0)
	end, SFX_PANEL)

	slot0.cards[slot1] = slot2
end

slot0.OnCardClick = function(slot0, slot1)
	if slot1.goods:Selectable() then
		slot0.purchaseWindow:ExecuteAction("Show", {
			id = slot1.goods.id,
			count = slot1.goods:GetMaxCnt(),
			type = slot1.goods:getConfig("type"),
			price = slot1.goods:getConfig("price"),
			displays = slot1.goods:getConfig("goods"),
			num = slot1.goods:getConfig("num")
		})
	else
		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			yesText = "text_exchange",
			content = i18n("guild_shop_exchange_tip"),
			onYes = function ()
				if not uv0.goods:CanPurchase() then
					pg.TipsMgr.GetInstance():ShowTips(i18n("buy_countLimit"))

					return
				end

				uv1:emit(NewShopsMediator.ON_GUILD_SHOPPING, uv0.goods.id, uv0.goods:GetFirstDropId())
			end
		})
	end
end

slot0.OnTimeOut = function(slot0)
	slot0:emit(NewShopsMediator.REFRESH_GUILD_SHOP, false)
end

slot0.OnDestroy = function(slot0)
	uv0.super.OnDestroy(slot0)
	slot0.purchaseWindow:Destroy()
end

return slot0

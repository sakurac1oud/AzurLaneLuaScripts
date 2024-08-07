slot0 = class("BattleResultMetaExpView", import("..base.BaseSubView"))

slot0.getUIName = function(slot0)
	return "BattleResultMetaExpUI"
end

slot0.OnInit = function(slot0)
	slot0:initUITip()
	slot0:initData()
	slot0:initUI()
	slot0:addListener()
	slot0:updateIconList()
end

slot0.OnDestroy = function(slot0)
	slot0.closeCB()
	slot0:cleanManagedTween(true)
end

slot0.setData = function(slot0, slot1, slot2)
	slot0.lastMetaExpInfoList = slot1
	slot0.closeCB = slot2
end

slot0.initUITip = function(slot0)
	setText(slot0:findTF("Notch/Panel/Title/Text"), i18n("battle_end_subtitle2"))
end

slot0.initData = function(slot0)
	slot0.metaProxy = getProxy(MetaCharacterProxy)
end

slot0.initUI = function(slot0)
	slot0.bg = slot0:findTF("BG")
	slot0.iconTpl = slot0:findTF("IconTpl")
	slot0.panelTF = slot0:findTF("Notch/Panel")
	slot0.iconContainer = slot0:findTF("ScrollView/Content", slot0.panelTF)
	slot0.gridLayoutGroupSC = GetComponent(slot0.iconContainer, typeof(GridLayoutGroup))
	slot0.closeBtn = slot0:findTF("Button", slot0.panelTF)
	slot0.iconUIItemList = UIItemList.New(slot0.iconContainer, slot0.iconTpl)
end

slot0.addListener = function(slot0)
	onButton(slot0, slot0.bg, function ()
		uv0:closePanel()
	end, SFX_PANEL)
	onButton(slot0, slot0.closeBtn, function ()
		uv0:closePanel()
	end, SFX_PANEL)
end

slot0.updateIconList = function(slot0)
	slot0.gridLayoutGroupSC.constraintCount = #slot0:sortDataList(slot0.lastMetaExpInfoList or slot0.metaProxy:getLastMetaSkillExpInfoList()) > 4 and 2 or 1

	slot0.iconUIItemList:make(function (slot0, slot1, slot2)
		slot1 = slot1 + 1

		if slot0 == UIItemList.EventUpdate then
			slot6 = uv0:findTF("LevelMaxText", slot2)
			slot7 = uv0:findTF("ExpMaxText", slot2)
			slot8 = uv0:findTF("Slider", slot2)
			slot9 = uv1[slot1]
			slot14 = slot9.isExpMax
			slot15 = slot9.progress
			slot17 = getProxy(BayProxy):getShipById(slot9.shipID):getPainting()

			setImageSprite(uv0:findTF("Icon", slot2), LoadSprite("SquareIcon/" .. slot17, slot17))
			setText(uv0:findTF("AddExpText", slot2), "EXP + " .. slot9.addDayExp)
			setActive(uv0:findTF("Light", slot2), slot9.isUpLevel and slot9.isMaxLevel)

			if slot12 and slot13 then
				setActive(slot5, false)
				setActive(slot6, true)
				setActive(slot7, false)
			elseif slot14 then
				setActive(slot5, false)
				setActive(slot6, false)
				setActive(slot7, true)
			else
				setActive(slot5, true)
				setActive(slot6, false)
				setActive(slot7, false)
			end

			setSlider(slot8, 0, 1, slot15)
			onButton(uv0, slot2, function ()
				LoadContextCommand.LoadLayerOnTopContext(Context.New({
					viewComponent = MetaSkillDetailBoxLayer,
					mediator = MetaSkillDetailBoxMediator,
					data = {
						metaShipID = uv0.id,
						expInfoList = uv1.lastMetaExpInfoList
					},
					onRemoved = function ()
						uv0:updateIconList()
					end
				}))
			end, SFX_PANEL)
		end
	end)
	slot0.iconUIItemList:align(#slot1)
end

slot1 = 0.3

slot0.openPanel = function(slot0)
	slot0:cleanManagedTween(true)
	Canvas.ForceUpdateCanvases()

	slot1 = 400
	slot2 = slot0.panelTF.sizeDelta.x
	slot5 = slot0:managedTween(LeanTween.value, nil, go(slot0.panelTF), System.Action_float(function (slot0)
		setAnchoredPosition(uv0.panelTF, {
			x = slot0
		})
	end), 400, 0, uv0)

	slot5:setOnComplete(System.Action(function ()
		setAnchoredPosition(uv0.panelTF, {
			x = 0
		})
	end))
end

slot0.closePanel = function(slot0)
	slot0:cleanManagedTween(true)

	slot1 = 400
	slot2 = slot0.panelTF.sizeDelta.x
	slot5 = slot0:managedTween(LeanTween.value, nil, go(slot0.panelTF), System.Action_float(function (slot0)
		setAnchoredPosition(uv0.panelTF, {
			x = slot0
		})
	end), 0, 400, uv0)

	slot5:setOnComplete(System.Action(function ()
		setAnchoredPosition(uv0.panelTF, {
			x = 0
		})
		uv0:Destroy()
	end))
end

slot0.sortDataList = function(slot0, slot1)
	table.sort(slot1, function (slot0, slot1)
		if (slot0.isUpLevel and slot0.isMaxLevel and 9999 or 0) + slot0.progress > (slot1.isUpLevel and slot1.isMaxLevel and 9999 or 0) + slot1.progress then
			return true
		elseif slot6 == slot7 then
			return slot0.shipID < slot1.shipID
		elseif slot6 < slot7 then
			return false
		end
	end)

	return slot1
end

return slot0

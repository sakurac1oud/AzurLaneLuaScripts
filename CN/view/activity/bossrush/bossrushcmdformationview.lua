slot0 = class("LevelCMDFormationView", import("view.base.BaseUI"))

slot0.getUIName = function(slot0)
	return "LevelCommanderView"
end

slot0.init = function(slot0)
	slot0.descFrameTF = slot0:findTF("frame")
	slot0.descPos1 = slot0:findTF("commander1/frame/info", slot0.descFrameTF)
	slot0.descPos2 = slot0:findTF("commander2/frame/info", slot0.descFrameTF)
	slot0.skillTFPos1 = slot0:findTF("commander1/skill_info", slot0.descFrameTF)
	slot0.skillTFPos2 = slot0:findTF("commander2/skill_info", slot0.descFrameTF)
	slot0.abilitysTF = UIItemList.New(slot0:findTF("atttr_panel/abilitys/mask/content", slot0.descFrameTF), slot0:findTF("atttr_panel/abilitys/mask/content/attr", slot0.descFrameTF))
	slot0.talentsTF = UIItemList.New(slot0:findTF("atttr_panel/talents/mask/content", slot0.descFrameTF), slot0:findTF("atttr_panel/talents/mask/content/attr", slot0.descFrameTF))
	slot0.abilityArr = slot0:findTF("frame/atttr_panel/abilitys/arr")
	slot0.talentsArr = slot0:findTF("frame/atttr_panel/talents/arr")
	slot0.restAllBtn = slot0:findTF("rest_all", slot0.descFrameTF)
	slot0.quickBtn = slot0:findTF("quick_btn", slot0.descFrameTF)
	slot0.recordPanel = slot0:findTF("record_panel")
	slot2 = slot0.recordPanel
	slot2 = slot0.recordPanel
	slot0.recordCommanders = {
		slot2:Find("current/commanders/commander1/frame/info"),
		slot2:Find("current/commanders/commander2/frame/info")
	}
	slot2 = slot0.recordPanel
	slot2 = slot0.recordPanel
	slot0.reocrdSkills = {
		slot2:Find("current/commanders/commander1/skill_info"),
		slot2:Find("current/commanders/commander2/skill_info")
	}
	slot2 = slot0.recordPanel
	slot3 = slot0.recordPanel
	slot0.recordList = UIItemList.New(slot2:Find("record/content"), slot3:Find("record/content/commanders"))

	onButton(slot0, slot0.restAllBtn, function ()
		uv0.callback({
			type = LevelUIConst.COMMANDER_OP_REST_ALL
		})
	end, SFX_PANEL)
	onButton(slot0, slot0.quickBtn, function ()
		uv0:OpenRecordPanel()
	end, SFX_PANEL)

	slot3 = slot0.recordPanel

	onButton(slot0, slot3:Find("back"), function ()
		uv0:CloseRecordPanel()
	end, SFX_PANEL)

	slot3 = slot0._tf

	onButton(slot0, slot3:Find("bg"), function ()
		uv0:onBackPressed()
	end, SFX_PANEL)
end

slot0.didEnter = function(slot0)
	pg.UIMgr.GetInstance():BlurPanel(slot0._tf)
end

slot0.willExit = function(slot0)
	pg.UIMgr.GetInstance():UnblurPanel(slot0._tf)
end

slot0.setCallback = function(slot0, slot1)
	slot0.callback = slot1
end

slot0.updateFleet = function(slot0, slot1)
	slot0.fleet = slot1

	slot0:updateDesc()
	slot0:updateRecordFleet()
end

slot0.setCommanderPrefabs = function(slot0, slot1)
	slot0.prefabFleets = slot1

	slot0:updateRecordPanel()
end

slot0.updateRecordFleet = function(slot0)
	slot1 = slot0.fleet:getCommanders()

	for slot5, slot6 in ipairs(slot0.recordCommanders) do
		slot7 = slot1[slot5]

		slot0:updateCommander(slot6, slot5, slot7)
		slot0:updateSkillTF(slot7, slot0.reocrdSkills[slot5])
	end
end

slot0.updateRecordPanel = function(slot0)
	slot1 = slot0.fleet:getCommanders()

	slot0.recordList:make(function (slot0, slot1, slot2)
		if slot0 == UIItemList.EventUpdate then
			uv0:UpdatePrefabFleet(uv0.prefabFleets[slot1 + 1], slot2, uv1)
		end
	end)
	slot0.recordList:align(#slot0.prefabFleets)
end

slot0.UpdatePrefabFleet = function(slot0, slot1, slot2, slot3)
	slot4 = slot2:Find("fleet_name")

	onInputEndEdit(slot0, slot4, function ()
		uv1.callback({
			type = LevelUIConst.COMMANDER_OP_RENAME,
			id = uv2.id,
			str = getInputText(uv0),
			onFailed = function ()
				setInputText(uv0, uv1)
			end
		})
	end)
	setInputText(slot4, slot1:getName())
	onButton(slot0, slot2:Find("use_btn"), function ()
		uv0.callback({
			type = LevelUIConst.COMMANDER_OP_USE_PREFAB,
			id = uv1.id
		})
		uv0:CloseRecordPanel()
	end, SFX_PANEL)
	onButton(slot0, slot2:Find("record_btn"), function ()
		uv0.callback({
			type = LevelUIConst.COMMANDER_OP_RECORD_PREFAB,
			id = uv1.id
		})
	end, SFX_PANEL)

	slot7 = {
		slot2:Find("commander1/skill_info"),
		slot2:Find("commander2/skill_info")
	}

	for slot11, slot12 in ipairs({
		slot2:Find("commander1/frame/info"),
		slot2:Find("commander2/frame/info")
	}) do
		slot13 = slot1:getCommanderByPos(slot11)

		slot0:updateCommander(slot12, slot11, slot13)
		slot0:updateSkillTF(slot13, slot7[slot11])
	end
end

slot0.updateDesc = function(slot0)
	slot1 = slot0.fleet:getCommanders()

	for slot5 = 1, CommanderConst.MAX_FORMATION_POS do
		slot6 = slot1[slot5]

		slot0:updateCommander(slot0["descPos" .. slot5], slot5, slot6, true)
		slot0:updateSkillTF(slot6, slot0["skillTFPos" .. slot5])
	end

	slot0:updateAdditions()
end

slot0.updateAdditions = function(slot0)
	slot1 = slot0.fleet
	slot2 = _.values(slot1:getCommandersTalentDesc())
	slot3, slot4 = slot1:getCommandersAddition()

	slot0.abilitysTF:make(function (slot0, slot1, slot2)
		if slot0 == UIItemList.EventUpdate then
			slot3 = uv0[slot1 + 1]

			setText(slot2:Find("name"), AttributeType.Type2Name(slot3.attrName))
			setText(slot2:Find("Text"), string.format("%0.3f", slot3.value) .. "%")
			GetImageSpriteFromAtlasAsync("attricon", slot3.attrName, slot2:Find("icon"), false)
			setImageAlpha(slot2:Find("bg"), slot1 % 2)
		end
	end)
	slot0.abilitysTF:align(#slot3)
	setActive(slot0.abilityArr, #slot3 > 4)
	slot0.talentsTF:make(function (slot0, slot1, slot2)
		if slot0 == UIItemList.EventUpdate then
			slot3 = uv0[slot1 + 1]

			setScrollText(findTF(slot2, "name_mask/name"), slot3.name)
			setText(slot2:Find("Text"), slot3.value .. (slot3.type == CommanderConst.TALENT_ADDITION_RATIO and "%" or ""))
			setImageAlpha(slot2:Find("bg"), slot1 % 2)
		end
	end)
	slot0.talentsTF:align(#slot2)
	setActive(slot0.talentsArr, #slot2 > 4)
end

slot0.updateSkillTF = function(slot0, slot1, slot2)
	setActive(slot2, slot1)

	if slot1 then
		slot3 = slot1:getSkills()[1]

		GetImageSpriteFromAtlasAsync("CommanderSkillIcon/" .. slot3:getConfig("icon"), "", slot2:Find("icon"))
		setText(slot2:Find("level"), "Lv." .. slot3:getLevel())
		onButton(slot0, slot2, function ()
			uv0.callback({
				type = LevelUIConst.COMMANDER_OP_SHOW_SKILL,
				skill = uv1
			})
		end, SFX_PANEL)

		return
	end

	removeOnButton(slot2)
end

slot0.updateCommander = function(slot0, slot1, slot2, slot3, slot4)
	slot5 = slot1:Find("add")
	slot6 = slot1:Find("info")

	if slot3 then
		slot8 = slot1:Find("info/frame")

		GetImageSpriteFromAtlasAsync("CommanderHrz/" .. slot3:getPainting(), "", slot1:Find("info/mask/icon"))

		if slot1:Find("info/name") then
			setText(slot9, slot3:getName())
		end

		setImageSprite(slot8, GetSpriteFromAtlas("weaponframes", "commander_" .. Commander.rarity2Frame(slot3:getRarity())))
	end

	if slot4 then
		onButton(slot0, slot6, function ()
			uv0.callback({
				type = LevelUIConst.COMMANDER_OP_ADD,
				pos = uv1
			})
		end, SFX_PANEL)
		onButton(slot0, slot5, function ()
			uv0.callback({
				type = LevelUIConst.COMMANDER_OP_ADD,
				pos = uv1
			})
		end, SFX_PANEL)
	end

	setActive(slot5, not slot3)
	setActive(slot6, slot3)
end

slot0.OpenRecordPanel = function(slot0)
	setActive(slot0.descFrameTF, false)
	setActive(slot0.recordPanel, true)
end

slot0.CloseRecordPanel = function(slot0)
	setActive(slot0.descFrameTF, true)
	setActive(slot0.recordPanel, false)
end

return slot0

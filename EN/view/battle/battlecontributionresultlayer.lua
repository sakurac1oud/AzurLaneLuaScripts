slot0 = class("BattleContributionResultLayer", import(".BattleActivityBossResultLayer"))

slot0.setActId = function(slot0, slot1)
	slot0._actID = slot1
	slot0._resourceID = pg.activity_event_worldboss[pg.activity_template[slot1].config_id].damage_resource
end

slot0.didEnter = function(slot0)
	uv0.super.didEnter(slot0)
	slot0:setPoint()
end

slot0.setPoint = function(slot0)
	slot0._contributionPoint = 0

	for slot4, slot5 in ipairs(slot0.contextData.drops) do
		if slot5.configId == slot0._resourceID then
			slot0._contributionPoint = slot5.count
		end
	end
end

slot0.setGradeLabel = function(slot0)
	setActive(slot0:findTF("grade/Xyz/bg13"), false)
	LoadImageSpriteAsync("battlescore/grade_label_clear", slot0:findTF("grade/Xyz/bg14"), false)
end

slot0.rankAnimaFinish = function(slot0)
	setActive(slot0._conditionBGNormal, false)
	setActive(slot0._conditionBGContribute, true)
	slot0:setCondition(i18n("battle_result_total_damage"), slot0.contextData.statistics.specificDamage, COLOR_BLUE)
	slot0:setCondition(i18n("battle_result_contribution"), slot0._contributionPoint, COLOR_YELLOW)
	table.insert(slot0._delayLeanList, LeanTween.delayedCall(1, System.Action(function ()
		uv0._stateFlag = uv1.STATE_REPORTED

		SetActive(uv0:findTF("jieuan01/tips", uv0._bg), true)
	end)).id)

	slot0._stateFlag = uv0.STATE_REPORT
end

slot0.setCondition = function(slot0, slot1, slot2, slot3)
	slot4 = cloneTplTo(slot0._conditionContributeTpl, slot0._conditionContainer)

	setActive(slot4, false)

	slot5 = nil
	slot4:Find("text"):GetComponent(typeof(Text)).text = setColorStr(slot1, "#FFFFFFFF")
	slot4:Find("value"):GetComponent(typeof(Text)).text = setColorStr(slot2, slot3)

	if slot0._conditionContainer.childCount - 1 > 0 then
		table.insert(slot0._delayLeanList, LeanTween.delayedCall(uv0.CONDITIONS_FREQUENCE * slot8, System.Action(function ()
			setActive(uv0, true)
		end)).id)
	else
		setActive(slot4, true)
	end
end

return slot0

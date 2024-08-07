slot0 = class("MetaSkillDetailBoxMediator", import("...base.ContextMediator"))

slot0.register = function(slot0)
end

slot0.listNotificationInterests = function(slot0)
	return {
		GAME.TACTICS_META_UNLOCK_SKILL_DONE,
		GAME.TACTICS_META_SWITCH_SKILL_DONE
	}
end

slot0.handleNotification = function(slot0, slot1)
	slot3 = slot1:getBody()

	if slot1:getName() == GAME.TACTICS_META_UNLOCK_SKILL_DONE or slot2 == GAME.TACTICS_META_SWITCH_SKILL_DONE then
		if slot2 == GAME.TACTICS_META_SWITCH_SKILL_DONE and slot0.contextData.expInfoList and #slot4 > 0 then
			slot5 = slot0.contextData.metaShipID
			slot6 = nil

			for slot10, slot11 in ipairs(slot4) do
				if slot11.shipID == slot5 and slot11.isUpLevel and slot11.isMaxLevel then
					slot6 = slot10
				end
			end

			if slot6 then
				slot4[slot6].isUpLevel = false
				slot4[slot6].isMaxLevel = false
			end
		end

		slot0.viewComponent:updateSkillList()
	end
end

return slot0

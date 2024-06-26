slot0 = class("ChatMsg", import(".BaseVO"))

slot0.Ctor = function(slot0, slot1, slot2)
	assert(slot1, "type should be clarified.")

	slot0.type = slot1
	slot0.timestamp = slot2.timestamp
	slot0.content = slot2.content
	slot0.emojiId = slot2.emojiId
	slot0.player = slot2.player

	if slot0.player then
		slot0.playerId = slot0.player.id
	end

	slot0.unread = slot2.unread or 0
	slot0.id = slot2.id
	slot0.args = slot2.args
	slot0.uniqueId = slot2.uniqueId
	slot0.needBanRichText = true

	if slot2.richText then
		slot0.needBanRichText = false
	end
end

slot0.IsPublic = function(slot0)
	return slot0.id ~= nil
end

slot0.IsWorldBossNotify = function(slot0)
	return slot0.id == 4
end

slot0.IsSame = function(slot0, slot1)
	return slot0.uniqueId == slot1
end

return slot0

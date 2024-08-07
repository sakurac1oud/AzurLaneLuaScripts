slot0 = class("WorldBossGetOtherFormationCommand", pm.SimpleCommand)

slot0.execute = function(slot0, slot1)
	slot2 = slot1:getBody()
	slot5 = pg.ConnectionMgr.GetInstance()

	slot5:Send(34519, {
		boss_id = slot2.bossId,
		userId = slot2.userId
	}, 34520, function (slot0)
		if slot0.result == 0 then
			slot1 = {}

			for slot5, slot6 in ipairs(slot0.ship_list) do
				table.insert(slot1, MetaBossRankShip.New(slot6))
			end

			uv0:sendNotification(GAME.WORLD_BOSS_GET_FORMATION_DONE, {
				ships = slot1
			})
		else
			pg.TipsMgr.GetInstance():ShowTips(ERROR_MESSAGE[slot0.result] .. slot0.result)
		end
	end)
end

return slot0

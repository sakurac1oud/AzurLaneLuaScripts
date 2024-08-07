slot0 = class("FinishBluePrintCommand", pm.SimpleCommand)

slot0.execute = function(slot0, slot1)
	if not getProxy(TechnologyProxy):getBluePrintById(slot1:getBody().id) then
		return
	end

	if not slot5:isFinished() then
		return
	end

	slot6 = pg.ConnectionMgr.GetInstance()

	slot6:Send(63202, {
		blueprint_id = slot3
	}, 63203, function (slot0)
		if slot0.result == 0 then
			slot1 = Ship.New(slot0.ship)

			getProxy(BayProxy):addShip(slot1)
			uv0:unlock(slot1.id)
			uv1:updateBluePrint(uv0)
			uv2:sendNotification(GAME.FINISH_SHIP_BLUEPRINT_DONE, {
				ship = slot1
			})

			slot3 = {
				[6.0] = true,
				[5.0] = true
			}

			if PLATFORM_CODE == PLATFORM_JP and slot3[uv0:getConfig("blueprint_version")] then
				pg.TrackerMgr.GetInstance():Tracking(TRACKING_SHIPWORKS_COMPLETE, slot1.configId)
			end
		else
			pg.TipsMgr.GetInstance():ShowTips(i18n("printblue_build_erro") .. slot0.result)
		end
	end)
end

return slot0

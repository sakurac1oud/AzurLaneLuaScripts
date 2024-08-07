ys = ys or {}
slot0 = ys
slot0.Battle.BattleGuideWave = class("BattleGuideWave", slot0.Battle.BattleWaveInfo)
slot0.Battle.BattleGuideWave.__name = "BattleGuideWave"
slot1 = slot0.Battle.BattleGuideWave

slot1.Ctor = function(slot0)
	uv0.super.Ctor(slot0)
end

slot1.SetWaveData = function(slot0, slot1)
	uv0.super.SetWaveData(slot0, slot1)

	slot0._guideType = slot0._param.type or 0
	slot0._guideStep = slot0._param.id
	slot0._event = slot0._param.event
end

slot1.DoWave = function(slot0)
	uv0.super.DoWave(slot0)

	if not pg.NewGuideMgr.ENABLE_GUIDE then
		slot0:doPass()
	elseif slot0._guideType == 1 and pg.SeriesGuideMgr.GetInstance():isEnd() then
		slot0:doFail()
	else
		pg.NewGuideMgr.GetInstance():Play(slot0._guideStep, {
			slot0._event
		}, function ()
			uv0:doPass()
		end)
	end
end

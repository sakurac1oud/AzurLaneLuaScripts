ys = ys or {}
slot0 = ys
slot0.Battle.BattleSpawnWave = class("BattleSpawnWave", slot0.Battle.BattleWaveInfo)
slot0.Battle.BattleSpawnWave.__name = "BattleSpawnWave"
slot1 = slot0.Battle.BattleSpawnWave
slot1.ASYNC_TIME_GAP = 0.03

slot1.Ctor = function(slot0)
	uv0.super.Ctor(slot0)

	slot0._spawnUnitList = {}
	slot0._monsterList = {}
	slot0._reinforceKillCount = 0
	slot0._reinforceTotalKillCount = 0
	slot0._airStrikeTimerList = {}
	slot0._spawnTimerList = {}
	slot0._reinforceSpawnTimerList = {}
end

slot1.SetWaveData = function(slot0, slot1)
	uv0.super.SetWaveData(slot0, slot1)

	slot0._sapwnData = slot1.spawn or {}
	slot0._airStrike = slot1.airFighter or {}
	slot0._reinforce = slot1.reinforcement or {}
	slot0._reinforceCount = #slot0._reinforce
	slot0._spawnCount = #slot0._sapwnData
	slot0._reinforceDuration = slot0._reinforce.reinforceDuration or 0
	slot0._reinforeceExpire = false
	slot0._round = slot0._param.round
end

slot1.IsBossWave = function(slot0)
	slot1 = false

	for slot6, slot7 in ipairs(slot0._sapwnData) do
		if slot7.bossData then
			slot1 = true
		end
	end

	return slot1
end

slot1.DoWave = function(slot0)
	uv0.super.DoWave(slot0)

	if slot0._round then
		slot1 = false

		if uv1.Battle.BattleDataProxy.GetInstance():GetInitData().ChallengeInfo then
			slot3 = slot2:GetInitData().ChallengeInfo:getRound()

			if slot0._round.less and slot3 < slot0._round.less then
				slot1 = true
			end

			if slot0._round.more and slot0._round.more < slot3 then
				slot1 = true
			end

			if slot0._round.equal and table.contains(slot0._round.equal, slot3) then
				slot1 = true
			end
		end

		if not slot1 then
			slot0:doPass()

			return
		end
	end

	for slot4, slot5 in ipairs(slot0._airStrike) do
		if slot5.delay + slot4 * uv0.ASYNC_TIME_GAP <= 0 then
			slot0:doAirStrike(slot5)
		else
			slot0:airStrikeTimer(slot5, slot6)
		end
	end

	slot1 = 0

	for slot5, slot6 in ipairs(slot0._sapwnData) do
		if slot6.bossData then
			slot1 = slot1 + 1
		end
	end

	slot2 = 0
	slot3 = 0

	for slot7, slot8 in ipairs(slot0._sapwnData) do
		if math.random() <= (slot8.chance or 1) then
			if slot8.bossData and slot1 > 1 then
				slot8.bossData.bossCount = slot2 + 1
			end

			if slot8.delay + slot3 <= 0 then
				slot0:doSpawn(slot8)
			else
				slot0:spawnTimer(slot8, slot10, slot0._spawnTimerList)
			end
		else
			slot0._spawnCount = slot0._spawnCount - 1
		end

		slot3 = slot3 + uv0.ASYNC_TIME_GAP
	end

	if slot0._reinforce then
		slot0:doReinforce(slot3)
	end

	if slot0._spawnCount == 0 and slot0._reinforceDuration == 0 then
		slot0:doPass()
	end

	if slot0._reinforceDuration ~= 0 then
		slot0:reinforceDurationTimer(slot0._reinforceDuration)
	end

	uv1.Battle.BattleState.GenerateVertifyData(1)

	slot4, slot5 = uv1.Battle.BattleState.Vertify()

	if not slot4 then
		uv1.Battle.BattleState.GetInstance():GetCommandByName(uv1.Battle.BattleSingleDungeonCommand.__name):SetVertifyFail(100 + slot5)
	end
end

slot1.AddMonster = function(slot0, slot1)
	if slot1:GetWaveIndex() ~= slot0._index then
		return
	end

	slot0._monsterList[slot1:GetUniqueID()] = slot1
end

slot1.RemoveMonster = function(slot0, slot1)
	slot0:onWaveUnitDie(slot1)
end

slot1.doSpawn = function(slot0, slot1)
	slot2 = uv0.Battle.BattleConst.UnitType.ENEMY_UNIT

	if slot1.bossData then
		slot2 = uv0.Battle.BattleConst.UnitType.BOSS_UNIT
	end

	slot0._spawnFunc(slot1, slot0._index, slot2)
end

slot1.spawnTimer = function(slot0, slot1, slot2, slot3)
	slot4 = nil
	slot3[pg.TimeMgr.GetInstance():AddBattleTimer("", 1, slot2, function ()
		uv0[uv1] = nil

		uv2:doSpawn(uv3)
		pg.TimeMgr.GetInstance():RemoveBattleTimer(uv1)
	end, true)] = true
end

slot1.doAirStrike = function(slot0, slot1)
	slot0._airFunc(slot1)
end

slot1.airStrikeTimer = function(slot0, slot1, slot2)
	slot3 = nil
	slot0._airStrikeTimerList[pg.TimeMgr.GetInstance():AddBattleTimer("", 1, slot2, function ()
		uv0._airStrikeTimerList[uv1] = nil

		uv0:doAirStrike(uv2)
		pg.TimeMgr.GetInstance():RemoveBattleTimer(uv1)
	end, true)] = true
end

slot1.doReinforce = function(slot0, slot1)
	slot0._reinforceKillCount = 0

	if slot0._reinforeceExpire then
		return
	end

	slot1 = slot1 or 0

	for slot5, slot6 in ipairs(slot0._reinforce) do
		slot6.reinforce = true

		if slot6.delay + slot1 <= 0 then
			slot0:doSpawn(slot6)
		else
			slot0:spawnTimer(slot6, slot7, slot0._reinforceSpawnTimerList)
		end

		slot1 = slot1 + uv0.ASYNC_TIME_GAP
	end
end

slot1.reinforceTimer = function(slot0, slot1)
	slot0:clearReinforceTimer()

	slot0._reinforceTimer = pg.TimeMgr.GetInstance():AddBattleTimer("", 1, slot1, function ()
		uv0:doReinforce()
		uv0:clearReinforceTimer()
	end, true)
end

slot1.clearReinforceTimer = function(slot0)
	pg.TimeMgr.GetInstance():RemoveBattleTimer(slot0._reinforceTimer)

	slot0._reinforceTimer = nil
end

slot1.reinforceDurationTimer = function(slot0, slot1)
	slot0._reinforceDurationTimer = pg.TimeMgr.GetInstance():AddBattleTimer("", 1, slot1, function ()
		pg.TimeMgr.GetInstance():RemoveBattleTimer(uv0._reinforceDurationTimer)

		uv0._reinforeceExpire = true
		uv0._reinforceDuration = nil

		uv0:clearReinforceTimer()
		uv0.clearTimerList(uv0._reinforceSpawnTimerList)

		if uv0._spawnCount == 0 then
			uv0:doPass()
		end
	end, true)
end

slot1.clearReinforceDurationTimer = function(slot0)
	pg.TimeMgr.GetInstance():RemoveBattleTimer(slot0._reinforceDurationTimer)

	slot0._reinforceDurationTimer = nil
end

slot1.onWaveUnitDie = function(slot0, slot1)
	if slot0._monsterList[slot1] == nil then
		return
	end

	slot3 = nil

	if slot2:IsReinforcement() then
		slot0._reinforceKillCount = slot0._reinforceKillCount + 1
		slot0._reinforceTotalKillCount = slot0._reinforceTotalKillCount + 1

		if slot0._reinforceCount ~= 0 and slot0._reinforceCount == slot0._reinforceKillCount then
			slot3 = true
		end
	end

	slot4 = function(slot0)
		if uv0 and slot0 then
			if slot0 == 0 then
				uv1:doReinforce()
			else
				uv1:reinforceTimer(slot0)
			end

			uv0 = false
		end
	end

	slot5 = 0
	slot6 = 0

	for slot10, slot11 in pairs(slot0._monsterList) do
		if slot11:IsAlive() == false then
			if not slot11:IsReinforcement() then
				slot5 = slot5 + 1
			end
		else
			slot6 = slot6 + 1

			slot4(slot11:GetReinforceCastTime())
		end
	end

	if slot0._reinforceDuration ~= 0 and not slot0._reinforeceExpire then
		slot4(0)
	end

	if slot6 == 0 and slot0._spawnCount <= slot5 and slot0._reinforceCount <= slot0._reinforceTotalKillCount and (slot0._reinforceDuration == 0 or slot0._reinforeceExpire) then
		slot0:doPass()
	end
end

slot1.doPass = function(slot0)
	slot0.clearTimerList(slot0._spawnTimerList)
	slot0.clearTimerList(slot0._reinforceSpawnTimerList)
	slot0:clearReinforceTimer()
	slot0:clearReinforceDurationTimer()
	uv0.Battle.BattleDataProxy.GetInstance():KillWaveSummonMonster(slot0._index)
	uv1.super.doPass(slot0)
end

slot1.clearTimerList = function(slot0)
	for slot4, slot5 in pairs(slot0) do
		pg.TimeMgr.GetInstance():RemoveBattleTimer(slot4)
	end
end

slot1.Dispose = function(slot0)
	slot0.clearTimerList(slot0._airStrikeTimerList)

	slot0._airStrikeTimerList = nil

	slot0.clearTimerList(slot0._spawnTimerList)

	slot0._spawnTimerList = nil

	slot0.clearTimerList(slot0._reinforceSpawnTimerList)

	slot0._reinforceSpawnTimerList = nil

	slot0:clearReinforceTimer()
	slot0:clearReinforceDurationTimer()
	uv0.super.Dispose(slot0)
end

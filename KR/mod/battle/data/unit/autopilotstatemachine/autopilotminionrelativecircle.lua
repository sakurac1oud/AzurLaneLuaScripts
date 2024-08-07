ys = ys or {}
slot0 = ys
slot1 = Vector3.up
slot2 = class("AutoPilotMinionRelativeCircle", slot0.Battle.IPilot)
slot0.Battle.AutoPilotMinionRelativeCircle = slot2
slot2.__name = "AutoPilotMinionRelativeCircle"

slot2.Ctor = function(slot0, ...)
	uv0.super.Ctor(slot0, ...)
end

slot2.SetParameter = function(slot0, slot1, slot2)
	uv0.super.SetParameter(slot0, slot1, slot2)

	slot0._radius = slot1.radius

	if slot1.antiClockWise == true then
		slot0.GetDirection = uv0._antiClockWise
	else
		slot0.GetDirection = uv0._clockWise
	end

	slot0._nextBuffID = slot1.buffID
end

slot2._clockWise = function(slot0, slot1)
	if slot0:IsExpired() then
		slot0:Finish()

		return Vector3.zero
	end

	if not slot0._pilot:GetTarget():GetMaster():IsAlive() then
		if slot0._nextBuffID then
			slot0._pilot:GetTarget():AddBuff(uv0.Battle.BattleBuffUnit.New(slot0._nextBuffID))
		end

		return Vector3.zero
	end

	if slot0._radius < (slot1 - slot2:GetPosition()).magnitude then
		return (slot3 - slot1).normalized
	else
		slot5 = (slot3 - slot1).normalized

		return Vector3(-slot5.z, 0, slot5.x)
	end
end

slot2._antiClockWise = function(slot0, slot1)
	if slot0._duration > 0 and slot0._duration < pg.TimeMgr.GetInstance():GetCombatTime() - slot0._startTime then
		slot0:Finish()

		return Vector3.zero
	end

	if not slot0._pilot:GetTarget():GetMaster():IsAlive() then
		if slot0._nextBuffID then
			slot0._pilot:GetTarget():AddBuff(uv0.Battle.BattleBuffUnit.New(slot0._nextBuffID))
		end

		return Vector3.zero
	end

	if slot0._radius < (slot1 - slot2:GetPosition()).magnitude then
		return (slot3 - slot1).normalized
	else
		slot5 = (slot3 - slot1).normalized

		return Vector3(slot5.z, 0, -slot5.x)
	end
end

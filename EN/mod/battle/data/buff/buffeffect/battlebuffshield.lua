ys = ys or {}
slot0 = ys
slot0.Battle.BattleBuffShield = class("BattleBuffShield", slot0.Battle.BattleBuffEffect)
slot0.Battle.BattleBuffShield.__name = "BattleBuffShield"
slot1 = slot0.Battle.BattleBuffShield

slot1.Ctor = function(slot0, slot1)
	uv0.super.Ctor(slot0, slot1)
end

slot1.GetEffectAttachData = function(slot0)
	return slot0._shield
end

slot1.SetArgs = function(slot0, slot1, slot2)
	slot0._number = slot0._tempData.arg_list.number or 0
	slot0._maxHPRatio = slot3.maxHPRatio or 0
	slot0._casterMaxHPRatio = slot3.casterMaxHPRatio or 0
	slot0._shield = slot0:CalcNumber(slot1)
end

slot1.onStack = function(slot0, slot1, slot2)
	slot0._shield = slot0:CalcNumber(slot1)
end

slot1.onTakeDamage = function(slot0, slot1, slot2, slot3)
	if slot0:damageCheck(slot3) then
		slot0._shield = slot0._shield - slot3.damage

		if slot0._shield > 0 then
			slot3.damage = 0
		else
			slot3.damage = -slot0._shield

			slot2:SetToCancel()
		end
	end
end

slot1.CalcNumber = function(slot0, slot1)
	slot2, slot3 = slot1:GetHP()
	slot4, slot5 = slot0._caster:GetHP()

	return math.max(0, math.floor(slot3 * slot0._maxHPRatio + slot0._number + slot0._casterMaxHPRatio * slot5))
end

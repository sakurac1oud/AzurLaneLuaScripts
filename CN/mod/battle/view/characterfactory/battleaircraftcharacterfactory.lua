ys = ys or {}
slot0 = ys
slot1 = slot0.Battle.BattleConfig
slot2 = singletonClass("BattleAircraftCharacterFactory", slot0.Battle.BattleCharacterFactory)
slot0.Battle.BattleAircraftCharacterFactory = slot2
slot2.__name = "BattleAircraftCharacterFactory"
slot2.BOMB_FX_NAME = "feijibaozha"

slot2.Ctor = function(slot0)
	uv0.super.Ctor(slot0)
end

slot2.MakeCharacter = function(slot0)
	return uv0.Battle.BattleAircraftCharacter.New()
end

slot2.MakeModel = function(slot0, slot1)
	slot2 = function(slot0)
		uv0:AddModel(slot0)
		uv0:InitWeapon()
		uv0:CameraOrthogonal(uv2.Battle.BattleCameraUtil.GetInstance():GetCamera())
		uv1:GetSceneMediator():AddAirCraftCharacter(uv0)
		uv1:MakeUIComponentContainer(uv0)
		uv1:MakeFXContainer(uv0)
		uv1:MakeShadow(uv0)

		if uv0:GetUnitData():GetIFF() == uv3.FOE_CODE then
			uv1:MakePopNumPool(uv0)
			uv1:MakeBloodBar(uv0)
		end
	end

	slot0:GetCharacterPool():InstAirCharacter(slot1:GetModleID(), function (slot0)
		uv0(slot0)
	end)
end

slot2.MakeBloodBar = function(slot0, slot1)
	slot2 = nil

	slot1:AddHPBar((not slot1:GetUnitData():IsPlayerAircraft() or slot0:GetHPBarPool():GetHPBar(uv0.Battle.BattleHPBarManager.HP_BAR_FRIENDLY)) and slot0:GetHPBarPool():GetHPBar(uv0.Battle.BattleHPBarManager.HP_BAR_FOE))
	slot1:UpdateHPBarPosition()
end

slot2.SetHPBarWidth = function(slot0, slot1, slot2)
	slot3 = 40
	slot4 = slot1.transform
	slot4.sizeDelta = Vector2(slot3, slot4.rect.height)
	slot6.sizeDelta = Vector2(slot3 - slot2 or 0, slot4:Find("blood").transform.rect.height)
end

slot2.MakeShadow = function(slot0, slot1)
	slot1:AddShadow()
	slot1:UpdateShadow()
end

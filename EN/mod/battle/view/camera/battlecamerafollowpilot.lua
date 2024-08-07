ys = ys or {}
slot0 = ys
slot1 = slot0.Battle.BattleConfig
slot2 = slot0.Battle.BattleVariable
slot0.Battle.BattleCameraFollowPilot = class("BattleCameraFollowPilot")
slot0.Battle.BattleCameraFollowPilot.__name = "BattleCameraFollowPilot"
slot3 = slot0.Battle.BattleCameraFollowPilot

slot3.Ctor = function(slot0)
	slot0.point = Vector3.zero
end

slot3.SetFleetVO = function(slot0, slot1)
	slot0._fleetMotion = slot1:GetMotion()
end

slot3.SetGoldenRation = function(slot0, slot1)
	slot0._cameraGoldenOffset = slot1
end

slot3.GetCameraPos = function(slot0)
	slot1 = slot0.point:Copy(slot0._fleetMotion:GetPos())
	slot1.x = slot1.x + slot0._cameraGoldenOffset
	slot1.y = slot1.y + uv0.CameraNormalHeight
	slot1.z = slot1.z - slot1.y / uv0._camera_radian_x_tan

	return slot1
end

slot3.Dispose = function(slot0)
	slot0._fleetMotion = nil
end

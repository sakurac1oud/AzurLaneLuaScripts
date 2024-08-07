slot0 = class("WorldBuff", import("...BaseEntity"))
slot0.Fields = {
	config = "table",
	floor = "number",
	time = "number",
	id = "number",
	round = "number",
	step = "number"
}
slot0.TrapCompassInterference = 1
slot0.TrapVortex = 2
slot0.TrapFire = 3
slot0.TrapDisturbance = 4
slot0.TrapCripple = 5
slot0.TrapFrozen = 6

slot0.GetTemplate = function(slot0)
	assert(pg.world_SLGbuff_data[slot0], "without this buff " .. slot0)

	return pg.world_SLGbuff_data[slot0]
end

slot0.Setup = function(slot0, slot1)
	slot0.id = slot1.id
	slot0.config = uv0.GetTemplate(slot0.id)

	assert(slot0.config, "world_SLGbuff_data not exist: " .. slot0.id)

	slot0.floor = math.min(slot1.floor, slot0:GetMaxFloor())
	slot0.time = slot1.time ~= 0 and slot1.time or nil
	slot0.round = slot1.round ~= 0 and slot1.round or nil
	slot0.step = slot1.step ~= 0 and slot1.step or nil
end

slot0.IsValid = function(slot0)
	return not slot0.time or pg.TimeMgr.GetInstance():GetServerTime() < slot0.time
end

slot0.CheckValid = function(slot0)
	if not slot0:IsValid() then
		slot0.floor = 0
	end
end

slot0.GetMaxFloor = function(slot0)
	return slot0.config.buff_maxfloor
end

slot0.GetTrapType = function(slot0)
	return slot0.config.trap_type
end

slot0.GetTrapParams = function(slot0)
	return slot0.config.trap_parameter
end

slot0.GetLost = function(slot0)
	if slot0.step and slot0.round then
		return math.min(slot0.step, slot0.round)
	else
		return slot0.step or slot0.round
	end
end

slot0.AddFloor = function(slot0, slot1)
	slot0:CheckValid()

	slot0.floor = math.clamp(slot0.floor + slot1, 0, 999)
end

slot0.GetFloor = function(slot0)
	slot0:CheckValid()

	return math.min(slot0.floor, slot0:GetMaxFloor())
end

return slot0

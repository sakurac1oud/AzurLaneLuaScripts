slot0 = class("WorldMap", import("...BaseEntity"))
slot0.Fields = {
	config = "table",
	valid = "boolean",
	gid = "number",
	cells = "table",
	active = "boolean",
	findex = "number",
	top = "number",
	phaseDisplayList = "table",
	salvageAutoResult = "boolean",
	isPressing = "boolean",
	visionFlag = "boolean",
	isLoss = "boolean",
	bottom = "number",
	centerCellFOV = "table",
	typeAttachments = "table",
	isCost = "boolean",
	theme = "table",
	fleets = "table",
	left = "number",
	factionBuffs = "table",
	ports = "table",
	id = "number",
	clearFlag = "boolean",
	right = "number"
}
slot0.Listeners = {
	onUpdateAttachmentExist = "OnUpdateAttachmentExist"
}
slot0.EventUpdateActive = "WorldMap.EventUpdateActive"
slot0.EventUpdateFIndex = "WorldMap.EventUpdateFIndex"
slot0.EventUpdateMapBuff = "WorldMap.EventUpdateMapBuff"
slot0.EventUpdateFleetFOV = "WorldMap.EventUpdateFleetFOV"
slot0.EventUpdateMoveSpeed = "WorldMap.EventUpdateMoveSpeed"

slot0.DebugPrint = function(slot0)
	return string.format("地图 [%s] [id: %s] [gid: %s] [危险度: %s] [是否压制：%s]", slot0.config.name, slot0.id, tostring(slot0.gid), slot0:GetDanger(), slot0.isPressing)
end

slot0.Build = function(slot0)
	slot0.cells = {}
	slot0.ports = {}
	slot0.phaseDisplayList = {}
end

slot0.Dispose = function(slot0)
	slot0:UnbindFleets()
	slot0:DisposeTheme()
	slot0:DisposeGrid()
	slot0:DisposePort()
	slot0:Clear()
end

slot0.Setup = function(slot0, slot1)
	slot0.id = slot1

	assert(pg.world_chapter_random[slot0.id], "world_chapter_random not exist: " .. tostring(slot0.id))

	slot0.config = setmetatable({}, {
		__index = function (slot0, slot1)
			return uv0:GetConfig(slot1)
		end
	})
end

slot0.GetName = function(slot0, slot1)
	if (slot1 and World.ReplacementMapType(slot1, slot0)) == "sairen_chapter" or slot2 == "teasure_chapter" then
		return slot1:GetBaseMap():GetName() .. "-" .. slot0.config.name
	else
		return slot0.config.name
	end
end

slot0.GetConfig = function(slot0, slot1)
	slot3 = pg.world_chapter_template[slot0.gid]
	slot4 = pg.world_chapter_random[slot0.id] and slot2[slot1] or slot3 and slot3[slot1] or nil

	assert(slot4 ~= nil, "can not find " .. slot1 .. " in WorldMap " .. slot0.id)

	return slot4
end

slot0.FactionSelf = 0
slot0.FactionEnemy = 1

slot0.UpdateGridId = function(slot0, slot1)
	slot0.gid = slot1
	slot6 = slot0.gid
	slot5 = tostring(slot6)

	assert(pg.world_chapter_template[slot0.gid], "world_chapter_template not exist: " .. slot5)
	slot0:DisposeTheme()
	slot0:DisposeGrid()
	slot0:DisposePort()

	slot0.factionBuffs = {
		[uv0.FactionSelf] = {},
		[uv0.FactionEnemy] = {}
	}

	for slot5, slot6 in ipairs(slot0.config.world_chapter_buff) do
		slot7, slot8, slot9 = unpack(slot6)

		slot0:AddBuff(slot7, slot8, slot9)
	end

	slot0:SetupTheme()
	slot0:SetupGrid()
	slot0:SetupPort()
end

slot0.SetupTheme = function(slot0)
	slot1 = WPool:Get(WorldMapTheme)

	slot1:Setup(slot0.config.theme)

	slot0.theme = slot1
end

slot0.DisposeTheme = function(slot0)
	if slot0.theme then
		WPool:Return(slot0.theme)

		slot0.theme = nil
	end
end

slot0.SetupGrid = function(slot0, slot1)
	_.each(slot0.config.grids, function (slot0)
		WPool:Get(WorldMapCell):Setup(slot0)

		if uv0:AlwaysInFOV() then
			slot1.infov = bit.bor(slot1.infov, WorldConst.FOVMapSight)
		end

		uv0.cells[WorldMapCell.GetName(slot1.row, slot1.column)] = slot1

		if not uv1 then
			slot1:AddListener(WorldMapCell.EventAddAttachment, uv0.onUpdateAttachmentExist)
			slot1:AddListener(WorldMapCell.EventRemoveAttachment, uv0.onUpdateAttachmentExist)
		end
	end)

	slot0.right = 0
	slot0.left = 999999
	slot0.bottom = 0
	slot0.top = 999999

	for slot5 = 0, WorldConst.MaxRow do
		slot6, slot7 = nil

		for slot11 = 0, WorldConst.MaxColumn do
			if slot0:GetCell(slot5, slot11) then
				if not slot6 then
					slot6 = slot11
					slot12.dir = bit.bor(slot12.dir, bit.lshift(1, WorldConst.DirLeft))
				end

				slot7 = slot11
			end
		end

		if slot7 then
			slot8 = slot0:GetCell(slot5, slot7)
			slot8.dir = bit.bor(slot8.dir, bit.lshift(1, WorldConst.DirRight))
		end

		if slot6 then
			slot0.left = math.min(slot0.left, slot6)
		end

		if slot7 then
			slot0.right = math.max(slot0.right, slot7)
		end
	end

	for slot5 = 0, WorldConst.MaxColumn do
		slot6, slot7 = nil

		for slot11 = 0, WorldConst.MaxRow do
			if slot0:GetCell(slot11, slot5) then
				if not slot6 then
					slot6 = slot11
					slot12.dir = bit.bor(slot12.dir, bit.lshift(1, WorldConst.DirUp))
				end

				slot7 = slot11
			end
		end

		if slot7 then
			slot8 = slot0:GetCell(slot7, slot5)
			slot8.dir = bit.bor(slot8.dir, bit.lshift(1, WorldConst.DirDown))
		end

		if slot6 then
			slot0.top = math.min(slot0.top, slot6)
		end

		if slot7 then
			slot0.bottom = math.max(slot0.bottom, slot7)
		end
	end
end

slot0.DisposeGrid = function(slot0, slot1)
	if not slot1 then
		for slot5, slot6 in pairs(slot0.cells) do
			slot6:RemoveListener(WorldMapCell.EventAddAttachment, slot0.onUpdateAttachmentExist)
			slot6:RemoveListener(WorldMapCell.EventRemoveAttachment, slot0.onUpdateAttachmentExist)
		end
	end

	WPool:ReturnMap(slot0.cells)

	slot0.cells = {}
	slot0.typeAttachments = {}
	slot0.left = nil
	slot0.top = nil
	slot0.right = nil
	slot0.bottom = nil
end

slot0.SetupPort = function(slot0)
	if #slot0.config.port_id > 0 then
		WPool:Get(WorldMapPort):Setup(slot0.config.port_id[1])

		slot2, slot3 = unpack(slot0.config.port_id[2])

		for slot7 = slot2 - 1, slot2 + 1 do
			for slot11 = slot3 - 1, slot3 + 1 do
				if (slot7 ~= slot2 or slot11 ~= slot3) and slot0:GetCell(slot7, slot11) then
					slot12:AddAttachment(WorldMapAttachment.MakeFakePort(slot7, slot11, slot1.id))
				end
			end
		end

		table.insert(slot0.ports, slot1)
	end
end

slot0.DisposePort = function(slot0)
	WPool:ReturnArray(slot0.ports)

	slot0.ports = {}
end

slot0.IsValid = function(slot0)
	return slot0.valid
end

slot0.SetValid = function(slot0, slot1)
	slot0.valid = slot1

	if slot1 and slot0.fleets then
		for slot5, slot6 in ipairs(slot0:GetNormalFleets()) do
			slot0.centerCellFOV = {
				row = slot6.row,
				column = slot6.column
			}

			if slot0:GetFleetTerrain(slot6) ~= WorldMapCell.TerrainFog then
				WorldConst.RangeCheck(slot6, slot0:GetFOVRange(slot6), function (slot0, slot1)
					if uv0.cells[WorldMapCell.GetName(slot0, slot1)] then
						slot2:ChangeInLight(true)
					end
				end)
			elseif slot0.findex == slot5 then
				slot7 = {}
				slot12 = slot6

				WorldConst.RangeCheck(slot6, slot0:GetFOVRange(slot12), function (slot0, slot1)
					if uv0.cells[WorldMapCell.GetName(slot0, slot1)] then
						uv1[slot2] = true
					end
				end)

				slot8 = slot0:IsFleetTerrainSairenFog(slot6)

				for slot12, slot13 in pairs(slot0.cells) do
					slot13:UpdateFog(true, slot7[slot12], slot8)
				end
			end
		end
	end
end

slot0.IsMapOpen = function(slot0)
	return slot0:GetOpenProgress() <= nowWorld():GetProgress()
end

slot0.GetOpenProgress = function(slot0)
	return nowWorld():GetRealm() > 0 and slot0.config.open_stage[slot1] or 9999
end

slot0.RemoveAllCellDiscovered = function(slot0)
	for slot4, slot5 in pairs(slot0.cells) do
		slot5:UpdateDiscovered(false)
	end
end

slot0.GetDanger = function(slot0)
	return slot0.config.hazard_level
end

slot0.BindFleets = function(slot0, slot1)
	slot0.fleets = slot1
end

slot0.UnbindFleets = function(slot0)
	slot0.fleets = nil
end

slot0.GetFleets = function(slot0)
	return _.rest(slot0.fleets, 1)
end

slot0.GetFleet = function(slot0, slot1)
	return slot1 and _.detect(slot0.fleets, function (slot0)
		return slot0.id == uv0
	end) or slot0.fleets[slot0.findex]
end

slot0.GetNormalFleets = function(slot0)
	return _.filter(slot0.fleets, function (slot0)
		return slot0:GetFleetType() == FleetType.Normal
	end)
end

slot0.GetSubmarineFleet = function(slot0)
	return _.detect(slot0.fleets, function (slot0)
		return slot0:GetFleetType() == FleetType.Submarine
	end)
end

slot0.FindFleet = function(slot0, slot1, slot2)
	return _.detect(slot0.fleets, function (slot0)
		return slot0.row == uv0 and slot0.column == uv1
	end)
end

slot0.CheckFleetMovable = function(slot0, slot1)
	return slot0:GetCell(slot1.row, slot1.column):CanLeave()
end

slot0.GetFleetTerrain = function(slot0, slot1)
	return slot0:GetCell(slot1.row, slot1.column):GetTerrain()
end

slot0.IsFleetTerrainSairenFog = function(slot0, slot1)
	return slot0:GetCell(slot1.row, slot1.column):IsTerrainSairenFog()
end

slot0.RemoveFleetsCarries = function(slot0, slot1)
	_.each(slot1 or slot0.fleets, function (slot0)
		slot0:RemoveAllCarries()
	end)
end

slot0.UpdateFleetIndex = function(slot0, slot1)
	if slot0.findex ~= slot1 then
		slot0:CheckSelectFleetUpdateFog(function ()
			uv0.findex = uv1
		end)
		slot0:DispatchEvent(uv0.EventUpdateFIndex)
	end
end

slot0.UpdateActive = function(slot0, slot1)
	slot2 = nowWorld():GetAtlas()

	if slot0.active ~= slot1 then
		slot0.active = slot1

		if slot1 then
			slot0:SetValid(false)
			slot2:SetActiveMap(slot0)

			slot0.isCost = true

			slot2:UpdateCostMap(slot0.id, slot0.isCost)
		elseif slot0:NeedClear() then
			slot0:RemoveAllCellDiscovered()

			slot0.clearFlag = false
			slot0.isCost = false

			slot2:UpdateCostMap(slot0.id, slot0.isCost)
		end

		slot0:DispatchEvent(uv0.EventUpdateActive)
	end
end

slot0.InPort = function(slot0, slot1, slot2)
	if not slot0:GetPort() or slot2 and slot3.config.port_camp ~= slot2 then
		return false
	end

	if slot0:GetFleet(slot1):GetFleetType() == FleetType.Submarine then
		return slot3.id
	elseif slot0:GetCell(slot4.row, slot4.column):GetAliveAttachment() and slot6.type == WorldMapAttachment.TypePort then
		return slot6.id
	end

	return false
end

slot0.canExit = function(slot0)
	return slot0.gid and pg.world_chapter_template_reset[slot0.gid] ~= nil
end

slot0.CheckAttachmentTransport = function(slot0)
	slot1 = WorldConst.GetTransportBlockEvent()

	for slot6, slot7 in ipairs(slot0:FindAttachments(WorldMapAttachment.TypeEvent)) do
		if slot7:IsAlive() and slot1[slot7.id] then
			return "block"
		end
	end

	slot3 = WorldConst.GetTransportStoryEvent()

	for slot7, slot8 in ipairs(slot2) do
		if slot8:IsAlive() and slot3[slot8.id] then
			return "story"
		end
	end
end

slot0.GetPort = function(slot0, slot1)
	return slot1 and _.detect(slot0.ports, function (slot0)
		return slot0.id == uv0
	end) or slot0.ports[1]
end

slot0.GetCell = function(slot0, slot1, slot2)
	return slot0.cells[WorldMapCell.GetName(slot1, slot2)]
end

slot0.CalcTransportPos = function(slot0, slot1, slot2)
	slot3 = calcPositionAngle(slot1.config.area_pos[1] - slot2.config.area_pos[1], slot1.config.area_pos[2] - slot2.config.area_pos[2])
	slot4 = false

	if not slot0.gid then
		slot0.gid = slot0.config.template_id[1][1]

		slot0:SetupGrid(true)
	end

	slot5 = {
		row = (slot0.top + slot0.bottom) / 2,
		column = (slot0.left + slot0.right) / 2
	}
	slot6 = nil
	slot7 = 4294967295.0
	slot8 = nil

	for slot12 = slot0.left + 1, slot0.right - 1 do
		if math.abs(calcPositionAngle(slot12 - slot5.column, slot5.row - slot0.top) - slot3) < slot7 then
			slot6 = {
				row = slot0.top,
				column = slot12
			}
			slot7 = slot8
		end

		if math.abs(calcPositionAngle(slot12 - slot5.column, slot5.row - slot0.bottom) - slot3) < slot7 then
			slot6 = {
				row = slot0.bottom,
				column = slot12
			}
			slot7 = slot8
		end
	end

	for slot12 = slot0.top + 1, slot0.bottom - 1 do
		if math.abs(calcPositionAngle(slot0.left - slot5.column, slot5.row - slot12) - slot3) < slot7 then
			slot6 = {
				row = slot12,
				column = slot0.left
			}
			slot7 = slot8
		end

		if math.abs(calcPositionAngle(slot0.right - slot5.column, slot5.row - slot12) - slot3) < slot7 then
			slot6 = {
				row = slot12,
				column = slot0.right
			}
			slot7 = slot8
		end
	end

	if slot4 then
		slot0:DisposeGrid(slot4)

		slot0.gid = nil
	end

	return slot6
end

slot0.AnyFleetInEdge = function(slot0)
	return slot0.active and _.any(slot0:GetNormalFleets(), function (slot0)
		return slot0.row == uv0.top or slot0.row == uv0.bottom or slot0.column == uv0.left or slot0.column == uv0.right
	end)
end

slot0.CheckInteractive = function(slot0, slot1)
	for slot6, slot7 in ipairs(slot0:FindAttachments(WorldMapAttachment.TypeEvent)) do
		if slot7:RemainOpEffect() then
			return slot7
		end
	end

	for slot6, slot7 in ipairs(slot2) do
		if slot7:IsAlive() and slot7:GetEventEffect() and slot8.autoactivate > 0 then
			return slot7
		end
	end

	slot1 = slot1 or slot0:GetFleet()

	if slot0:GetCell(slot1.row, slot1.column).discovered then
		for slot8, slot9 in ipairs(slot3:GetAliveAttachments()) do
			if WorldMapAttachment.IsInteractiveType(slot9.type) and not slot9:IsTriggered() then
				if slot9:IsSign() then
					return nil
				elseif slot9.type == WorldMapAttachment.TypeEvent then
					if slot9:GetEventEffect() and (slot10.effective_num <= 1 or slot10.effective_num <= slot0:CountEventEffectKeys(slot10)) then
						return slot9
					end
				else
					return slot9
				end
			end
		end
	end
end

slot0.CheckDiscover = function(slot0)
	slot1 = {}
	slot2 = slot0.theme

	for slot6, slot7 in pairs(slot0.cells) do
		if not slot7.discovered and slot7:GetInFOV() then
			table.insert(slot1, {
				row = slot7.row,
				column = slot7.column
			})
		end
	end

	return slot1
end

slot0.CheckDisplay = function(slot0, slot1)
	if slot1.type == WorldMapAttachment.TypeTrap then
		return true
	end

	return slot0:GetCell(slot1.row, slot1.column):GetDisplayAttachment() == slot1
end

slot0.GetFOVRange = function(slot0, slot1, slot2, slot3)
	return slot0:GetCell(slot2 or slot1.row, slot3 or slot1.column):GetTerrain() == WorldMapCell.TerrainFog and slot4.terrainStrong or slot1:GetFOVRange()
end

slot0.UpdateVisionFlag = function(slot0, slot1)
	slot0.visionFlag = slot1

	slot0:OrderAROpenFOV(slot0.visionFlag)
end

slot0.UpdatePressingMark = function(slot0, slot1)
	if tobool(slot0.isPressing) ~= tobool(slot1) then
		slot0.isPressing = slot1

		nowWorld():GetTaskProxy():doUpdateTaskByMap(slot0.id, slot1)
	end
end

slot0.ExistAny = function(slot0, slot1, slot2)
	return slot0:GetCell(slot1, slot2):GetAliveAttachment() or slot0:ExistFleet(slot1, slot2)
end

slot0.ExistFleet = function(slot0, slot1, slot2)
	return tobool(slot0:FindFleet(slot1, slot2))
end

slot0.CalcFleetSpeed = function(slot0, slot1)
	slot2 = slot1:GetSpeed()

	if slot0:GetCell(slot1.row, slot1.column):GetTerrain() == WorldMapCell.TerrainFog then
		slot2 = math.min(slot2, 1)
	end

	return slot2
end

slot0.FindPath = function(slot0, slot1, slot2, slot3)
	if not uv0.pathFinder then
		uv0.pathFinder = PathFinding.New({}, WorldConst.MaxRow, WorldConst.MaxColumn)
	end

	slot5 = {}

	for slot9 = 0, WorldConst.MaxRow - 1 do
		if not slot5[slot9] then
			slot5[slot9] = {}
		end

		for slot13 = 0, WorldConst.MaxColumn - 1 do
			slot14 = PathFinding.PrioForbidden

			if slot0:IsWalkable(slot9, slot13) and (not slot3 or slot0:GetCell(slot9, slot13):GetInFOV()) then
				slot14 = PathFinding.PrioNormal

				if slot9 == slot2.row and slot13 == slot2.column then
					if not slot0:IsStayPoint(slot9, slot13) then
						slot14 = PathFinding.PrioObstacle
					end
				elseif slot0:IsObstacle(slot9, slot13) then
					slot14 = PathFinding.PrioObstacle
				end
			end

			slot5[slot9][slot13] = slot14
		end
	end

	slot4.cells = slot5

	return slot4:Find(slot1, slot2)
end

slot0.FindAIPath = function(slot0, slot1, slot2)
	if not uv0.pathFinder then
		uv0.pathFinder = PathFinding.New({}, WorldConst.MaxRow, WorldConst.MaxColumn)
	end

	slot4 = {}

	for slot8 = 0, WorldConst.MaxRow - 1 do
		if not slot4[slot8] then
			slot4[slot8] = {}
		end

		for slot12 = 0, WorldConst.MaxColumn - 1 do
			slot13 = PathFinding.PrioForbidden

			if slot0:IsWalkable(slot8, slot12) then
				slot13 = PathFinding.PrioNormal

				if (slot8 ~= slot2.row or slot12 ~= slot2.column) and slot0:ExistFleet(slot8, slot12) then
					slot13 = PathFinding.PrioObstacle
				end
			end

			slot4[slot8][slot12] = slot13
		end
	end

	slot3.cells = slot4

	return slot3:Find(slot1, slot2)
end

slot0.GetMoveRange = function(slot0, slot1)
	slot2 = slot1.row
	slot3 = slot1.column
	slot4 = slot0:CalcFleetSpeed(slot1)
	slot5 = {}

	for slot9 = 0, WorldConst.MaxRow - 1 do
		if not slot5[slot9] then
			slot5[slot9] = {}
		end

		for slot13 = 0, WorldConst.MaxColumn - 1 do
			slot5[slot9][slot13] = slot0:IsWalkable(slot9, slot13)
		end
	end

	slot6 = {}
	slot7 = {
		{
			step = 0,
			row = slot2,
			column = slot3
		}
	}
	slot5[slot2][slot3] = false

	while #slot7 > 0 do
		table.insert(slot6, table.remove(slot7, 1))
		_.each({
			{
				row = 1,
				column = 0
			},
			{
				row = -1,
				column = 0
			},
			{
				row = 0,
				column = 1
			},
			{
				row = 0,
				column = -1
			}
		}, function (slot0)
			slot0.row = uv0.row + slot0.row
			slot0.column = uv0.column + slot0.column
			slot0.step = uv0.step + 1

			if slot0.row >= 0 and slot0.row < WorldConst.MaxRow and slot0.column >= 0 and slot0.column < WorldConst.MaxColumn and slot0.step <= uv1 and uv2[slot0.row][slot0.column] then
				uv2[slot0.row][slot0.column] = false

				if uv3:IsObstacle(slot0.row, slot0.column) then
					table.insert(uv4, slot0)
				else
					table.insert(uv5, slot0)
				end
			end
		end)
	end

	return _.filter(slot6, function (slot0)
		return uv0:IsStayPoint(slot0.row, slot0.column)
	end)
end

slot0.BuildLongMoveInfos = function(slot0)
	slot1 = {}

	for slot5 = 0, WorldConst.MaxRow - 1 do
		slot1[slot5] = slot1[slot5] or {}

		for slot9 = 0, WorldConst.MaxColumn - 1 do
			if slot0:IsWalkable(slot5, slot9) and slot0:GetCell(slot5, slot9):GetInFOV() then
				slot1[slot5][slot9] = {
					isFinish = false,
					isMark = false,
					row = slot5,
					column = slot9,
					dp = {},
					last = {},
					isStayPoint = slot0:IsStayPoint(slot5, slot9),
					isObstacle = slot0:IsObstacle(slot5, slot9)
				}
			end
		end
	end

	return slot1
end

slot0.GetLongMoveRange = function(slot0, slot1)
	slot4 = slot0:CalcFleetSpeed(slot1)
	slot6 = {}
	slot7 = {}
	slot8 = {
		{
			row = 1,
			column = 0
		},
		{
			row = -1,
			column = 0
		},
		{
			row = 0,
			column = 1
		},
		{
			row = 0,
			column = -1
		}
	}

	slot9 = function(slot0, slot1, slot2)
		return slot0 < slot1 or slot2 < slot0
	end

	slot11 = slot0:BuildLongMoveInfos()[slot1.row][slot1.column]
	slot11.dp[0] = 0
	slot11.isMark = true

	(function (slot0)
		if not slot0 then
			return
		end

		slot0.isFinish = true

		table.insert(uv0, slot0)

		if slot0.isStayPoint then
			slot1 = slot0.dp

			for slot5 = 1, uv1 do
				if slot1[slot5] and (not slot1[0] or slot1[0] > slot1[slot5] + 1) then
					slot1[0] = slot1[slot5] + 1
					slot0.last[0] = slot0.last[slot5]
				end
			end
		end
	end)(slot11)

	while slot11 do
		_.each(slot8, function (slot0)
			if uv0(uv1.row + slot0.row, 0, WorldConst.MaxRow - 1) or uv0(uv1.column + slot0.column, 0, WorldConst.MaxColumn - 1) then
				return
			end

			if uv2[uv1.row + slot0.row][uv1.column + slot0.column] and not slot1.isFinish then
				for slot5 = 1, uv3 do
					if uv1.dp[slot5 - 1] and (not slot1.dp[slot5] or uv1.dp[slot5 - 1] < slot1.dp[slot5]) then
						slot1.dp[slot5] = uv1.dp[slot5 - 1]
						slot1.last[slot5] = {
							uv1,
							slot5 - 1
						}

						if not slot1.isMark then
							slot1.isMark = true

							table.insert(uv4, slot1)
						end
					end
				end
			end
		end)

		repeat
			slot11 = table.remove(slot7, 1)

			slot10(slot11)
		until slot11 and not slot11.isObstacle
	end

	slot12 = {}

	for slot16, slot17 in ipairs(slot6) do
		if slot17.dp[0] and slot17.dp[0] > 0 then
			table.insert(slot12, {
				row = slot17.row,
				column = slot17.column,
				stay = slot17.dp[0]
			})
		end
	end

	return slot12, slot5
end

slot0.IsWalkable = function(slot0, slot1, slot2)
	return slot0:GetCell(slot1, slot2) and slot3.walkable and (slot3:CanLeave() or slot0:IsStayPoint(slot1, slot2))
end

slot0.IsStayPoint = function(slot0, slot1, slot2)
	return slot0:GetCell(slot1, slot2):CanArrive() and not slot0:ExistFleet(slot1, slot2)
end

slot0.IsObstacle = function(slot0, slot1, slot2)
	return not slot0:GetCell(slot1, slot2):CanPass()
end

slot0.IsSign = function(slot0, slot1, slot2)
	return slot0:GetCell(slot1, slot2):IsSign()
end

slot0.FindNearestBlankPoint = function(slot0, slot1, slot2)
	slot3 = {}

	for slot7 = 0, WorldConst.MaxRow - 1 do
		if not slot3[slot7] then
			slot3[slot7] = {}
		end

		for slot11 = 0, WorldConst.MaxColumn - 1 do
			slot3[slot7][slot11] = slot0:IsWalkable(slot7, slot11)
		end
	end

	slot4 = {
		row = slot1,
		column = slot2
	}
	slot5 = {}

	while #slot4 > 0 do
		table.insert(slot5, table.remove(slot4, 1))
		_.each({
			{
				row = 1,
				column = 0
			},
			{
				row = -1,
				column = 0
			},
			{
				row = 0,
				column = 1
			},
			{
				row = 0,
				column = -1
			}
		}, function (slot0)
			slot0.row = uv0.row + slot0.row
			slot0.column = uv0.column + slot0.column

			if slot0.row >= 0 and slot0.row < WorldConst.MaxRow and slot0.column >= 0 and slot0.column < WorldConst.MaxColumn and not (_.any(uv1, function (slot0)
				return slot0.row == uv0.row and slot0.column == uv0.column
			end) or _.any(uv2, function (slot0)
				return slot0.row == uv0.row and slot0.column == uv0.column
			end)) and uv3[slot0.row][slot0.column] then
				if uv4:ExistAny(slot0.row, slot0.column) then
					table.insert(uv1, slot0)
				else
					return slot0
				end
			end
		end)
	end
end

slot0.WriteBack = function(slot0, slot1, slot2)
	slot4 = {}
	slot8 = true

	for slot8, slot9 in ipairs(slot0:GetFleet():GetShips(slot8)) do
		table.insert(slot4, slot9)
	end

	if slot2.statistics.submarineAid then
		slot5 = slot0:GetSubmarineFleet()

		assert(slot5, "submarine fleet not exist.")

		for slot10, slot11 in ipairs(slot5:GetTeamShips(TeamType.Submarine, true)) do
			table.insert(slot4, slot11)
		end

		slot5:UseAmmo()
		slot5:AddDefeatEnemies(slot1)
	end

	slot3:AddDefeatEnemies(slot1)
	_.each(slot4, function (slot0)
		if uv0.statistics[slot0.id] then
			slot0.hpRant = slot1.bp
		end

		if slot0.hpRant <= 0 then
			slot0:Rebirth()
		end
	end)
	assert(slot0:GetCell(slot3.row, slot3.column):GetStageEnemy())

	if slot1 then
		slot6:UpdateFlag(1)

		slot0.phaseDisplayList = table.mergeArray(slot0.phaseDisplayList, slot6:SetHP(0))

		_.each(slot0:GetFleets(), function (slot0)
			uv0 = uv0 or slot0:HasDamageLevel()

			slot0:ClearDamageLevel()
		end)

		if false then
			table.insert(slot0.phaseDisplayList, 1, {
				story = "W1500",
				hp = slot6:GetMaxHP()
			})
		end
	else
		slot0.isLoss = true

		slot3:IncDamageLevel(slot6)
		slot6:UpdateData(slot6.data - 1)

		slot0.phaseDisplayList = table.mergeArray(slot0.phaseDisplayList, slot6:SetHP(slot2.statistics._maxBossHP))

		if nowWorld().isAutoFight then
			slot7:TriggerAutoFight(false)
			pg.TipsMgr.GetInstance():ShowTips(i18n("autofight_tip_bigworld_dead"))
		end
	end

	_.each(slot2.hpDropInfo, function (slot0)
		slot1 = #uv0.phaseDisplayList + 1

		for slot5, slot6 in ipairs(uv0.phaseDisplayList) do
			if slot6.hp < slot0.hp then
				slot1 = slot5

				break
			end
		end

		uv0:AddPhaseDisplay({
			hp = slot0.hp,
			drops = PlayerConst.addTranDrop(slot0.drop_info)
		}, slot1)
	end)
end

slot0.AddPhaseDisplay = function(slot0, slot1, slot2)
	if slot2 then
		table.insert(slot0.phaseDisplayList, slot2, slot1)
	else
		table.insert(slot0.phaseDisplayList, slot1)
	end
end

slot0.FindAttachments = function(slot0, slot1, slot2)
	slot3 = {}

	for slot7, slot8 in pairs(slot0.typeAttachments) do
		if not slot1 or slot1 == slot7 then
			for slot12, slot13 in ipairs(slot8) do
				if not slot2 or slot13.id == slot2 then
					table.insert(slot3, slot13)
				end
			end
		end
	end

	return slot3
end

slot0.FindEnemys = function(slot0)
	slot1 = {}

	for slot5, slot6 in pairs(slot0.typeAttachments) do
		if WorldMapAttachment.IsEnemyType(slot5) then
			slot1 = table.mergeArray(slot1, slot6)
		end
	end

	return slot1
end

slot0.GetMapMinMax = function(slot0)
	slot1 = Vector2(WorldConst.MaxColumn, WorldConst.MaxRow)
	slot2 = Vector2(-WorldConst.MaxColumn, -WorldConst.MaxRow)

	for slot6 = 0, WorldConst.MaxRow - 1 do
		for slot10 = 0, WorldConst.MaxColumn - 1 do
			if slot0:GetCell(slot6, slot10) then
				slot1.x = math.min(slot1.x, slot10)
				slot1.y = math.min(slot1.y, slot6)
				slot2.x = math.max(slot2.x, slot10)
				slot2.y = math.max(slot2.y, slot6)
			end
		end
	end

	return slot1.y, slot2.y, slot1.x, slot2.x
end

slot0.GetMapSize = function(slot0)
	slot1, slot2, slot3, slot4 = slot0:GetMapMinMax()

	return slot2 - slot1 + 1, slot4 - slot3 + 1
end

slot0.CountEventEffectKeys = function(slot0, slot1)
	slot2 = 0

	for slot6, slot7 in ipairs(slot0:GetNormalFleets()) do
		if slot0:GetCell(slot7.row, slot7.column):GetAliveAttachment() and slot9.type == WorldMapAttachment.TypeEvent and slot9:GetEventEffect() == slot1 then
			slot2 = slot2 + 1
		end
	end

	return slot2
end

slot0.EventEffectOpenFOV = function(slot0, slot1)
	assert(slot1.effect_type == WorldMapAttachment.EffectEventFOV)

	slot2, slot3 = unpack(slot1.effect_paramater)
	slot3 = slot3 >= 0 and slot3 or math.abs(slot3) - 1

	_.each(slot0:FindAttachments(WorldMapAttachment.TypeEvent, slot2), function (slot0)
		uv0.centerCellFOV = {
			row = slot0.row,
			column = slot0.column
		}
		slot4 = WorldConst.MaxRow - 1

		for slot4 = math.max(slot0.row - uv1, 0), math.min(slot0.row + uv1, slot4) do
			slot8 = WorldConst.MaxColumn - 1

			for slot8 = math.max(slot0.column - uv1, 0), math.min(slot0.column + uv1, slot8) do
				if WorldConst.InFOVRange(slot0.row, slot0.column, slot4, slot8, uv1) and uv0:GetCell(slot4, slot8) then
					if uv2 then
						slot9:UpdateInFov(bit.bor(slot9.infov, WorldConst.FOVEventEffect))
					else
						slot9:UpdateInFov(bit.band(slot9.infov, WorldConst.Flag16Max - WorldConst.FOVEventEffect))
					end
				end
			end
		end
	end)
end

slot0.OrderAROpenFOV = function(slot0, slot1)
	if slot1 then
		slot2 = slot0:GetFleet()
		slot0.centerCellFOV = {
			row = slot2.row,
			column = slot2.column
		}
	end

	for slot5, slot6 in pairs(slot0.cells) do
		if slot1 then
			slot6:UpdateInFov(bit.bor(slot6.infov, WorldConst.FOVEventEffect))
		else
			slot6:UpdateInFov(bit.band(slot6.infov, WorldConst.Flag16Max - WorldConst.FOVEventEffect))
		end
	end
end

slot0.GetMaxDistanceCell = function(slot0, slot1, slot2)
	slot3 = nil
	slot4 = 0

	for slot9, slot10 in pairs({
		{
			row = slot0.top,
			column = slot0.left
		},
		{
			row = slot0.bottom,
			column = slot0.left
		},
		{
			row = slot0.top,
			column = slot0.right
		},
		{
			row = slot0.bottom,
			column = slot0.right
		}
	}) do
		if slot4 < (slot10.row - slot1) * (slot10.row - slot1) + (slot10.column - slot2) * (slot10.column - slot2) then
			slot3 = slot10
			slot4 = slot11
		end
	end

	return slot3, math.sqrt(slot4)
end

slot0.GetCellsInFOV = function(slot0)
	slot1 = {}

	for slot5, slot6 in pairs(slot0.cells) do
		if slot6:GetInFOV() then
			table.insert(slot1, slot6)
		end
	end

	return slot1
end

slot0.AlwaysInFOV = function(slot0)
	return slot0.config.map_sight == 1
end

slot0.GetEventTipWord = function(slot0)
	slot2 = ""
	slot3 = 0

	for slot7, slot8 in ipairs(slot0:FindAttachments(WorldMapAttachment.TypeEvent)) do
		slot9 = pg.world_event_desc[slot8.id]

		if slot8:IsAlive() and slot9 and slot3 < slot9.hint_pri then
			slot3 = slot9.hint_pri
			slot2 = slot9.hint
		end
	end

	return slot2, slot3
end

slot0.GetEventPoisonRate = function(slot0)
	slot2 = 0

	for slot6, slot7 in ipairs(slot0:FindAttachments(WorldMapAttachment.TypeEvent)) do
		if slot7:IsAlive() then
			slot2 = slot2 + slot7.config.infection_value
		end
	end

	return slot2, slot0.config.is_sairen
end

slot0.GetPressingLevel = function(slot0)
	return slot0.config.complete_effect
end

slot0.CheckMapPressing = function(slot0)
	return slot0:GetPressingLevel() > 0 and not slot0.isPressing and slot0:GetEventPoisonRate() == 0
end

slot0.CheckMapPressingDisplay = function(slot0)
	return slot0:GetPressingLevel() > 1
end

slot0.UpdateClearFlag = function(slot0, slot1)
	slot0.clearFlag = tobool(slot1)
end

slot0.IsUnlockFleetMode = function(slot0)
	if slot0.config.move_switch == 1 then
		return true
	elseif slot0.config.move_switch == 0 then
		return false
	else
		assert(false, "config error")
	end
end

slot0.CheckFleetSalvage = function(slot0, slot1)
	if underscore.detect(slot0:GetFleets(), function (slot0)
		return slot0:IsCatSalvage() and (uv0 or slot0:IsSalvageFinish() or uv1.salvageAutoResult or slot0.catSalvageFrom ~= uv1.id)
	end) then
		return slot2.id
	else
		slot0.salvageAutoResult = false
	end
end

slot0.GetChapterAuraBuffs = function(slot0)
	slot1 = {}

	for slot5, slot6 in ipairs(slot0.fleets) do
		for slot11, slot12 in ipairs(slot6:getMapAura()) do
			table.insert(slot1, slot12)
		end
	end

	return slot1
end

slot0.GetChapterAidBuffs = function(slot0)
	slot1 = {}

	for slot5, slot6 in ipairs(slot0.fleets) do
		if slot5 ~= slot0.findex then
			for slot11, slot12 in pairs(slot6:getMapAid()) do
				slot1[slot11] = slot12
			end
		end
	end

	return slot1
end

slot0.getFleetBattleBuffs = function(slot0, slot1, slot2)
	slot3 = {}

	underscore.each(slot1:GetBuffList(), function (slot0)
		if slot0.config.lua_id ~= 0 then
			table.insert(uv0, slot1)
		end
	end)

	slot4 = {}

	if not slot2 or not slot1:IsCatSalvage() then
		slot4 = slot0:BuildBattleBuffList(slot1)
	end

	return slot3, slot4
end

slot0.BuildBattleBuffList = function(slot0, slot1)
	slot2 = {}
	slot3, slot4 = slot0:triggerSkill(slot1, FleetSkill.TypeBattleBuff)

	if slot3 and #slot3 > 0 then
		slot5 = {}

		for slot9, slot10 in ipairs(slot3) do
			slot5[slot12] = slot5[slot1:findCommanderBySkillId(slot4[slot9].id)] or {}

			table.insert(slot5[slot12], slot10)
		end

		for slot9, slot10 in pairs(slot5) do
			table.insert(slot2, {
				slot9,
				slot10
			})
		end
	end

	for slot9, slot10 in pairs(slot1:getCommanders()) do
		for slot15, slot16 in ipairs(slot10:getTalents()) do
			if #slot16:getBuffsAddition() > 0 then
				slot18 = nil

				for slot22, slot23 in ipairs(slot2) do
					if slot23[1] == slot10 then
						slot18 = slot23[2]

						break
					end
				end

				if not slot18 then
					table.insert(slot2, {
						slot10,
						{}
					})
				end

				for slot22, slot23 in ipairs(slot17) do
					table.insert(slot18, slot23)
				end
			end
		end
	end

	return slot2
end

slot0.CanLongMove = function(slot0, slot1)
	return slot0:IsUnlockFleetMode() and not slot1:HasTrapBuff() and slot0:GetFleetTerrain(slot1) ~= WorldMapCell.TerrainFog
end

slot0.triggerSkill = function(slot0, slot1, slot2)
	slot3 = _.filter(slot1:findSkills(slot2), function (slot0)
		return _.any(slot0:GetTriggers(), function (slot0)
			return slot0[1] == FleetSkill.TriggerInSubTeam and slot0[2] == 1
		end) == (uv0:GetFleetType() == FleetType.Submarine) and _.all(slot0:GetTriggers(), function (slot0)
			return uv0:triggerCheck(uv1, uv2, slot0)
		end)
	end)

	return _.reduce(slot3, nil, function (slot0, slot1)
		slot3 = slot1:GetArgs()

		if slot1:GetType() == FleetSkill.TypeMoveSpeed or slot2 == FleetSkill.TypeHuntingLv or slot2 == FleetSkill.TypeTorpedoPowerUp then
			return (slot0 or 0) + slot3[1]
		elseif slot2 == FleetSkill.TypeAmbushDodge or slot2 == FleetSkill.TypeAirStrikeDodge then
			return math.max(slot0 or 0, slot3[1])
		elseif slot2 == FleetSkill.TypeAttack or slot2 == FleetSkill.TypeStrategy then
			slot0 = slot0 or {}

			table.insert(slot0, slot3)

			return slot0
		elseif slot2 == FleetSkill.TypeBattleBuff then
			slot0 = slot0 or {}

			table.insert(slot0, slot3[1])

			return slot0
		end
	end), slot3
end

slot0.triggerCheck = function(slot0, slot1, slot2, slot3)
	if slot3[1] == FleetSkill.TriggerDDHead then
		return #slot1:GetTeamShipVOs(TeamType.Vanguard, false) > 0 and ShipType.IsTypeQuZhu(slot5[1]:getShipType())
	elseif slot4 == FleetSkill.TriggerVanCount then
		return slot3[2] <= #slot1:GetTeamShipVOs(TeamType.Vanguard, false) and #slot5 <= slot3[3]
	elseif slot4 == FleetSkill.TriggerShipCount then
		return slot3[3] <= #_.filter(slot1:GetShipVOs(false), function (slot0)
			return table.contains(uv0[2], slot0:getShipType())
		end) and #slot5 <= slot3[4]
	elseif slot4 == FleetSkill.TriggerAroundEnemy then
		slot5 = {
			row = slot1.row,
			column = slot1.column
		}
		slot6 = {}
		slot7 = slot3[2]

		for slot11 = -slot7, slot7 do
			slot12 = slot7 - math.abs(slot11)

			for slot16 = -slot12, slot12 do
				table.insert(slot6, slot0:GetCell(slot5.row + slot11, slot5.column + slot16))
			end
		end

		return underscore.any(slot6, function (slot0)
			slot1 = slot0:ExistEnemy() and slot0:GetStageEnemy().config.type or nil

			return type(uv0[3]) == "number" and uv0[3] == slot1 or type(uv0[3]) == "table" and table.contains(uv0[3], slot1)
		end)
	elseif slot4 == FleetSkill.TriggerNekoPos then
		slot5 = slot1:findCommanderBySkillId(slot2.id)

		for slot9, slot10 in pairs(slot1:getCommanders()) do
			if slot5.id == slot10.id and slot9 == slot3[2] then
				return true
			end
		end
	elseif slot4 == FleetSkill.TriggerAroundLand then
		slot5 = {
			row = slot1.row,
			column = slot1.column
		}
		slot6 = slot3[2]

		for slot10 = -slot6, slot6 do
			slot11 = slot6 - math.abs(slot10)

			for slot15 = -slot11, slot11 do
				if slot0:GetCell(slot5.row + slot10, slot5.column + slot15) and not slot0:IsWalkable(slot16, slot17) then
					return true
				end
			end
		end

		return false
	elseif slot4 == FleetSkill.TriggerAroundCombatAlly then
		slot5 = {
			row = slot1.row,
			column = slot1.column
		}

		return _.any(slot0.fleets, function (slot0)
			return uv0.id ~= slot0.id and slot0:GetFleetType() == FleetType.Normal and uv1:GetCell(slot0.line.row, slot0.line.column):ExistEnemy() and ManhattonDist(uv2, {
				row = slot0.line.row,
				column = slot0.line.column
			}) <= uv3[2]
		end)
	elseif slot4 == FleetSkill.TriggerInSubTeam then
		return true
	else
		assert(false, "invalid trigger type: " .. slot4)
	end
end

slot0.OnUpdateAttachmentExist = function(slot0, slot1, slot2, slot3)
	slot0.typeAttachments[slot4] = slot0.typeAttachments[slot3.type] or {}

	if slot1 == WorldMapCell.EventAddAttachment then
		table.insert(slot0.typeAttachments[slot4], slot3)
	elseif slot1 == WorldMapCell.EventRemoveAttachment then
		table.removebyvalue(slot0.typeAttachments[slot4], slot3)
	end

	if slot3:GetVisionRadius() > 0 then
		slot6 = 0

		if slot1 == WorldMapCell.EventAddAttachment then
			slot6 = slot6 + 1
		elseif slot1 == WorldMapCell.EventRemoveAttachment then
			slot6 = slot6 - 1
		else
			assert(false, "listener event error: " .. slot1)
		end

		slot0.centerCellFOV = {
			row = slot2.row,
			column = slot2.column
		}

		for slot10 = slot2.row - slot5, slot2.row + slot5 do
			for slot14 = slot2.column - slot5, slot2.column + slot5 do
				if slot0:GetCell(slot10, slot14) and WorldConst.InFOVRange(slot2.row, slot2.column, slot15.row, slot15.column, slot5) then
					slot15:ChangeInLight(slot6 > 0)
				end
			end
		end
	end

	if #slot3:GetRadiationBuffs() > 0 then
		slot7 = {}

		for slot11, slot12 in ipairs(slot6) do
			slot13, slot14, slot15 = unpack(slot12)

			if slot1 == WorldMapCell.EventAddAttachment then
				slot7[slot13] = true

				slot0:AddBuff(slot13, slot14, slot15)
			elseif slot1 == WorldMapCell.EventRemoveAttachment then
				slot7[slot13] = true

				slot0:RemoveBuff(slot13, slot14, slot15)
			end
		end

		for slot11, slot12 in pairs(slot7) do
			if slot12 then
				slot0:FlushFaction(slot11)
			end
		end
	end
end

slot0.GetBGM = function(slot0)
	return slot0.config.bgm
end

slot0.NeedClear = function(slot0)
	slot1, slot2 = slot0:GetEventPoisonRate()

	return slot2 > 0 and slot1 == 0 or slot0.clearFlag or slot0.config.is_clear > 0
end

slot0.GetBuff = function(slot0, slot1, slot2)
	if not slot0.factionBuffs[slot1][slot2] then
		slot0.factionBuffs[slot1][slot2] = WorldBuff.New()

		slot0.factionBuffs[slot1][slot2]:Setup({
			floor = 0,
			id = slot2
		})
	end

	return slot0.factionBuffs[slot1][slot2]
end

slot0.AddBuff = function(slot0, slot1, slot2, slot3)
	slot0:GetBuff(slot1, slot2):AddFloor(slot3)
end

slot0.RemoveBuff = function(slot0, slot1, slot2, slot3)
	slot4 = slot0:GetBuff(slot1, slot2)

	if slot3 then
		slot4:AddFloor(slot3 * -1)
	else
		slot0.factionBuffs[slot1][slot2] = nil
	end
end

slot0.GetBuffList = function(slot0, slot1, slot2)
	if slot1 == uv0.FactionSelf then
		return underscore.filter(underscore.values(slot0.factionBuffs[slot1]), function (slot0)
			return slot0:GetFloor() > 0
		end)
	elseif slot1 == uv0.FactionEnemy then
		if WorldMapAttachment.IsEnemyType(slot2.type) or slot2.type == WorldMapAttachment.TypeEvent and slot2:GetSpEventType() == WorldMapAttachment.SpEventEnemy then
			return underscore.filter(underscore.values(slot0.factionBuffs[slot1]), function (slot0)
				return slot0:GetFloor() > 0
			end)
		else
			return {}
		end
	else
		assert(false, string.format("faction error: $d", slot1))
	end
end

slot0.FlushFaction = function(slot0, slot1)
	if slot1 == uv0.FactionSelf then
		underscore.each(slot0:GetFleets(), function (slot0)
			slot0:DispatchEvent(WorldMapFleet.EventUpdateBuff)
		end)
	else
		if slot1 == uv0.FactionEnemy then
			underscore.each(slot0:FindEnemys(), function (slot0)
				uv0[WorldMapCell.GetName(slot0.row, slot0.column)] = true
			end)

			slot6 = WorldMapAttachment.TypeEvent

			underscore.each(slot0:FindAttachments(slot6), function (slot0)
				if slot0:GetSpEventType() == WorldMapAttachment.SpEventEnemy then
					uv0[WorldMapCell.GetName(slot0.row, slot0.column)] = true
				end
			end)

			for slot6 in pairs({}) do
				slot0.cells[slot6]:DispatchEvent(uv0.EventUpdateMapBuff)
			end

			return
		end

		assert(false, string.format("faction error: $d", slot1))
	end
end

slot0.GetBattleLuaBuffs = function(slot0, slot1, slot2)
	underscore.each(slot0:GetBuffList(slot1, slot2), function (slot0)
		if slot0.config.lua_id > 0 then
			table.insert(uv0, slot0.config.lua_id)
		end
	end)

	return {}
end

slot0.UpdateFleetLocation = function(slot0, slot1, slot2, slot3)
	slot4 = slot0:GetFleet(slot1)

	assert(slot4, "without this fleet : " .. slot1)

	if slot4.row ~= slot2 or slot4.column ~= slot3 then
		slot0:CheckFleetUpdateFOV(slot4, function ()
			uv0.row = uv1
			uv0.column = uv2
		end)
		slot4:DispatchEvent(WorldMapFleet.EventUpdateLocation)
	end
end

slot0.GetRangeDic = function(slot0, slot1)
	WorldConst.RangeCheck(slot1, slot0:GetFOVRange(slot1), function (slot0, slot1)
		if uv0.cells[WorldMapCell.GetName(slot0, slot1)] then
			uv1[slot2] = defaultValue(uv1[slot2], 0) + 1
		end
	end)

	return {}
end

slot0.CheckFleetUpdateFOV = function(slot0, slot1, slot2)
	if not slot0:IsValid() then
		slot2()

		return
	end

	slot3 = slot0:GetRangeDic(slot1)
	slot5 = slot0:IsFleetTerrainSairenFog(slot1)
	slot6 = slot0:CalcFleetSpeed(slot1)

	slot2()

	slot7 = slot0:GetRangeDic(slot1)
	slot8 = slot0:GetFleetTerrain(slot1) == WorldMapCell.TerrainFog
	slot9 = slot0:IsFleetTerrainSairenFog(slot1)
	slot10 = slot0:CalcFleetSpeed(slot1)
	slot0.centerCellFOV = {
		row = slot1.row,
		column = slot1.column
	}
	slot11 = false
	slot12 = false
	slot13 = {}

	if not (slot0:GetFleetTerrain(slot1) == WorldMapCell.TerrainFog) then
		for slot17, slot18 in pairs(slot3) do
			slot13[slot17] = defaultValue(slot13[slot17], 0) - slot18
		end
	end

	if not slot8 then
		for slot17, slot18 in pairs(slot7) do
			slot13[slot17] = defaultValue(slot13[slot17], 0) + slot18
		end
	end

	for slot17, slot18 in pairs(slot13) do
		if slot18 ~= 0 then
			slot0.cells[slot17]:ChangeInLight(slot18 > 0)

			slot11 = true
		end
	end

	if slot0:GetFleet() == slot1 then
		slot13 = {}

		if slot4 then
			for slot17, slot18 in pairs(slot3) do
				slot13[slot17] = defaultValue(slot13[slot17], 0) - slot18
			end
		end

		if slot8 then
			for slot17, slot18 in pairs(slot7) do
				slot13[slot17] = defaultValue(slot13[slot17], 0) + slot18
			end
		end

		if slot4 ~= slot8 or slot5 ~= slot9 then
			for slot17, slot18 in pairs(slot0.cells) do
				slot19 = nil

				if slot13[slot17] and slot13[slot17] ~= 0 then
					slot19 = slot13[slot17] > 0
				end

				slot18:UpdateFog(slot8, slot19, slot9)
			end

			slot11 = true
		else
			for slot17, slot18 in pairs(slot13) do
				if slot18 ~= 0 then
					slot0.cells[slot17]:UpdateFog(nil, slot18 > 0, nil)

					slot11 = true
				end
			end
		end

		if slot6 ~= slot10 then
			slot12 = true
		end
	end

	if slot11 then
		slot0:DispatchEvent(uv0.EventUpdateFleetFOV)
	end

	if slot12 then
		slot0:DispatchEvent(uv0.EventUpdateMoveSpeed)
	end
end

slot0.CheckSelectFleetUpdateFog = function(slot0, slot1)
	if not slot0:IsValid() then
		slot1()

		return
	end

	slot2 = slot0:GetFleet()
	slot3 = slot0:GetRangeDic(slot2)
	slot5 = slot0:IsFleetTerrainSairenFog(slot2)

	slot1()

	slot2 = slot0:GetFleet()
	slot6 = slot0:GetRangeDic(slot2)
	slot7 = slot0:GetFleetTerrain(slot2) == WorldMapCell.TerrainFog
	slot8 = slot0:IsFleetTerrainSairenFog(slot2)
	slot0.centerCellFOV = {
		row = slot2.row,
		column = slot2.column
	}
	slot9 = {}

	if slot0:GetFleetTerrain(slot2) == WorldMapCell.TerrainFog then
		for slot13, slot14 in pairs(slot3) do
			slot9[slot13] = defaultValue(slot9[slot13], 0) - slot14
		end
	end

	if slot7 then
		for slot13, slot14 in pairs(slot6) do
			slot9[slot13] = defaultValue(slot9[slot13], 0) + slot14
		end
	end

	if slot4 ~= slot7 or slot5 ~= slot8 then
		for slot13, slot14 in pairs(slot0.cells) do
			slot15 = nil

			if slot9[slot13] and slot9[slot13] ~= 0 then
				slot15 = slot9[slot13] > 0
			end

			slot14:UpdateFog(slot7, slot15, slot8)
		end
	else
		for slot13, slot14 in pairs(slot9) do
			if slot14 ~= 0 then
				slot0.cells[slot13]:UpdateFog(nil, slot14 > 0, nil)
			end
		end
	end

	slot0:DispatchEvent(uv0.EventUpdateFleetFOV)
end

slot0.CheckEventAutoTrigger = function(slot0, slot1)
	if slot1:GetSpEventType() == WorldMapAttachment.SpEventConsumeItem then
		return getProxy(SettingsProxy):GetWorldFlag("consume_item")
	end

	if slot1:GetEventEffect() then
		slot3 = slot0:GetFleet()

		if slot2.effect_type == WorldMapAttachment.EffectEventConsumeCarry then
			return not underscore.any(slot2.effect_paramater[1] or {}, function (slot0)
				return not uv0:ExistCarry(slot0)
			end)
		elseif slot4 == WorldMapAttachment.EffectEventCatSalvage then
			return slot3:GetDisplayCommander() and not slot3:IsCatSalvage()
		end
	end

	return true
end

slot0.CanAutoFight = function(slot0)
	if slot0.config.is_auto > 0 then
		for slot4 = 1, slot0.config.is_auto do
			if not nowWorld():IsSystemOpen(WorldConst["SystemAutoFight_" .. slot4]) then
				return false
			end
		end

		return true
	else
		return false
	end
end

slot0.CkeckTransport = function(slot0)
	assert(slot0:IsValid(), "without map info")

	if slot0.config.is_transfer == 0 then
		return false, i18n("world_transport_disable")
	end

	if slot0:CheckAttachmentTransport() == "block" then
		return false, i18n("world_movelimit_event_text")
	end

	if nowWorld():CheckTaskLockMap() then
		return false, i18n("world_task_maplock")
	end

	return true
end

return slot0

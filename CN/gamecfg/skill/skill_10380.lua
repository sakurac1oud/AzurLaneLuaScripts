return {
	uiEffect = "",
	name = "Z系先驱",
	cd = 0,
	picture = "0",
	desc = "Z系先驱",
	painting = 1,
	id = 10380,
	castCV = "skill",
	aniEffect = {
		effect = "jineng",
		offset = {
			0,
			-2,
			0
		}
	},
	effect_list = {
		{
			targetAniEffect = "",
			casterAniEffect = "",
			type = "BattleSkillAddBuff",
			target_choise = {
				"TargetAllHelp",
				"TargetShipTag"
			},
			arg_list = {
				buff_id = 10381,
				ship_tag_list = {
					"Z-Class"
				}
			}
		}
	}
}

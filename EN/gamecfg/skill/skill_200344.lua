return {
	uiEffect = "",
	name = "2023英系活动 审判机甲-战争 战争突刺！",
	cd = 0,
	picture = "0",
	aniEffect = "",
	desc = "瞬移",
	painting = 0,
	id = 200344,
	effect_list = {
		{
			type = "BattleSkillTeleport",
			target_choise = {},
			arg_list = {
				delay = 0.4,
				absoulteCorrdinate = {
					x = -10,
					z = 50
				}
			}
		},
		{
			type = "BattleSkillPlayFX",
			target_choise = {},
			arg_list = {
				delay = 0.1,
				effect = "shanshuo",
				casterRelativeCorrdinate = {
					vrt = 0,
					hrz = 0
				}
			}
		}
	}
}

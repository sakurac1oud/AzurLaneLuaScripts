return {
	uiEffect = "",
	name = "",
	cd = 0,
	picture = "0",
	desc = "",
	painting = 1,
	id = 600150,
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
			target_choise = "TargetSelf",
			type = "BattleSkillConsumeBuff",
			arg_list = {
				buff_id = 600141
			}
		},
		{
			target_choise = "TargetSelf",
			type = "BattleSkillConsumeBuff",
			arg_list = {
				buff_id = 600142
			}
		},
		{
			target_choise = "TargetSelf",
			type = "BattleSkillConsumeBuff",
			arg_list = {
				buff_id = 600153
			}
		},
		{
			targetAniEffect = "",
			casterAniEffect = "",
			type = "BattleSkillAddBuff",
			target_choise = {
				"TargetSelf"
			},
			arg_list = {
				buff_id = 600148
			}
		},
		{
			targetAniEffect = "",
			casterAniEffect = "",
			type = "BattleSkillAddBuff",
			target_choise = {
				"TargetSelf"
			},
			arg_list = {
				buff_id = 600149
			}
		}
	}
}

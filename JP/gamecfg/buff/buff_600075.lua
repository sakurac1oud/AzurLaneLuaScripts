return {
	time = 3,
	name = "",
	init_effect = "",
	picture = "",
	desc = "",
	stack = 99,
	id = 600075,
	icon = 600075,
	last_effect = "",
	effect_list = {
		{
			type = "BattleBuffCastSkill",
			trigger = {
				"onAttach",
				"onStack"
			},
			arg_list = {
				minTargetNumber = 1,
				skill_id = 600075,
				target = "TargetSelf",
				check_target = {
					"TargetSelf",
					"TargetShipTag"
				},
				ship_tag_list = {
					"zhongdu"
				}
			}
		}
	}
}

return {
	time = 0,
	name = "",
	init_effect = "",
	id = 60480,
	picture = "",
	desc = "",
	stack = 1,
	color = "red",
	icon = 60480,
	last_effect = "",
	effect_list = {
		{
			type = "BattleBuffAddBuff",
			trigger = {
				"onAttach"
			},
			arg_list = {
				buff_id = 60481,
				target = "TargetSelf"
			}
		}
	}
}

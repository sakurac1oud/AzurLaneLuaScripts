return {
	time = 0,
	name = "",
	init_effect = "",
	id = 800297,
	picture = "",
	desc = "",
	stack = 1,
	color = "red",
	icon = 800290,
	last_effect = "",
	effect_list = {
		{
			type = "BattleBuffCastSkill",
			trigger = {
				"onStartGame"
			},
			arg_list = {
				skill_id = 800297,
				dungeonTypeList = {
					98,
					99
				}
			}
		}
	}
}

return {
	time = 0,
	name = "为六花提供支援武装标记",
	init_effect = "",
	picture = "",
	desc = "标记-DRILL",
	stack = 1,
	id = 108092,
	icon = 108090,
	last_effect = "",
	effect_list = {
		{
			type = "BattleBuffAddTag",
			trigger = {
				"onAttach"
			},
			arg_list = {
				tag = "GRIDUP"
			}
		},
		{
			type = "BattleBuffAddTag",
			trigger = {
				"onAttach"
			},
			arg_list = {
				tag = "TWINGRIDBEAM"
			}
		}
	}
}

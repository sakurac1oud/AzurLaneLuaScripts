return {
	time = 0,
	name = "为六花提供支援武装标记",
	init_effect = "",
	picture = "",
	desc = "标记-SABER",
	stack = 1,
	id = 108072,
	icon = 108070,
	last_effect = "",
	effect_list = {
		{
			type = "BattleBuffAddTag",
			trigger = {
				"onAttach"
			},
			arg_list = {
				tag = "GRIDSABER"
			}
		},
		{
			type = "BattleBuffAddTag",
			trigger = {
				"onAttach"
			},
			arg_list = {
				tag = "GRIDUP2"
			}
		}
	}
}

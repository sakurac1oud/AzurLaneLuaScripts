return {
	{},
	{},
	{},
	{},
	{},
	{},
	{},
	{},
	{},
	{},
	desc_get = "",
	name = "装甲空母 +",
	init_effect = "",
	id = 1010340,
	time = 0,
	picture = "",
	desc = "",
	stack = 1,
	color = "yellow",
	icon = 10340,
	last_effect = "",
	effect_list = {
		{
			type = "BattleBuffCastSkill",
			trigger = {
				"onAllInStrike"
			},
			arg_list = {
				skill_id = 1010340,
				target = "TargetSelf"
			}
		},
		{
			type = "BattleBuffCastSkill",
			trigger = {
				"onAllInStrikeSteady"
			},
			arg_list = {
				skill_id = 1010342,
				target = "TargetSelf"
			}
		}
	}
}

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
	time = 1,
	name = "一心二用",
	init_effect = "",
	picture = "",
	desc = "概率触发器",
	stack = 2,
	id = 16132,
	icon = 16130,
	last_effect = "",
	effect_list = {
		{
			type = "BattleBuffCastSkill",
			trigger = {
				"onAttach",
				"onStack"
			},
			arg_list = {
				rant = 5000,
				skill_id = 16131,
				target = "TargetSelf"
			}
		}
	}
}

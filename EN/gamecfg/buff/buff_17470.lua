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
	name = "",
	init_effect = "",
	id = 17470,
	time = 0,
	picture = "",
	desc = "",
	stack = 1,
	color = "red",
	icon = 17470,
	last_effect = "",
	effect_list = {
		{
			type = "BattleBuffAddBuff",
			trigger = {
				"onHPRatioUpdate"
			},
			arg_list = {
				hpUpperBound = 0.5,
				buff_id = 17471,
				target = "TargetSelf",
				quota = 1
			}
		},
		{
			type = "BattleBuffCastSkill",
			trigger = {
				"onUpdate"
			},
			arg_list = {
				quota = 1,
				skill_id = 17471,
				time = 10,
				target = "TargetSelf"
			}
		},
		{
			type = "BattleBuffAddBuff",
			trigger = {
				"onUpdate"
			},
			arg_list = {
				buff_id = 17473,
				quota = 1,
				time = 10,
				target = "TargetSelf"
			}
		}
	}
}

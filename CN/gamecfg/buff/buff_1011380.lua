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
	name = "谢幕演出 +",
	init_effect = "",
	id = 1011380,
	time = 0,
	picture = "",
	desc = "",
	stack = 1,
	color = "red",
	icon = 11380,
	last_effect = "",
	effect_list = {
		{
			type = "BattleBuffCastSkill",
			trigger = {
				"onSubmarineRaid"
			},
			arg_list = {
				skill_id = 1011380,
				target = "TargetSelf"
			}
		},
		{
			type = "BattleBuffCastSkill",
			trigger = {
				"onSubmarineRetreat"
			},
			arg_list = {
				quota = 1,
				skill_id = 1011381,
				target = "TargetSelf"
			}
		}
	}
}

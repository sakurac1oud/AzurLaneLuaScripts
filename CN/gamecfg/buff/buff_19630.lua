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
	id = 19630,
	time = 0,
	picture = "",
	desc = "",
	stack = 1,
	color = "red",
	icon = 19630,
	last_effect = "",
	effect_list = {
		{
			type = "BattleBuffAddBuff",
			trigger = {
				"onStartGame"
			},
			pop = {},
			arg_list = {
				target = "TargetSelf",
				buff_id = 19631
			}
		},
		{
			type = "BattleBuffCastSkill",
			trigger = {
				"onStartGame"
			},
			arg_list = {
				minTargetNumber = 3,
				skill_id = 19630,
				check_target = {
					"TargetAllHelp",
					"TargetPlayerVanguardFleet"
				}
			}
		}
	}
}

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
	desc_get = "在队伍中(存活)时，队伍内所有驱逐、轻巡的雷击和装填属性提高3.0%（满级15.0%）",
	name = "水雷战队",
	init_effect = "",
	id = 1091,
	time = 0,
	picture = "",
	desc = "在队伍中(存活)时，队伍内所有驱逐、轻巡的雷击和装填属性提高3.0%（满级15.0%）",
	stack = 1,
	color = "yellow",
	icon = 1090,
	last_effect = "",
	effect_list = {
		{
			type = "BattleBuffCastSkill",
			trigger = {
				"onStartGame"
			},
			arg_list = {
				skill_id = 1091
			}
		},
		{
			type = "BattleBuffField",
			trigger = {},
			arg_list = {
				buff_id = 1090,
				shipType = 1,
				target = "TargetPlayerByType"
			}
		},
		{
			type = "BattleBuffField",
			trigger = {},
			arg_list = {
				buff_id = 1090,
				shipType = 2,
				target = "TargetPlayerByType"
			}
		},
		{
			type = "BattleBuffField",
			trigger = {},
			arg_list = {
				buff_id = 1090,
				shipType = 20,
				target = "TargetPlayerByType"
			}
		},
		{
			type = "BattleBuffField",
			trigger = {},
			arg_list = {
				buff_id = 1090,
				shipType = 21,
				target = "TargetPlayerByType"
			}
		}
	}
}

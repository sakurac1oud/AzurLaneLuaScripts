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
	id = 14985,
	time = 0,
	picture = "",
	desc = "",
	stack = 1,
	color = "red",
	icon = 14980,
	last_effect = "",
	effect_list = {
		{
			type = "BattleBuffCastSkill",
			trigger = {
				"onFoeDying"
			},
			arg_list = {
				quota = 4,
				killer = "self",
				target = "TargetSelf",
				skill_id = 14980
			}
		},
		{
			type = "BattleBuffCastSkill",
			trigger = {
				"onStartGame"
			},
			arg_list = {
				quota = 1,
				skill_id = 14985,
				streakRange = {
					1,
					100
				}
			}
		},
		{
			type = "BattleBuffCastSkill",
			trigger = {
				"onStartGame"
			},
			arg_list = {
				quota = 1,
				skill_id = 14985,
				streakRange = {
					2,
					100
				}
			}
		},
		{
			type = "BattleBuffCastSkill",
			trigger = {
				"onStartGame"
			},
			arg_list = {
				quota = 1,
				skill_id = 14985,
				streakRange = {
					3,
					100
				}
			}
		},
		{
			type = "BattleBuffCastSkill",
			trigger = {
				"onStartGame"
			},
			arg_list = {
				quota = 1,
				skill_id = 14985,
				streakRange = {
					4,
					100
				}
			}
		}
	}
}

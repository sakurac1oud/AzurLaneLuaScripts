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
	desc_get = "出击时，队伍中驱逐舰对巡洋舰伤害提升",
	name = "塔萨法隆格逆袭 +",
	init_effect = "",
	id = 1011360,
	time = 0,
	picture = "",
	desc = "出击时，队伍中驱逐舰对巡洋舰伤害提升",
	stack = 1,
	color = "yellow",
	icon = 11360,
	last_effect = "",
	effect_list = {
		{
			type = "BattleBuffCastSkill",
			trigger = {
				"onStartGame"
			},
			arg_list = {
				skill_id = 1011360
			}
		},
		{
			type = "BattleBuffCount",
			trigger = {
				"onFire"
			},
			arg_list = {
				countTarget = 5,
				countType = 1011360,
				index = {
					1
				}
			}
		},
		{
			type = "BattleBuffCastSkill",
			trigger = {
				"onBattleBuffCount"
			},
			arg_list = {
				skill_id = 1011361,
				target = "TargetSelf",
				countType = 1011360
			}
		}
	}
}

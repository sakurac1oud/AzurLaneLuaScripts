return {
	time = 0,
	name = "",
	init_effect = "",
	id = 15301,
	picture = "",
	desc = "副炮每进行4次攻击，触发弹幕",
	stack = 1,
	color = "red",
	icon = 15300,
	last_effect = "",
	effect_list = {
		{
			type = "BattleBuffCount",
			trigger = {
				"onFire"
			},
			arg_list = {
				countTarget = 4,
				countType = 15301,
				index = {
					2
				}
			}
		},
		{
			type = "BattleBuffCastSkill",
			trigger = {
				"onBattleBuffCount"
			},
			arg_list = {
				skill_id = 15300,
				target = "TargetSelf",
				countType = 15301
			}
		}
	}
}

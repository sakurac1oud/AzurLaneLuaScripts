return {
	init_effect = "",
	name = "2023俾斯麦Z活动 侵蚀等级3 不良效果",
	time = 1,
	picture = "",
	desc = "",
	stack = 1,
	id = 200408,
	last_effect = "",
	effect_list = {
		{
			type = "BattleBuffAddBuff",
			trigger = {
				"onAttach"
			},
			arg_list = {
				buff_id = 200410,
				maxTargetNumber = 0,
				check_target = {
					"TargetSelf",
					"TargetShipTag"
				},
				ship_tag_list = {
					"bisimaiztihuan"
				}
			}
		},
		{
			type = "BattleBuffAddBuff",
			trigger = {
				"onAttach"
			},
			arg_list = {
				buff_id = 200409,
				minTargetNumber = 1,
				check_target = {
					"TargetSelf",
					"TargetShipTag"
				},
				ship_tag_list = {
					"bisimaiztihuan"
				}
			}
		}
	}
}

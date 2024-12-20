pg = pg or {}
pg.dorm3d_resource = {
	[202201] = {
		ship_group = 20220,
		name = "シリアス",
		type = 1,
		animator = "",
		picture = "regular",
		unlock = "",
		unlock_text = "",
		model_id = "tianlangxing_noshoes",
		id = 202201,
		head_Icon = "dorm3Dchar/tianlangxing",
		unlock = {
			1,
			20220,
			1
		},
		tags = {}
	},
	[202202] = {
		ship_group = 20220,
		name = "シリアス・水着",
		type = 1,
		animator = "",
		picture = "regular",
		unlock_text = "シリアスをビーチ配置で開放",
		model_id = "tianlangxing_swim",
		id = 202202,
		head_Icon = "dorm3Dchar/tianlangxing",
		unlock = {
			1,
			20220,
			1
		},
		tags = {
			"beach",
			"touch"
		},
		unlock = {
			5,
			4,
			20220
		}
	},
	get_id_list_by_ship_group = {
		[20220] = {
			202201,
			202202
		}
	},
	all = {
		202201,
		202202
	}
}

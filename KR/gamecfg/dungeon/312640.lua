return {
	map_id = 10001,
	id = 312640,
	stages = {
		{
			stageIndex = 1,
			failCondition = 1,
			timeCount = 90,
			backGroundStageID = 1,
			passCondition = 1,
			totalArea = {
				-70,
				20,
				90,
				70
			},
			playerArea = {
				-70,
				20,
				37,
				68
			},
			enemyArea = {},
			fleetCorrdinate = {
				-80,
				0,
				75
			},
			waves = {
				{
					triggerType = 1,
					waveIndex = 100,
					preWaves = {},
					triggerParams = {
						timeout = 0.5
					}
				},
				{
					triggerType = 1,
					waveIndex = 202,
					preWaves = {},
					triggerParams = {
						timeout = 20
					}
				},
				{
					triggerType = 1,
					waveIndex = 203,
					preWaves = {},
					triggerParams = {
						timeout = 40
					}
				},
				{
					key = true,
					triggerType = 0,
					waveIndex = 101,
					conditionType = 1,
					preWaves = {
						100
					},
					triggerParam = {},
					spawn = {
						{
							score = 0,
							reinforceDelay = 12,
							delay = 0,
							moveCast = true,
							affix = true,
							monsterTemplateID = 296040,
							corrdinate = {
								0,
								0,
								55
							},
							bossData = {
								hpBarNum = 100,
								icon = "sairenzhanlie"
							},
							phase = {
								{
									switchParam = 8,
									switchTo = 1,
									index = 0,
									switchType = 1,
									setAI = 20006,
									addWeapon = {
										2031000,
										2031010,
										2031020
									}
								},
								{
									switchType = 1,
									switchTo = 2,
									index = 1,
									switchParam = 18,
									setAI = 10001
								},
								{
									switchParam = 240,
									switchTo = 0,
									index = 2,
									switchType = 1,
									setAI = 10001,
									removeWeapon = {
										2031000
									},
									addWeapon = {
										2031030
									}
								}
							}
						}
					},
					reinforcement = {
						{
							monsterTemplateID = 209201,
							score = 0,
							delay = 2,
							moveCast = true,
							corrdinate = {
								20,
								0,
								75
							},
							buffList = {
								8001,
								8007
							}
						},
						{
							monsterTemplateID = 209201,
							score = 0,
							delay = 2,
							moveCast = true,
							corrdinate = {
								20,
								0,
								35
							},
							buffList = {
								8001,
								8007
							}
						}
					},
					airFighter = {
						{
							interval = 10,
							onceNumber = 6,
							formation = 10003,
							templateID = 2200902,
							delay = 0,
							totalNumber = 30,
							weaponID = {},
							attr = {
								airPower = 40,
								maxHP = 15,
								attackRating = 23
							}
						}
					}
				},
				{
					triggerType = 8,
					waveIndex = 900,
					preWaves = {
						101
					},
					triggerParams = {}
				}
			}
		}
	},
	fleet_prefab = {}
}
